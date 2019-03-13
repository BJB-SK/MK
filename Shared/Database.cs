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

    #region Emails

    public static List<Email> GetEmails()
    {
        var result = new List<Email>();
        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "GetEmails"))
            {
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var id = reader.GetInt32(0);
                        var address = reader.GetString(1);
                        var subject = reader.GetString(2);
                        var body = reader.GetString(3);
                        int? variabilny = reader.GetInt32Null(4);
                        if (variabilny.HasValue) body = string.Format(body, variabilny.Value);
                        result.Add(new Email(id, address, subject, body));
                    }
                }
            }
        }
        return result;
    }

    public static DataTable GetDataTable(List<Email> data)
    {
        var dt = new DataTable("Emails");

        var colId = new DataColumn("id", typeof(int));
        var colAddress = new DataColumn("address", typeof(string));
        var colSubject = new DataColumn("subject", typeof(string));
        var colBody = new DataColumn("body", typeof(string));
        var colSuccess = new DataColumn("success", typeof(bool));
        var colResult = new DataColumn("result", typeof(string));

        dt.Columns.Add(colId);
        dt.Columns.Add(colAddress);
        dt.Columns.Add(colSubject);
        dt.Columns.Add(colBody);
        dt.Columns.Add(colSuccess);
        dt.Columns.Add(colResult);

        foreach (var entry in data)
        {
            var row = dt.NewRow();

            row[colId] = entry.Id;
            row[colSuccess] = entry.Success;
            row[colResult] = entry.Result;

            dt.Rows.Add(row);
        }
        return dt;
    }

    public static void UpdateEmails(List<Email> emails)
    {
        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "UpdateEmails"))
            {
                command.AddParameterUserDefined("@emails", "dbo.ListOfEmails", GetDataTable(emails));
                command.ExecuteNonQuery();
            }
        }
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

                    data.Churches = reader.GetListOfIdNames();

                    data.Fees = new List<FeeInfo>();
                    while (reader.Read())
                    {
                        data.Fees.Add(new FeeInfo
                        {
                            Id = reader.GetInt32(0),
                            From = reader.GetDateTimeNull(1),
                            To = reader.GetDateTimeNull(2),
                            Amount = (float)reader.GetDecimal(3),
                            Online = reader.GetBoolean(4),
                            Comment = reader.GetString(5),
                            Code = reader.GetString(6)
                        });
                    }
                    reader.NextResult();

                    data.Jobs = new List<JobInfo>();
                    while (reader.Read())
                    {
                        data.Jobs.Add(new JobInfo
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1),
                            ToolTip = reader.GetStringNull(2),
                            Allowed = reader.GetBoolean(3),
                            IsPublic = reader.GetBoolean(4),
                            FreeCategories = new List<int>(),
                        });
                    }
                    reader.NextResult();

                    while (reader.Read())
                    {
                        var idJob = reader.GetInt32(0);
                        var idCategory = reader.GetInt32(1);
                        var foundJob = data.Jobs.FirstOrDefault(x => x.Id == idJob);
                        if (foundJob != null)
                        {
                            foundJob.FreeCategories.Add(idCategory);
                        }
                    }
                    reader.NextResult();

                    data.Products = new List<Product>();
                    while (reader.Read())
                    {
                        var i = 0;
                        data.Products.Add(new Product
                        {
                            Id = reader.GetInt32(i++),
                            Name = reader.GetString(i++),
                            Price = (float)reader.GetDecimal(i++),
                            Available = reader.GetInt32Null(i++),
                            Code = reader.GetString(i++),
                            IdCategory = reader.GetInt32(i++),
                            Ordered = reader.GetInt32(i++),
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
                using (var command = CreateCommand(connection, "AddUsers"))
                {
                    for(var i = 0; i < data.Count; i++)
                    {
                        data[i].IdFrontend = i;
                    }
                    command.AddParameterUserDefined("@users", "dbo.ListOfUsers", RegistrationEntry.GetUserDataTable(data));
                    command.AddParameterUserDefined("@products", "dbo.ListOfProducts", RegistrationEntry.GetProductDataTable(data));
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
            Products = new List<ProductInfo>(),
            Jobs = new List<NameCount>(),
            Notes = new List<NoteInfo>(),
            Churches = new List<NameCount>()
        };

        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "GetSummary"))
            {
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        result.Products.Add(new ProductInfo
                        {
                            Name = reader.GetString(0),
                            Available = reader.GetInt32Null(1),
                            Ordered = reader.GetInt32(2),
                            Paid = reader.GetInt32(3),
                        });
                    }
                    reader.NextResult();

                    if (reader.Read()) result.TotalPeople = reader.GetInt32(0);
                    reader.NextResult();

                    if (reader.Read()) result.ShowedUp = reader.GetInt32(0);
                    reader.NextResult();

                    if (reader.Read()) result.ExpectingEur = reader.GetFloatNull(0) ?? 0;
                    reader.NextResult();

                    if (reader.Read()) result.MoneyFromPeople = reader.GetFloatNull(0) ?? 0;
                    reader.NextResult();

                    var total = 0;
                    while (reader.Read())
                    {
                        var count = reader.GetInt32(1);
                        result.Jobs.Add(new NameCount
                        {
                            Name = reader.GetStringNull(0),
                            Count = count,
                            Max = reader.GetInt32Null(2),
                        });
                        total += count;
                    }
                    result.Jobs.Add(new NameCount { Name = "Spolu", Count = total });
                    reader.NextResult();

                    while (reader.Read())
                    {
                        result.Notes.Add(new NoteInfo { Note = reader.GetString(0) });
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

    #region Detail

    public static DetailData GetDetail(int idAttendee)
    {
        var data = new DetailData();

        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "GetDetail"))
            {
                command.AddParameterInt("@idAttendee", idAttendee);

                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        var i = 0;
                        data.Id = reader.GetInt32(i++);
                        data.FirstName = reader.GetString(i++);
                        data.LastName = reader.GetString(i++);
                        data.Email = reader.GetString(i++);
                        data.PhoneNumber = reader.GetString(i++);
                        data.IdChurch = reader.GetInt32Null(i++);
                        data.OtherChurch = reader.GetStringNull(i++);
                        data.Note = reader.GetString(i++);
                        data.DtRegistered = reader.GetDateTimeNull(i++);
                        data.DtShowedUp = reader.GetDateTimeNull(i++);
                        data.IdJob = reader.GetInt32Null(i++);
                        data.DtPlatba = reader.GetDateTimeNull(i++);
                        data.Paid = (float)reader.GetDecimal(i++);
                        data.Costs = (float)reader.GetDecimal(i++);
                        data.Donation = (float)reader.GetDecimal(i++);
                        data.Surplus = (float)reader.GetDecimal(i++);
                        data.ExtraFee = reader.GetFloatNull(i++);
                    }
                    reader.NextResult();

                    data.Products = new List<Product>();
                    while (reader.Read())
                    {
                        var i = 0;
                        data.Products.Add(new Product
                        {
                            Id = reader.GetInt32(i++),
                            Name = reader.GetString(i++),
                            Price = (float)reader.GetDecimal(i++),
                            Available = reader.GetInt32Null(i++),
                            Code = reader.GetString(i++),
                            IdCategory = reader.GetInt32(i++),
                            Ordered = reader.GetInt32(i++),
                        });
                    }
                    reader.NextResult();

                    while (reader.Read())
                    {
                        var idMapping = reader.GetInt32(0);
                        var idProduct = reader.GetInt32(1);
                        var foundProduct = data.Products.FirstOrDefault(x => x.Id == idProduct);
                        if (foundProduct != null)
                        {
                            foundProduct.IsOrdered = true;
                            foundProduct.IdMapping = idMapping;
                        }
                    }

                    data.Group = reader.GetListOfIdNames();
                    reader.NextResult();
                }
            }
        }
        return data;
    }

    public static int? RegisterNewUser(DetailData data)
    {
        int? idUser;
        using (var transaction = new TransactionScope())
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand(connection, "AddUser"))
                {
                    command.AddParameterString("@firstName", data.FirstName);
                    command.AddParameterString("@lastName", data.LastName);
                    command.AddParameterString("@email", data.Email);
                    command.AddParameterString("@phoneNumber", data.PhoneNumber);
                    command.AddParameterInt("@idChurch", data.IdChurch);
                    command.AddParameterString("@otherChurch", data.OtherChurch);
                    command.AddParameterInt("@idJob", data.IdJob);
                    command.AddParameterString("@note", data.Note);
                    command.AddParameterFloat("@donation", data.Donation);
                    command.AddParameterFloat("@extraFee", data.ExtraFee);
                    command.AddParameterUserDefined("@products", "dbo.ListOfInts", Utils.GetListOfIntsDataTable("Products", data.OrderedProducts));
                    command.AddOutputParameterInt("@newId");

                    command.ExecuteNonQuery();

                    idUser = command.Parameters["@newId"].Value as int?;
                }
            }
            transaction.Complete();
        }
        return idUser;
    }

    public static void UpdateUser(DetailData data)
    {
        using (var transaction = new TransactionScope())
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand(connection, "UpdateUser"))
                {
                    command.AddParameterInt("@idAttendee", data.Id);
                    command.AddParameterString("@firstName", data.FirstName);
                    command.AddParameterString("@lastName", data.LastName);
                    command.AddParameterString("@email", data.Email);
                    command.AddParameterString("@phoneNumber", data.PhoneNumber);
                    command.AddParameterInt("@idChurch", data.IdChurch);
                    command.AddParameterString("@otherChurch", data.OtherChurch);
                    command.AddParameterInt("@idJob", data.IdJob);
                    command.AddParameterString("@note", data.Note);
                    command.AddParameterFloat("@extraFee", data.ExtraFee);
                    command.AddParameterUserDefined("@products", "dbo.ListOfInts", Utils.GetListOfIntsDataTable("Products", data.OrderedProducts));

                    command.ExecuteNonQuery();
                }
            }
            transaction.Complete();
        }
    }
    #endregion

    #region List

    public static FilterData GetFilter()
    {
        var result = new FilterData();

        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "GetFilter"))
            {
                using (var reader = command.ExecuteReader())
                {
                    result.Churches = reader.GetListOfIdNames();
                    result.Products = reader.GetListOfIdNames();
                    result.Jobs = reader.GetListOfIdNames();
                }
            }
        }
        return result;
    }

    public static List<UserSummary> GetList(string name, int idChurch, int idProduct, int idJob, string from, string to, bool arrived, bool notArrived)
    {
        var result = new List<UserSummary>();

        using (var connection = CreateConnection())
        {
            using (var command = CreateCommand(connection, "GetList"))
            {
                command.AddParameterString("@name", name);
                command.AddParameterInt("@idChurch", idChurch);
                command.AddParameterInt("@idProduct", idProduct);
                command.AddParameterInt("@idJob", idJob);
                command.AddParameterString("@from", from);
                command.AddParameterString("@to", to);
                command.AddParameterBool("@arrived", arrived);
                command.AddParameterBool("@notArrived", notArrived);

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        result.Add(new UserSummary
                        {
                            Id = reader.GetInt32(0),
                            IdAccount = reader.GetInt32(1),
                            FirstName = reader.GetStringNull(2),
                            LastName = reader.GetStringNull(3),
                            Church = reader.GetStringNull(4),
                            Surplus = reader.GetFloatNull(5) ?? 0,
                            ShowedUp = reader.GetDateTimeNull(6) != null
                        });
                    }
                }
            }
        }
        return result;
    }
    #endregion

    public static void AddDonation(int idUser, float amount)
    {
        using (var transaction = new TransactionScope())
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand(connection, "AddDonation"))
                {
                    command.AddParameterInt("@idUser", idUser);
                    command.AddParameterFloat("@amount", amount);

                    command.ExecuteNonQuery();
                }
            }
            transaction.Complete();
        }
    }

    public static void ShowedUp(int idAttendee)
    {
        using (var transaction = new TransactionScope())
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand(connection, "ShowedUp"))
                {
                    command.AddParameterInt("@idAttendee", idAttendee);

                    command.ExecuteNonQuery();
                }
            }
            transaction.Complete();
        }
    }

    public static void AddPayment(int idUser, float amount, string note)
    {
        using (var transaction = new TransactionScope())
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand(connection, "AddPayment"))
                {
                    command.AddParameterInt("@idUser", idUser);
                    command.AddParameterFloat("@amount", amount);
                    command.AddParameterString("@note", note);

                    command.ExecuteNonQuery();
                }
            }
            transaction.Complete();
        }
    }
}