using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using System.Configuration;

public static class Database
{
    #region Common

    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
        }
    }

    public static SqlConnection CreateConnection()
    {
        var connection = new SqlConnection(ConnectionString);
        connection.Open();
        return connection;
    }

    public static SqlCommand CreateCommand(SqlConnection connection, string procedureName)
    {
        var command = connection.CreateCommand();
        command.CommandText = procedureName;
        command.CommandType = CommandType.StoredProcedure;
        command.Connection = connection;
        return command;
    }
    #endregion

    #region Registration

    public static PageLoadInfo GetPageLoadInfo()
    {
        var data = new PageLoadInfo();
        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "GetPageLoadInfo"))
            {
                using (var reader = command.ExecuteReader())
                {
                    data.Currencies = new List<CurrencyInfo>();
                    while (reader.Read())
                    {
                        data.Currencies.Add(new CurrencyInfo
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1),
                            Rate = (float)reader.GetDouble(2),
                            PaymentInfo = reader.GetString(3)
                        });
                    }
                    reader.NextResult();

                    data.Tricka = reader.GetListOfIdNames();
                    data.Zbory = reader.GetListOfIdNames();
                    data.Dobrovolnici = reader.GetListOfIdNameToolTips();

                    data.Sluziaci = new List<SluziaciInfo>();
                    while (reader.Read())
                    {
                        data.Sluziaci.Add(new SluziaciInfo
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1),
                            ToolTip = reader.GetStringNull(2),
                            FreeRegistration = reader.GetBoolean(3),
                            FreeTeeShirt = reader.GetBoolean(4),
                            FreeMikina = reader.GetBoolean(5),
                            FreeFood = reader.GetBoolean(6),
                            FreeDorm = reader.GetBoolean(7),
                            Allowed = reader.GetBoolean(8),
                            IsPublic = reader.GetBoolean(9)
                        });
                    }
                    reader.NextResult();

                    data.Poplatky = new List<PoplatokInfo>();
                    while (reader.Read())
                    {
                        data.Poplatky.Add(new PoplatokInfo
                        {
                            Id = reader.GetInt32(0),
                            From = reader.GetDateTimeNull(1),
                            To = reader.GetDateTimeNull(2),
                            Amount = (float)reader.GetDecimal(3),
                            Online = reader.GetBoolean(4),
                            Comment = reader.GetString(5)
                        });
                    }
                    reader.NextResult();
                }
            }
        }
        return data;
    }

    public static RegistrationResult WriteData(List<RegistrationEntry> data, List<Email> emails,
        string payerEmail, float donation, CurrencyInfo currency)
    {
        var success = false;
        var badEmails = new List<string>();

        using (var transaction = new TransactionScope())
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand(connection, "AddUsers4"))
                {
                    command.AddParameterUserDefined("@users", "dbo.ListOfUsers4", RegistrationEntry.GetDataTable(data));
                    command.AddParameterUserDefined("@emails", "dbo.ListOfEmails", Email.GetDataTable(emails));
                    command.AddParameterString("@payerEmail", payerEmail);
                    command.AddParameterFloat("@donation", donation);
                    command.AddParameterInt("@idCurrency", currency.Id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            success = reader.GetInt32(0) > 0;
                        }
                        reader.NextResult();

                        if (!success)
                        {
                            while (reader.Read())
                            {
                                badEmails.Add(reader.GetString(0));
                            }
                        }
                    }
                }
            }
            transaction.Complete();
        }

        return new RegistrationResult
        {
            Success = success,
            AlreadyRegisteredEmails = badEmails
        };
    }
    #endregion

    #region Sports

    public static void RegisterSportsTeam(int idSport, string name,
        string player1, string player2, string player3, string player4, string player5, string player6, string player7)
    {
        using (var transaction = new TransactionScope())
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand(connection, "AddTeam"))
                {
                    command.AddParameterInt("@idSport", idSport);

                    command.AddParameterString("@name", name);
                    command.AddParameterString("@player1", player1);
                    command.AddParameterString("@player2", player2);
                    command.AddParameterString("@player3", player3);
                    command.AddParameterString("@player4", player4);
                    command.AddParameterString("@player5", player5);
                    command.AddParameterString("@player6", player6);
                    command.AddParameterString("@player7", player7);

                    command.ExecuteNonQuery();
                }
            }
            transaction.Complete();
        }
    }
    #endregion

    #region Summary

    public static SummaryData GetSummary()
    {
        var result = new SummaryData
        {
            Tricka = new List<TeeShirtInfo>(),
            Mikiny = new List<TeeShirtInfo>(),
            Sluziaci = new List<NameCount>(),
            Dobrovolnici = new List<NameCount>(),
            Poznamky = new List<NoteInfo>(),
            Churches = new List<NameCount>()
        };

        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "GetSummary"))
            {
                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        var i = 0;
                        result.TotalPeople = reader.GetInt32(i++);
                        result.PiatokVecera = reader.GetInt32(i++);
                        result.PiatokVeceraZaplatene = reader.GetInt32(i++);
                        result.PiatokVecera2 = reader.GetInt32(i++);
                        result.PiatokVecera2Zaplatene = reader.GetInt32(i++);
                        result.TichaTriedaPiatokSobota = reader.GetInt32(i++);
                        result.SobotaRanajky = reader.GetInt32(i++);
                        result.SobotaRanajkyZaplatene = reader.GetInt32(i++);
                        result.SobotaObed = reader.GetInt32(i++);
                        result.SobotaObedZaplatene = reader.GetInt32(i++);
                        result.SobotaVecera = reader.GetInt32(i++);
                        result.SobotaVeceraZaplatene = reader.GetInt32(i++);
                        result.SobotaVecera2 = reader.GetInt32(i++);
                        result.SobotaVecera2Zaplatene = reader.GetInt32(i++);
                        result.TichaTriedaSobotaNedela = reader.GetInt32(i++);
                        result.NedelaRanajky = reader.GetInt32(i++);
                        result.NedelaRanajkyZaplatene = reader.GetInt32(i++);
                        result.NedelaObed = reader.GetInt32(i++);
                        result.NedelaObedZaplatene = reader.GetInt32(i++);
                        result.Sach = reader.GetInt32(i++);
                        result.PingPong = reader.GetInt32(i++);
                        result.InternatPiatokSobota1 = reader.GetInt32(i++);
                        result.InternatPiatokSobotaZaplatene1 = reader.GetInt32(i++);
                        result.InternatSobotaNedela1 = reader.GetInt32(i++);
                        result.InternatSobotaNedelaZaplatene1 = reader.GetInt32(i++);
                        result.InternatPiatokSobota2 = reader.GetInt32(i++);
                        result.InternatPiatokSobotaZaplatene2 = reader.GetInt32(i++);
                        result.InternatSobotaNedela2 = reader.GetInt32(i++);
                        result.InternatSobotaNedelaZaplatene2 = reader.GetInt32(i++);
                    }
                    reader.NextResult();

                    result.Tricka = ReadTricka(reader);
                    result.Mikiny = ReadTricka(reader);

                    if (reader.Read()) result.ExpectingEur = reader.GetFloatNull(0) ?? 0;
                    reader.NextResult();

                    if (reader.Read()) result.MoneyFromPeople = reader.GetFloatNull(0) ?? 0;
                    reader.NextResult();

                    int total = 0;
                    while (reader.Read())
                    {
                        var count = reader.GetInt32(1);
                        result.Sluziaci.Add(new NameCount { Name = reader.GetString(0), Count = count });
                        total += count;
                    }
                    result.Sluziaci.Add(new NameCount { Name = "Spolu", Count = total });
                    reader.NextResult();

                    total = 0;
                    while (reader.Read())
                    {
                        var count = reader.GetInt32(1);
                        result.Dobrovolnici.Add(new NameCount { Name = reader.GetStringNull(0), Count = count });
                        total += count;
                    }
                    result.Dobrovolnici.Add(new NameCount { Name = "Spolu", Count = total });
                    reader.NextResult();

                    while (reader.Read())
                    {
                        result.Poznamky.Add(new NoteInfo { Note = reader.GetString(0) });
                    }
                    reader.NextResult();

                    while (reader.Read())
                    {
                        result.Churches.Add(new NameCount
                        {
                            Name = reader.GetString(0),
                            Count = reader.GetInt32(1)
                        });
                    }
                }
            }
        }
        return result;
    }

    public static List<TeeShirtInfo> ReadTricka(SqlDataReader reader)
    {
        var result = new List<TeeShirtInfo>();

        int totalOrdered = 0;
        while (reader.Read())
        {
            var ordered = reader.GetInt32(1);
            result.Add(new TeeShirtInfo
            {
                Name = reader.GetString(0),
                Ordered = ordered
            });
            totalOrdered += ordered;
        }
        reader.NextResult();

        int totalPaid = 0;
        while (reader.Read())
        {
            var name = reader.GetString(0);
            var paid = reader.GetInt32(1);
            var tee = result.First(x => x.Name == name);
            if (tee != null) tee.Paid = paid;
            totalPaid += paid;
        }
        reader.NextResult();

        result.Add(new TeeShirtInfo
        {
            Name = "Spolu",
            Ordered = totalOrdered,
            Paid = totalPaid
        });

        return result;
    }

    #endregion
}