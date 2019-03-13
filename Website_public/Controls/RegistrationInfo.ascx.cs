using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

public partial class RegistrationInfo : System.Web.UI.UserControl
{
    public bool CheckBoxesPostBack { get; set; }
    public bool Single { get; set; }
    //public List<SluziaciInfo> Sluziaci { get; set; }

    private List<CurrencyInfo> _currencies;
    private List<JobInfo> _sluziaci;
    private List<FeeInfo> _poplatky;
    private List<Product> _products;
    private bool _showPrivateSluziaci;
    
    protected override void OnLoad(EventArgs e)
    {
        txtMeno.SetPlaceHolder("Meno (na visačku)");
        txtPriezvisko.SetPlaceHolder("Priezvisko (na visačku)");
        txtEmail.SetPlaceHolder("Email (povinné)");
        txtPhoneNumber.SetPlaceHolder("Telefón (povinné)");
        txtZbor.SetPlaceHolder("Zbor (ak nie je v zozname)");
        txtPoznamka.SetPlaceHolder("Poznámka pre organizátorov");

        chbSobotaRanajky.AutoPostBack = CheckBoxesPostBack;
        chbNedelaRanajky.AutoPostBack = CheckBoxesPostBack;
        chbSobotaObed.AutoPostBack = CheckBoxesPostBack;
        chbNedelaObed.AutoPostBack = CheckBoxesPostBack;
        chbPiatokVecera.AutoPostBack = CheckBoxesPostBack;
        chbSobotaVecera.AutoPostBack = CheckBoxesPostBack;
        chbPiatokVecera2.AutoPostBack = CheckBoxesPostBack;
        chbSobotaVecera2.AutoPostBack = CheckBoxesPostBack;

        base.OnLoad(e);
    }

    public List<string> Validate()
    {
        var errors = new List<string>();

        txtMeno.CssClass = "";
        if (string.IsNullOrWhiteSpace(txtMeno.Text))
        {
            errors.Add(Common.ChybaMeno);
            txtMeno.CssClass = "errorBorder";
        }

        txtPriezvisko.CssClass = "";
        if (string.IsNullOrWhiteSpace(txtPriezvisko.Text))
        {
            errors.Add(Common.ChybaPriezvisko);
            txtPriezvisko.CssClass = "errorBorder";
        }

        txtEmail.CssClass = "";
        if (!Common.ValidateEmail(txtEmail.Text.Trim()))
        {
            errors.Add(Common.ChybaEmail);
            txtEmail.CssClass = "errorBorder";
        }

        txtPhoneNumber.CssClass = "";
        if (pnlTelefon.Visible && !Common.ValidatePhoneNumber(txtPhoneNumber.Text.Trim()))
        {
            errors.Add(Common.ChybaTelefon);
            txtPhoneNumber.CssClass = "errorBorder";
        }
        /*
        lblZborError.Text = "";
        if (ddlZbor.SelectedValue == "0" ||
            (ddlZbor.SelectedValue == "-1" && string.IsNullOrWhiteSpace(txtZbor.Text)))
        {
            errors.Add(Common.ChybaZbor);
            lblZborError.Text = Common.ChybaZbor;
        }
        */
        return errors;
    }

    public int? IdChurch
    {
        get
        {
            int idChurch;
            return int.TryParse(ddlZbor.SelectedValue, out idChurch) ? idChurch : (int?)null;
        }
        set
        {
            ddlZbor.SelectedValue = value.ToString();
        }
    }

    public string TeeShirtCode
    {
        get
        {
            return ddlTricko.SelectedValue != "" ? "tr " + ddlTricko.SelectedValue + " " + rblTricko.SelectedValue : "";
        }
        /*
        set
        {
            ddlTricko.SelectedValue = value.ToString();

        }
        */
    }

    public string HoodieCode
    {
        get
        {
            return ddlMikina.SelectedValue != "" ? "mi " + ddlMikina.SelectedValue + " " + rblMikina.SelectedValue : "";
        }
        /*
        set
        {
            ddlMikina.SelectedValue = value.ToString();
        }
        */
    }

    public string RegistrationCode
    {
        get
        {
            var now = DateTime.UtcNow;
            foreach (var poplatok in _poplatky)
            {
                if ((poplatok.From == null || poplatok.From <= now) && now <= poplatok.To)
                {
                    return poplatok.Code;
                }
            }
            return "";
        }
    }

    public int? IdJob
    {
        get
        {
            int idJob;
            return int.TryParse(ddlJob.SelectedValue, out idJob) ? idJob : (int?)null;
        }
        set
        {
            ddlJob.SelectedValue = value.ToString();
        }
    }

    public RegistrationEntry Data
    {
        get
        {
            var codes = new List<string>();

            if (chbPiatokVecera.Checked) codes.Add("pv");
            if (chbPiatokVecera2.Checked) codes.Add("pv2");
            if (chbUbytovaniePiatokSobota.Checked && !chbTichaTriedaPiatokSobota.Checked) codes.Add("pst");
            if (chbTichaTriedaPiatokSobota.Checked) codes.Add("pstt");
            if (chbSobotaRanajky.Checked) codes.Add("sr");
            if (chbSobotaObed.Checked) codes.Add("so");
            if (chbSobotaVecera.Checked) codes.Add("sv");
            if (chbSobotaVecera2.Checked) codes.Add("sv2");
            if (chbUbytovanieSobotaNedela.Checked && !chbTichaTriedaSobotaNedela.Checked) codes.Add("snt");
            if (chbTichaTriedaSobotaNedela.Checked) codes.Add("sntt");
            if (chbNedelaRanajky.Checked) codes.Add("nr");
            if (chbNedelaObed.Checked) codes.Add("no");
            if (chbSach.Checked) codes.Add("chess");
            if (chbPingPong.Checked) codes.Add("pingPong");
            if (TeeShirtCode != "") codes.Add(TeeShirtCode);
            if (HoodieCode != "") codes.Add(HoodieCode);
            if (RegistrationCode != "") codes.Add(RegistrationCode);

            return new RegistrationEntry
            {
                FirstName = txtMeno.Text.Trim(),
                LastName = txtPriezvisko.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                PhoneNumber = txtPhoneNumber.Text.Trim(),
                IdChurch = IdChurch,
                OtherChurch = txtZbor.Text.Trim(),
                IdJob = IdJob,
                Codes = codes,
                Note = txtPoznamka.Text.Trim(),
                Errors = Validate()
            };
        }
        set
        {
            txtMeno.Text = value.FirstName;
            txtPriezvisko.Text = value.LastName;
            txtEmail.Text = value.Email;
            txtPhoneNumber.Text = value.PhoneNumber;
            IdChurch = value.IdChurch;
            txtZbor.Text = value.OtherChurch;
            chbPiatokVecera.Checked = value.Codes.Contains("pv");
            chbPiatokVecera2.Checked = value.Codes.Contains("pv2");
            chbUbytovaniePiatokSobota.Checked = value.Codes.Contains("pst");
            chbTichaTriedaPiatokSobota.Checked = value.Codes.Contains("pstt");
            chbSobotaRanajky.Checked = value.Codes.Contains("sr");
            chbSobotaObed.Checked = value.Codes.Contains("so");
            chbSobotaVecera.Checked = value.Codes.Contains("sv");
            chbSobotaVecera2.Checked = value.Codes.Contains("sv2");
            chbUbytovanieSobotaNedela.Checked = value.Codes.Contains("snt");
            chbTichaTriedaSobotaNedela.Checked = value.Codes.Contains("sntt");
            chbNedelaRanajky.Checked = value.Codes.Contains("nr");
            chbNedelaObed.Checked = value.Codes.Contains("no");
            chbSach.Checked = value.Codes.Contains("chess");
            chbPingPong.Checked = value.Codes.Contains("pingPong");
            IdJob = value.IdJob;
            txtPoznamka.Text = value.Note;

            var code = value.Codes.FirstOrDefault(x => x.StartsWith("tr"));
            if (code != null)
            {
                var parts = code.Split(' ');
                ddlTricko.SelectedValue = parts[1] + " " + parts[2];
                rblTricko.SelectedValue = parts[3];
            }
            else
            {
                ddlTricko.SelectedValue = "";
            }

            code = value.Codes.FirstOrDefault(x => x.StartsWith("mi"));
            if (code != null)
            {
                var parts = code.Split(' ');
                ddlMikina.SelectedValue = parts[1] + " " + parts[2];
                rblMikina.SelectedValue = parts[3];
            }
            else
            {
                ddlMikina.SelectedValue = "";
            }
        }
    }

    public string Zbor
    {
        get
        {
            return IdChurch == null ? txtZbor.Text : ddlZbor.SelectedItem.Text;
        }
    }

    public CurrencyInfo Currency { get; set; }

    private ListItem[] GetSizes()
    {
        return new ListItem[]
        {
            new ListItem("Žiadne", ""),
            new ListItem("Dámske S", "da s"),
            new ListItem("Dámske M", "da m"),
            new ListItem("Dámske L", "da l"),
            new ListItem("Dámske XL", "da xl"),
            new ListItem("Dámske XXL", "da xxl"),
            new ListItem("Pánske S", "pa s"),
            new ListItem("Pánske M", "pa m"),
            new ListItem("Pánske L", "pa l"),
            new ListItem("Pánske XL", "pa xl"),
            new ListItem("Pánske XXL", "pa xxl"),
        };
    }

    public void Fill(PageLoadInfo data, bool sluziaci)
    {
        _currencies = data.Currencies;
        _sluziaci = data.Jobs;
        _poplatky = data.Fees;
        _products = data.Products;
        _showPrivateSluziaci = sluziaci;
        Common.FillJobs(ddlJob, data.Jobs, sluziaci);
        Common.FillDropDown(ddlZbor, data.Churches, new ListItem(Common.ChybaZbor, "0"));
        Common.FillDropDown(ddlTricko, GetSizes());
        Common.FillDropDown(ddlMikina, GetSizes());
    }

    private float? GetCost(JobInfo job, string code, RegistrationEntry data = null)
    {
        if (data != null && !data.Codes.Contains(code))
        {
            return 0;
        }
        var foundProduct = _products.FirstOrDefault(x => x.Code == code);
        if(foundProduct != null)
        {
            if (job.FreeCategories != null && job.FreeCategories.Contains(foundProduct.IdCategory))
            {
                return 0;
            }
            return foundProduct.Price;
        }
        return null;
    }

    public float GetCost(JobInfo job, List<string> codes)
    {
        return codes.Aggregate(0f, (sum, code) => sum + (GetCost(job, code) ?? 0f));
    }

    protected override void OnPreRender(EventArgs e)
    {
        trTricko.Visible = Config.CanOrderTeeShirtOrHoodie;
        trMikina.Visible = Config.CanOrderTeeShirtOrHoodie;

        var sluziaci = new JobInfo();
        if (IdJob != 0 && _sluziaci.Any(x => x.Id == IdJob))
        {
            sluziaci = _sluziaci.First(x => x.Id == IdJob);
        }

        var ranajky = "Raňajky";
        var obed = "Obed";
        var vecera = "Večera";
        var vecera2 = "Bageta";
        var ubytovanie = "Ubytovanie";
        var tichaTrieda = "v tichej triede";
        var data = Data;
        
        chbSobotaRanajky.Text = ranajky;
        chbNedelaRanajky.Text = ranajky;
        chbSobotaRanajky.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "sr"));
        chbNedelaRanajky.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "nr"));
        lblCenaRanajky.Text = Currency.FormatMoney(GetCost(sluziaci, "sr", data) + GetCost(sluziaci, "nr", data));

        chbSobotaObed.Text = obed;
        chbNedelaObed.Text = obed;
        chbSobotaObed.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "so"));
        chbNedelaObed.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "no"));
        lblCenaObed.Text = Currency.FormatMoney(GetCost(sluziaci, "so", data) + GetCost(sluziaci, "no", data));

        chbPiatokVecera.Text = vecera;
        chbSobotaVecera.Text = vecera;
        chbPiatokVecera.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "pv"));
        chbSobotaVecera.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "sv"));
        lblCenaVecera.Text = Currency.FormatMoney(GetCost(sluziaci, "pv", data) + GetCost(sluziaci, "sv", data));

        chbPiatokVecera2.Text = vecera2;
        chbSobotaVecera2.Text = vecera2;
        chbPiatokVecera2.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "pv2"));
        chbSobotaVecera2.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "sv2"));
        lblCenaVecera2.Text = Currency.FormatMoney(GetCost(sluziaci, "pv2", data) + GetCost(sluziaci, "sv2", data));

        chbUbytovaniePiatokSobota.Text = ubytovanie;
        chbUbytovanieSobotaNedela.Text = ubytovanie;
        chbUbytovaniePiatokSobota.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "pst", data));
        chbUbytovanieSobotaNedela.ToolTip = Currency.FormatMoney(GetCost(sluziaci, "snt", data));

        chbTichaTriedaPiatokSobota.Text = tichaTrieda;
        chbTichaTriedaSobotaNedela.Text = tichaTrieda;

        lblCenaTricko.Text = Currency.FormatMoney(GetCost(sluziaci, "tr da s zl"));
        lblCenaMikina.Text = Currency.FormatMoney(GetCost(sluziaci, "mi da s ci"));
        lblRegistracnyPoplatok.Text = Currency.FormatMoney(GetCost(sluziaci, RegistrationCode));
        lblCenaUbytovanie.Text = Currency.FormatMoney(GetCost(sluziaci, "pst", data) + GetCost(sluziaci, "snt", data));
        
        lblTotalCost.Text = Currency.FormatMoney(GetCost(sluziaci, data.Codes));

        if (!CheckBoxesPostBack)
        {
            var piatok = new List<CheckBox> { chbPiatokVecera, chbPiatokVecera2, chbUbytovaniePiatokSobota };
            var sobota = new List<CheckBox> { chbSobotaRanajky, chbSobotaObed, chbSobotaVecera, chbSobotaVecera2, chbUbytovanieSobotaNedela };
            var nedela = new List<CheckBox> { chbNedelaRanajky, chbNedelaObed };

            var vsetko = new List<CheckBox>();
            vsetko.AddRange(piatok);
            vsetko.AddRange(sobota);
            vsetko.AddRange(nedela);
        }

        pnlTelefon.Visible = ddlJob.SelectedValue != "0";

        rblTricko.Visible = ddlTricko.SelectedValue != "";
        rblMikina.Visible = ddlMikina.SelectedValue != "";

        base.OnPreRender(e);
    }

    private string CheckEm(List<CheckBox> checkBoxen, bool value)
    {
        return string.Join("", 
            checkBoxen.Select(x => 
                string.Format("$('#{0}').prop('checked', {1});", 
                    x.ClientID, 
                    value ? "true" : "false"))) + 
            "return false;";
    }
}