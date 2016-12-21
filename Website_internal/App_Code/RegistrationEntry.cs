using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

[Serializable]
public class RegistrationEntry
{
    public RegistrationEntry()
    {
        
    }

    public RegistrationEntry(RegistrationEntry source)
    {
        IdZbor = source.IdZbor;
        InyZbor = source.InyZbor;
    }
    
    public int? Id { get; set; }
    public string Meno { get; set; }
    public string Priezvisko { get; set; }
    public string Email { get; set; }
    public string Telefon { get; set; }
    public int IdZbor { get; set; }
    public string InyZbor { get; set; }
    public bool PiatokVecera { get; set; }
    public bool PiatokVecera2 { get; set; }
    public bool TichaTriedaPiatokSobota { get; set; }
    public bool SobotaRanajky { get; set; }
    public bool SobotaObed { get; set; }
    public bool SobotaVecera { get; set; }
    public bool SobotaVecera2 { get; set; }
    public bool TichaTriedaSobotaNedela { get; set; }
    public bool NedelaRanajky { get; set; }
    public bool NedelaObed { get; set; }
    public int Ranajky { get { return (SobotaRanajky ? 1 : 0) + (NedelaRanajky ? 1 : 0); } }
    public int Obedy { get { return (SobotaObed ? 1 : 0) + (NedelaObed ? 1 : 0); } }
    public int Vecere { get { return (PiatokVecera ? 1 : 0) + (SobotaVecera ? 1 : 0); } }
    public int Vecere2 { get { return (PiatokVecera2 ? 1 : 0) + (SobotaVecera2 ? 1 : 0); } }
    public bool Sach { get; set; }
    public bool PingPong { get; set; }
    public int IdTricko { get; set; }
    public string Tricko { get; set; }
    public int IdSluziaci { get; set; }
    public int IdDobrovolnik { get; set; }
    public string Poznamka { get; set; }

    public bool Single { get; set; }
    public CurrencyInfo Currency { get; set; }
    public List<string> Errors { get; set; }
    public string ErrorString { get { return Errors == null || Errors.Count == 0 ? "OK" : string.Join("<br/>", Errors); } }
    public bool Valid { get { return Errors != null && Errors.Count == 0; } }
    public string CssClass { get { return Errors != null && Errors.Count == 0 ? "valid" : "error"; } }
    public string CostString { get; set; }

    public float GetRegistrationFee(List<PoplatokInfo> poplatky)
    {
        float registracny = 0;
        var now = DateTime.UtcNow;
        foreach (var poplatok in poplatky)
        {
            if ((poplatok.From == null || poplatok.From <= now) && now <= poplatok.To)
            {
                registracny = poplatok.Amount;
            }
        }
        return registracny;
    }

    public float GetCost(List<SluziaciInfo> sluziaci, List<PoplatokInfo> poplatky)
    {
        float registracny = GetRegistrationFee(poplatky);
        float tricko = IdTricko != 0 ? Prices.Tricko : 0;
        float strava = 0;
        if (PiatokVecera) strava += Prices.Vecera;
        if (PiatokVecera2) strava += Prices.Vecera2;
        if (SobotaRanajky) strava += Prices.Ranajky;
        if (SobotaObed) strava += Prices.Obed;
        if (SobotaVecera) strava += Prices.Vecera;
        if (SobotaVecera2) strava += Prices.Vecera2;
        if (NedelaRanajky) strava += Prices.Ranajky;
        if (NedelaObed) strava += Prices.Obed;

        if (IdSluziaci != 0 && sluziaci.Any(x => x.Id == IdSluziaci))
        {
            var sluziaci2 = sluziaci.First(x => x.Id == IdSluziaci);
            if (sluziaci2.FreeFood) strava = 0;
            if (sluziaci2.FreeRegistration) registracny = 0;
            if (sluziaci2.FreeTeeShirt) tricko = 0;
        }
        return registracny + strava + tricko;
    }

    public string Title
    {
        get
        {
            if (string.IsNullOrWhiteSpace(Meno) && string.IsNullOrWhiteSpace(Priezvisko))
            {
                return string.Format("Účastník {0}", Id + 1);
            }
            return Meno + " " + Priezvisko;
        }
    }

    public static DataTable GetDataTable(List<RegistrationEntry> data)
    {
        var dt = new DataTable("Users");

        var colMeno = new DataColumn("Meno", typeof(string));
        var colPriezvisko = new DataColumn("Priezvisko", typeof(string));
        var colEmail = new DataColumn("Email", typeof(string));
        var colTelefon = new DataColumn("Telefon", typeof(string));
        var colIdZbor = new DataColumn("IdZbor", typeof(int));
        var colInyZbor = new DataColumn("InyZbor", typeof(string));
        var colPiatokVecera = new DataColumn("PiatokVecera", typeof(bool));
        var colPiatokVecera2 = new DataColumn("PiatokVecera2", typeof(bool));
        var colTichaTriedaPiatokSobota = new DataColumn("TichaTriedaPiatokSobota", typeof(bool));
        var colSobotaRanajky = new DataColumn("SobotaRanajky", typeof(bool));
        var colSobotaObed = new DataColumn("SobotaObed", typeof(bool));
        var colSobotaVecera = new DataColumn("SobotaVecera", typeof(bool));
        var colSobotaVecera2 = new DataColumn("SobotaVecera2", typeof(bool));
        var colTichaTriedaSobotaNedela = new DataColumn("TichaTriedaSobotaNedela", typeof(bool));
        var colNedelaRanajky = new DataColumn("NedelaRanajky", typeof(bool));
        var colNedelaObed = new DataColumn("NedelaObed", typeof(bool));
        var colSach = new DataColumn("Sach", typeof(bool));
        var colPingPong = new DataColumn("PingPong", typeof(bool));
        var colIdTricko = new DataColumn("IdTricko", typeof(int));
        var colPoznamka = new DataColumn("Poznamka", typeof(string));
        var colIdSluziaci = new DataColumn("IdSluziaci", typeof(int));
        var colIdDobrovolnik = new DataColumn("IdDobrovolnik", typeof(int));

        dt.Columns.Add(colMeno);
        dt.Columns.Add(colPriezvisko);
        dt.Columns.Add(colEmail);
        dt.Columns.Add(colTelefon);
        dt.Columns.Add(colIdZbor);
        dt.Columns.Add(colInyZbor);
        dt.Columns.Add(colPiatokVecera);
        dt.Columns.Add(colPiatokVecera2);
        dt.Columns.Add(colTichaTriedaPiatokSobota);
        dt.Columns.Add(colSobotaRanajky);
        dt.Columns.Add(colSobotaObed);
        dt.Columns.Add(colSobotaVecera);
        dt.Columns.Add(colSobotaVecera2);
        dt.Columns.Add(colTichaTriedaSobotaNedela);
        dt.Columns.Add(colNedelaRanajky);
        dt.Columns.Add(colNedelaObed);
        dt.Columns.Add(colSach);
        dt.Columns.Add(colPingPong);
        dt.Columns.Add(colIdTricko);
        dt.Columns.Add(colPoznamka);
        dt.Columns.Add(colIdSluziaci);
        dt.Columns.Add(colIdDobrovolnik);

        foreach (var entry in data)
        {
            var row = dt.NewRow();

            row[colMeno] = entry.Meno;
            row[colPriezvisko] = entry.Priezvisko;
            row[colEmail] = entry.Email;
            row[colTelefon] = entry.Telefon;
            row[colIdZbor] = entry.IdZbor > 0 ? entry.IdZbor : (object)DBNull.Value;
            row[colInyZbor] = entry.InyZbor;
            row[colPiatokVecera] = entry.PiatokVecera;
            row[colPiatokVecera2] = entry.PiatokVecera2;
            row[colTichaTriedaPiatokSobota] = entry.TichaTriedaPiatokSobota;
            row[colSobotaRanajky] = entry.SobotaRanajky;
            row[colSobotaObed] = entry.SobotaObed;
            row[colSobotaVecera] = entry.SobotaVecera;
            row[colSobotaVecera2] = entry.SobotaVecera2;
            row[colTichaTriedaSobotaNedela] = entry.TichaTriedaSobotaNedela;
            row[colNedelaRanajky] = entry.NedelaRanajky;
            row[colNedelaObed] = entry.NedelaObed;
            row[colSach] = entry.Sach;
            row[colPingPong] = entry.PingPong;
            row[colIdTricko] = entry.IdTricko > 0 ? entry.IdTricko : (object)DBNull.Value;
            row[colPoznamka] = entry.Poznamka;
            row[colIdSluziaci] = entry.IdSluziaci > 0 ? entry.IdSluziaci : (object)DBNull.Value;
            row[colIdDobrovolnik] = entry.IdDobrovolnik > 0 ? entry.IdDobrovolnik : (object)DBNull.Value;

            dt.Rows.Add(row);
        }
        return dt;
    }
}
