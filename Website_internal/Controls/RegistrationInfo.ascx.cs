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
    private List<SluziaciInfo> _sluziaci;
    private List<PoplatokInfo> _poplatky;
    private bool _showPrivateSluziaci;
    
    protected override void OnLoad(EventArgs e)
    {
        txtMeno.SetPlaceHolder("Meno (na visačku)");
        txtPriezvisko.SetPlaceHolder("Priezvisko (na visačku)");
        txtEmail.SetPlaceHolder("Email (povinné)");
        txtTelefon.SetPlaceHolder("Telefón (povinné)");
        txtZbor.SetPlaceHolder("Zbor (ak nie je v zozname)");
        txtPoznamka.SetPlaceHolder("Poznámka pre organizátorov");

        btnAddAtSign.OnClientClick = string.Format("$('#{0}').val($('#{0}').val() + '@');return false;", txtEmail.ClientID);
        btnAddGmail.OnClientClick = string.Format("$('#{0}').val($('#{0}').val() + '@gmail.com');return false;", txtEmail.ClientID);

        chbSobotaRanajky.AutoPostBack = CheckBoxesPostBack;
        chbNedelaRanajky.AutoPostBack = CheckBoxesPostBack;
        chbSobotaObed.AutoPostBack = CheckBoxesPostBack;
        chbNedelaObed.AutoPostBack = CheckBoxesPostBack;
        chbPiatokVecera.AutoPostBack = CheckBoxesPostBack;
        chbSobotaVecera.AutoPostBack = CheckBoxesPostBack;
        chbPiatokVecera2.AutoPostBack = CheckBoxesPostBack;
        chbSobotaVecera2.AutoPostBack = CheckBoxesPostBack;

        if(CheckBoxesPostBack)
        {
            btnVsetkoPiatok.Click += btnVsetkoPiatok_Click;
            btnNicPiatok.Click += btnNicPiatok_Click;
            btnVsetkoSobota.Click += btnVsetkoSobota_Click;
            btnNicSobota.Click += btnNicSobota_Click;
            btnVsetkoNedela.Click += btnVsetkoNedela_Click;
            btnNicNedela.Click += btnNicNedela_Click;
            btnVsetko.Click += btnVsetko_Click;
            btnNic.Click += btnNic_Click;
        }
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
        /*
        txtTelefon.CssClass = "";
        if (pnlTelefon.Visible && !Common.ValidatePhoneNumber(txtTelefon.Text.Trim()))
        {
            errors.Add(Common.ChybaTelefon);
            txtTelefon.CssClass = "errorBorder";
        }
        */
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

    public int IdZbor
    {
        get
        {
            int idZbor = 0;
            return int.TryParse(ddlZbor.SelectedValue, out idZbor) ? idZbor : 0;
        }
        set
        {
            ddlZbor.SelectedValue = value.ToString();
        }
    }

    public int IdTricko
    {
        get
        {
            int idTricko = 0;
            return int.TryParse(ddlTricko.SelectedValue, out idTricko) ? idTricko : 0;
        }
        set
        {
            ddlTricko.SelectedValue = value.ToString();
        }
    }

    public int IdMikina
    {
        get
        {
            int idMikina = 0;
            return int.TryParse(ddlMikina.SelectedValue, out idMikina) ? idMikina : 0;
        }
        set
        {
            ddlMikina.SelectedValue = value.ToString();
        }
    }

    public int IdSluziaci
    {
        get
        {
            int idSluziaci = 0;
            return int.TryParse(ddlSluziaci.SelectedValue, out idSluziaci) ? idSluziaci : 0;
        }
        set
        {
            ddlSluziaci.SelectedValue = value.ToString();
        }
    }

    public int IdDobrovolnik
    {
        get
        {
            int idDobrovolnik = 0;
            return int.TryParse(ddlDobrovolnik.SelectedValue, out idDobrovolnik) ? idDobrovolnik : 0;
        }
        set
        {
            ddlDobrovolnik.SelectedValue = value.ToString();
        }
    }

    public RegistrationEntry Data
    {
        get
        {
            if (IdSluziaci != 1) IdDobrovolnik = 0; // hardcoded value for dobrovolnik

            return new RegistrationEntry
            {
                Meno = txtMeno.Text.Trim(),
                Priezvisko = txtPriezvisko.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                Telefon = txtTelefon.Text.Trim(),
                IdZbor = IdZbor,
                InyZbor = txtZbor.Text.Trim(),
                PiatokVecera = chbPiatokVecera.Checked,
                PiatokVecera2 = chbPiatokVecera2.Checked,
                UbytovaniePiatokSobota = chbUbytovaniePiatokSobota.Checked || chbTichaTriedaPiatokSobota.Checked,
                TichaTriedaPiatokSobota = chbTichaTriedaPiatokSobota.Checked,
                SobotaRanajky = chbSobotaRanajky.Checked,
                SobotaObed = chbSobotaObed.Checked,
                SobotaVecera = chbSobotaVecera.Checked,
                SobotaVecera2 = chbSobotaVecera2.Checked,
                UbytovanieSobotaNedela = chbUbytovanieSobotaNedela.Checked || chbTichaTriedaSobotaNedela.Checked,
                TichaTriedaSobotaNedela = chbTichaTriedaSobotaNedela.Checked,
                NedelaRanajky = chbNedelaRanajky.Checked,
                NedelaObed = chbNedelaObed.Checked,
                Sach = chbSach.Checked,
                PingPong = chbPingPong.Checked,
                IdTricko = IdTricko,
                Tricko = ddlTricko.SelectedItem == null ? "" : ddlTricko.SelectedItem.Text,
                IdFarbaTricka = rblTricko.SelectedIndex,
                FarbaTricka = rblTricko.SelectedValue,
                IdMikina = IdMikina,
                Mikina = ddlMikina.SelectedItem == null ? "" : ddlMikina.SelectedItem.Text,
                IdFarbaMikiny = rblMikina.SelectedIndex,
                FarbaMikiny = rblMikina.SelectedValue,
                IdSluziaci = IdSluziaci,
                IdDobrovolnik = IdDobrovolnik,
                Poznamka = txtPoznamka.Text.Trim(),
                Errors = Validate()
            };
        }
        set
        {
            txtMeno.Text = value.Meno;
            txtPriezvisko.Text = value.Priezvisko;
            txtEmail.Text = value.Email;
            txtTelefon.Text = value.Telefon;
            IdZbor = value.IdZbor;
            txtZbor.Text = value.InyZbor;
            chbPiatokVecera.Checked = value.PiatokVecera;
            chbPiatokVecera2.Checked = value.PiatokVecera2;
            chbUbytovaniePiatokSobota.Checked = value.UbytovaniePiatokSobota;
            chbTichaTriedaPiatokSobota.Checked = value.TichaTriedaPiatokSobota;
            chbSobotaRanajky.Checked = value.SobotaRanajky;
            chbSobotaObed.Checked = value.SobotaObed;
            chbSobotaVecera.Checked = value.SobotaVecera;
            chbSobotaVecera2.Checked = value.SobotaVecera2;
            chbUbytovanieSobotaNedela.Checked = value.UbytovanieSobotaNedela;
            chbTichaTriedaSobotaNedela.Checked = value.TichaTriedaSobotaNedela;
            chbNedelaRanajky.Checked = value.NedelaRanajky;
            chbNedelaObed.Checked = value.NedelaObed;
            chbSach.Checked = value.Sach;
            chbPingPong.Checked = value.PingPong;
            IdTricko = value.IdTricko;
            rblTricko.SelectedIndex = value.IdFarbaTricka;
            IdMikina = value.IdMikina;
            rblMikina.SelectedIndex = value.IdFarbaMikiny;
            IdSluziaci = value.IdSluziaci;
            IdDobrovolnik = value.IdDobrovolnik;
            txtPoznamka.Text = value.Poznamka;
        }
    }

    public string Zbor
    {
        get
        {
            return IdZbor == -1 ? txtZbor.Text : ddlZbor.SelectedItem.Text;
        }
    }

    public CurrencyInfo Currency { get; set; }

    public void Fill(PageLoadInfo data, bool sluziaci)
    {
        _currencies = data.Currencies;
        _sluziaci = data.Sluziaci;
        _poplatky = data.Poplatky;
        _showPrivateSluziaci = sluziaci;
        Common.FillSluziaci(ddlSluziaci, data.Sluziaci, sluziaci);
        Common.FillTeeShirts(ddlTricko, data.Tricka, false);
        Common.FillTeeShirts(ddlMikina, data.Tricka, true);
        Common.FillChurches(ddlZbor, data.Zbory);
        Common.FillDobrovolnici(ddlDobrovolnik, data.Dobrovolnici);
    }

    protected override void OnPreRender(EventArgs e)
    {
        trTricko.Visible = Config.CanOrderTeeShirtOrHoodie;
        trMikina.Visible = Config.CanOrderTeeShirtOrHoodie;

        var sluziaci = new SluziaciInfo();
        if (IdSluziaci != 0 && _sluziaci.Any(x => x.Id == IdSluziaci))
        {
            sluziaci = _sluziaci.First(x => x.Id == IdSluziaci);
        }

        var ranajky = "Raňajky";
        var obed = "Obed";
        var vecera = "Večera";
        var vecera2 = "Bageta";
        var ubytovanie = "Ubytovanie";
        var tichaTrieda = "v tichej triede";
        var data = Data;
        var toolTipRanajky = Currency.FormatMoney(sluziaci.FreeFood ? 0 : Prices.Ranajky);
        var toolTipObed = Currency.FormatMoney(sluziaci.FreeFood ? 0 : Prices.Obed);
        var toolTipVecera = Currency.FormatMoney(sluziaci.FreeFood ? 0 : Prices.Vecera);
        var toolTipVecera2 = Currency.FormatMoney(sluziaci.FreeFood ? 0 : Prices.Vecera2);
        var toolUbytovanie = Currency.FormatMoney(sluziaci.FreeDorm ? 0 : Prices.Ubytovanie);

        chbSobotaRanajky.Text = ranajky;
        chbNedelaRanajky.Text = ranajky;
        chbSobotaRanajky.ToolTip = toolTipRanajky;
        chbNedelaRanajky.ToolTip = toolTipRanajky;
        lblCenaRanajky.Text = Currency.FormatMoney(sluziaci.FreeFood ? 0 : data.Ranajky * Prices.Ranajky);

        chbSobotaObed.Text = obed;
        chbNedelaObed.Text = obed;
        chbSobotaObed.ToolTip = toolTipObed;
        chbNedelaObed.ToolTip = toolTipObed;
        lblCenaObed.Text = Currency.FormatMoney(sluziaci.FreeFood ? 0 : data.Obedy * Prices.Obed);

        chbPiatokVecera.Text = vecera;
        chbSobotaVecera.Text = vecera;
        chbPiatokVecera.ToolTip = toolTipVecera;
        chbSobotaVecera.ToolTip = toolTipVecera;
        lblCenaVecera.Text = Currency.FormatMoney(sluziaci.FreeFood ? 0 : data.Vecere * Prices.Vecera);

        chbPiatokVecera2.Text = vecera2;
        chbSobotaVecera2.Text = vecera2;
        chbPiatokVecera2.ToolTip = toolTipVecera2;
        chbSobotaVecera2.ToolTip = toolTipVecera2;
        lblCenaVecera2.Text = Currency.FormatMoney(sluziaci.FreeFood ? 0 : data.Vecere2 * Prices.Vecera2);

        chbUbytovaniePiatokSobota.Text = ubytovanie;
        chbUbytovanieSobotaNedela.Text = ubytovanie;
        chbUbytovaniePiatokSobota.ToolTip = toolUbytovanie;
        chbUbytovanieSobotaNedela.ToolTip = toolUbytovanie;

        chbTichaTriedaPiatokSobota.Text = tichaTrieda;
        chbTichaTriedaSobotaNedela.Text = tichaTrieda;

        lblCenaTricko.Text = Currency.FormatMoney(sluziaci.FreeTeeShirt || IdTricko == 0 ? 0 : Prices.Tricko);
        lblCenaMikina.Text = Currency.FormatMoney(sluziaci.FreeMikina || IdMikina == 0 ? 0 : Prices.Mikina);
        lblRegistracnyPoplatok.Text = Currency.FormatMoney(sluziaci.FreeRegistration ? 0 : data.GetRegistrationFee(_poplatky));
        lblCenaUbytovanie.Text = Currency.FormatMoney(sluziaci.FreeDorm ? 0 : data.GetLodgingFee());
        lblTotalCost.Text = Currency.FormatMoney(data.GetCost(_sluziaci, _poplatky));

        if (!CheckBoxesPostBack)
        {
            var piatok = new List<CheckBox> { chbPiatokVecera, chbPiatokVecera2, chbUbytovaniePiatokSobota };
            var sobota = new List<CheckBox> { chbSobotaRanajky, chbSobotaObed, chbSobotaVecera, chbSobotaVecera2, chbUbytovanieSobotaNedela };
            var nedela = new List<CheckBox> { chbNedelaRanajky, chbNedelaObed };

            var vsetko = new List<CheckBox>();
            vsetko.AddRange(piatok);
            vsetko.AddRange(sobota);
            vsetko.AddRange(nedela);

            btnVsetkoPiatok.OnClientClick = CheckEm(piatok, true);
            btnNicPiatok.OnClientClick = CheckEm(piatok, false);

            btnVsetkoSobota.OnClientClick = CheckEm(sobota, true);
            btnNicSobota.OnClientClick = CheckEm(sobota, false);

            btnVsetkoNedela.OnClientClick = CheckEm(nedela, true);
            btnNicNedela.OnClientClick = CheckEm(nedela, false);

            btnVsetko.OnClientClick = CheckEm(vsetko, true);
            btnNic.OnClientClick = CheckEm(vsetko, false);
        }

        ddlDobrovolnik.Visible = ddlSluziaci.SelectedValue == "1";  // hardcoded value for dobrovolnik
        // pnlTelefon.Visible = ddlSluziaci.SelectedValue != "0";

        rblTricko.Visible = ddlTricko.SelectedValue != "0";
        rblMikina.Visible = ddlMikina.SelectedValue != "0";

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

    private bool Friday
    {
        set
        {
            chbPiatokVecera.Checked = value;
            chbPiatokVecera2.Checked = value;
            chbUbytovaniePiatokSobota.Checked = value;
        }
    }

    private bool Saturday
    {
        set
        {
            chbSobotaRanajky.Checked = value;
            chbSobotaObed.Checked = value;
            chbSobotaVecera.Checked = value;
            chbSobotaVecera2.Checked = value;
            chbUbytovanieSobotaNedela.Checked = value;
        }
    }

    private bool Sunday
    {
        set
        {
            chbNedelaRanajky.Checked = value;
            chbNedelaObed.Checked = value;
        }
    }

    protected void btnVsetkoPiatok_Click(object sender, EventArgs e)
    {
        Friday = true;
    }

    protected void btnNicPiatok_Click(object sender, EventArgs e)
    {
        Friday = false;
    }

    protected void btnVsetkoSobota_Click(object sender, EventArgs e)
    {
        Saturday = true;
    }

    protected void btnNicSobota_Click(object sender, EventArgs e)
    {
        Saturday = false;
    }

    protected void btnVsetkoNedela_Click(object sender, EventArgs e)
    {
        Sunday = true;
    }

    protected void btnNicNedela_Click(object sender, EventArgs e)
    {
        Sunday = false;
    }

    protected void btnVsetko_Click(object sender, EventArgs e)
    {
        Friday = true;
        Saturday = true;
        Sunday = true;
    }

    protected void btnNic_Click(object sender, EventArgs e)
    {
        Friday = false;
        Saturday = false;
        Sunday = false;
    }
}