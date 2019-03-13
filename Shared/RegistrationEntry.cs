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
        Codes = new List<string>();
    }

    public RegistrationEntry(RegistrationEntry source)
    {
        Codes = new List<string>();
        IdChurch = source.IdChurch;
        OtherChurch = source.OtherChurch;
    }
    
    public int? Id { get; set; }
    public int? IdFrontend { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string PhoneNumber { get; set; }
    public int? IdChurch { get; set; }
    public string OtherChurch { get; set; }
    public int? IdJob { get; set; }
    public string Note { get; set; }

    public List<string> Codes { get; set; }
    public bool Single { get; set; }
    public CurrencyInfo Currency { get; set; }
    public List<string> Errors { get; set; }
    public string ErrorString { get { return Errors == null || Errors.Count == 0 ? "OK" : string.Join("<br/>", Errors); } }
    public bool Valid { get { return Errors != null && Errors.Count == 0; } }
    public string CssClass { get { return Errors != null && Errors.Count == 0 ? "valid" : "error"; } }
    public string CostString { get; set; }

    public string Title
    {
        get
        {
            if (string.IsNullOrWhiteSpace(FirstName) && string.IsNullOrWhiteSpace(LastName))
            {
                return string.Format("Účastník {0}", Id + 1);
            }
            return FirstName + " " + LastName;
        }
    }
    public float GetRegistrationFee(List<FeeInfo> poplatky)
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

    public float GetCost(PageLoadInfo data)
    {
        float sum = GetRegistrationFee(data.Fees);
        var job = new JobInfo();
        if (IdJob != 0 && data.Jobs.Any(x => x.Id == IdJob))
        {
            job = data.Jobs.First(x => x.Id == IdJob);
        }
        foreach (var code in Codes)
        {
            var foundProduct = data.Products.FirstOrDefault(x => x.Code == code);
            if (foundProduct != null)
            {
                if (job.FreeCategories == null || !job.FreeCategories.Contains(foundProduct.IdCategory))
                {
                    sum += foundProduct.Price;
                }
            }
        }
        return sum;
    }

    public static DataTable GetUserDataTable(List<RegistrationEntry> data)
    {
        var dt = new DataTable("Users");

        var colIdFrontend = new DataColumn("idFrontend", typeof(int));
        var colFirstName = new DataColumn("firstName", typeof(string));
        var colLastName = new DataColumn("lastName", typeof(string));
        var colEmail = new DataColumn("email", typeof(string));
        var colPhoneNumber = new DataColumn("phoneNumber", typeof(string));
        var colIdChurch = new DataColumn("idChurch", typeof(int));
        var colOtherChurch = new DataColumn("otherChurch", typeof(string));
        var colNote = new DataColumn("note", typeof(string));
        var colIdJob = new DataColumn("idJob", typeof(int));

        dt.Columns.Add(colIdFrontend);
        dt.Columns.Add(colFirstName);
        dt.Columns.Add(colLastName);
        dt.Columns.Add(colEmail);
        dt.Columns.Add(colPhoneNumber);
        dt.Columns.Add(colIdChurch);
        dt.Columns.Add(colOtherChurch);
        dt.Columns.Add(colNote);
        dt.Columns.Add(colIdJob);

        foreach (var entry in data)
        {
            var row = dt.NewRow();

            row[colIdFrontend] = entry.IdFrontend;
            row[colFirstName] = entry.FirstName;
            row[colLastName] = entry.LastName;
            row[colEmail] = entry.Email;
            row[colPhoneNumber] = entry.PhoneNumber;
            row[colIdChurch] = entry.IdChurch > 0 ? entry.IdChurch : (object)DBNull.Value;
            row[colOtherChurch] = entry.OtherChurch;
            row[colNote] = entry.Note;
            row[colIdJob] = entry.IdJob > 0 ? entry.IdJob : (object)DBNull.Value;

            dt.Rows.Add(row);
        }
        return dt;
    }

    public static DataTable GetProductDataTable(List<RegistrationEntry> data)
    {
        var dt = new DataTable("Products");

        var colIdFrontend = new DataColumn("idFrontend", typeof(int));
        var colCode = new DataColumn("code", typeof(string));

        dt.Columns.Add(colIdFrontend);
        dt.Columns.Add(colCode);

        foreach (var entry in data)
        {
            foreach (var code in entry.Codes)
            {
                var row = dt.NewRow();

                row[colIdFrontend] = entry.IdFrontend;
                row[colCode] = code;

                dt.Rows.Add(row);
            }
        }
        return dt;
    }
}
