using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Data;
using System.Globalization;

public partial class Detail : Page
{
    public const string KeyId = "KeyId";
    public const string KeyDropDownData = "KeyDropDownData";

    private bool _reload;
    private int _id;
    private PageLoadInfo _dropDownData;
    private bool _saveClicked;

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        _id = ViewState[KeyId] as int? ?? 0;
        _dropDownData = ViewState[KeyDropDownData] as PageLoadInfo ?? new PageLoadInfo();
    }

    protected override object SaveViewState()
    {
        ViewState[KeyId] = _id;
        ViewState[KeyDropDownData] = _dropDownData;
        return base.SaveViewState();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        var idString = Request.QueryString["id"];
        if (string.IsNullOrEmpty(idString) || !int.TryParse(idString, out _id))
        {
            Response.Redirect(string.Format("/Register.aspx"));
            return;
        }

        if (!IsPostBack)
        {
            _dropDownData = Database.GetPageLoadInfo();

            Common.FillChurches(ddlZbor, _dropDownData.Zbory);
            Common.FillTeeShirts(ddlTricko, _dropDownData.Tricka);
            Common.FillSluziaci(ddlSluziaci, _dropDownData.Sluziaci, true);
            Common.FillDobrovolnici(ddlDobrovolnik, _dropDownData.Dobrovolnici);
            Common.FillInternat(ddlUbytovaniePiatokSobota);
            Common.FillInternat(ddlUbytovanieSobotaNedela);
        }

        if (!IsPostBack)
        {
            LoadData();
        }
        lblSuccess.Text = "";
        btnLenDnes.OnClientClick = string.Format("$('#{0}').val('{1}');return false;", txtRegistracnyOverride.ClientID, Prices.LenDnes);
    }

    private void LoadData()
    {
        _reload = true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        _saveClicked = true;
    }

    private void Transaction(int paymentToUs, int donationToUs)
    {
        float amount = 0;
        if (!string.IsNullOrWhiteSpace(txtAmount.Text))
        {
            if (float.TryParse(txtAmount.Text, out amount))
            {
                amount = Math.Abs(amount);
                if (amount >= 0.01)
                {
                    try
                    {
                        if (paymentToUs != 0)
                        {
                            Database.AddPayment(_id, paymentToUs * amount,
                                (paymentToUs > 0 ? "Platba na mieste" : "Vratenie preplatku") +
                                ", IP = " + Common.GetIpAddress());
                            LoadData();
                        }

                        if (donationToUs != 0)
                        {
                            Database.AddDonation(_id, donationToUs * amount);
                            LoadData();
                        }
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = ex.Message + ' ' + ex.InnerException;
                    }
                }
            }
        }
    }

    protected void btnDarovaliNam_Click(object sender, EventArgs e)
    {
        Transaction(0, 1);
    }

    protected void btnZaplatiliNam_Click(object sender, EventArgs e)
    {
        Transaction(1, 0);
    }

    protected void btnZaplatiliSme_Click(object sender, EventArgs e)
    {
        Transaction(-1, 0);
    }

    protected void btnDarovaliSme_Click(object sender, EventArgs e)
    {
        Transaction(0, -1);
    }

    protected void btnPrisli_Click(object sender, EventArgs e)
    {
        Database.ShowedUp(_id);
        LoadData();
    }

    private DetailData GetDataFromPage()
    {
        var errors = new List<string>();
        if (string.IsNullOrWhiteSpace(txtMeno.Text)) errors.Add(Common.ChybaMeno);
        if (string.IsNullOrWhiteSpace(txtPriezvisko.Text)) errors.Add(Common.ChybaPriezvisko);
        if (!string.IsNullOrWhiteSpace(txtEmail.Text) && !Common.ValidateEmail(txtEmail.Text.Trim())) errors.Add(Common.ChybaEmail);
        var idTricko = ddlTricko.SelectedValue.StringToInt();
        if (idTricko == 0) idTricko = null;
        var idZbor = ddlZbor.SelectedValue.StringToInt();
        if (idZbor == 0 || idZbor == -1) idZbor = null;
        var idSluziaci = ddlSluziaci.SelectedValue.StringToInt();
        if (idSluziaci == 0) idSluziaci = null;
        var idDobrovolnik = ddlDobrovolnik.SelectedValue.StringToInt();
        if (idDobrovolnik == 0) idDobrovolnik = null;
        var idUbytovaniePiatokSobota = ddlUbytovaniePiatokSobota.SelectedValue.StringToInt();
        if (idUbytovaniePiatokSobota == 0) idUbytovaniePiatokSobota = null;
        var idUbytovanieSobotaNedela = ddlUbytovanieSobotaNedela.SelectedValue.StringToInt();
        if (idUbytovanieSobotaNedela == 0) idUbytovanieSobotaNedela = null;
        lblError.Text = "";
        if (errors.Count > 0)
        {
            lblError.Text = string.Join("<br/>", errors);
            return null;
        }
        float? registrationOverride = null;
        float tmp;
        if (!string.IsNullOrWhiteSpace(txtRegistracnyOverride.Text) &&
            float.TryParse(txtRegistracnyOverride.Text, out tmp))
            registrationOverride = tmp;

        return new DetailData
        {
            Id = _id,
            Meno = txtMeno.Text,
            Priezvisko = txtPriezvisko.Text,
            Email = txtEmail.Text,
            Telefon = txtTelefon.Text,
            IdZbor = idZbor,
            InyZbor = txtInyZbor.Text,
            Sach = chbSach.Checked,
            PingPong = chbPingPong.Checked,
            IdTricko = idTricko,
            IdSluziaci = idSluziaci,
            IdDobrovolnik = idDobrovolnik,
            Poznamka = txtPoznamka.Text,
            PiatokVecera = chbPiatokVecera.Checked,
            PiatokVecera2 = chbPiatokVecera2.Checked,
            IdUbytovaniePiatokSobota = idUbytovaniePiatokSobota ?? 0,
            SobotaRanajky = chbSobotaRanajky.Checked,
            SobotaObed = chbSobotaObed.Checked,
            SobotaVecera = chbSobotaVecera.Checked,
            SobotaVecera2 = chbSobotaVecera2.Checked,
            IdUbytovanieSobotaNedela = idUbytovanieSobotaNedela ?? 0,
            NedelaRanajky = chbNedelaRanajky.Checked,
            NedelaObed = chbNedelaObed.Checked,
            RegistracnyOverride = registrationOverride
        };
    }

    private void UpdatePageFromData(DetailData data)
    {
        lblId.Text = data.Id.ToString();
        txtMeno.Text = data.Meno;
        txtPriezvisko.Text = data.Priezvisko;
        txtEmail.Text = data.Email;
        txtTelefon.Text = data.Telefon;
        ddlZbor.SelectedValue = (data.IdZbor ?? 0).ToString();
        txtInyZbor.Text = data.InyZbor;
        chbPiatokVecera.Checked = data.PiatokVecera;
        chbPiatokVecera2.Checked = data.PiatokVecera2;
        ddlUbytovaniePiatokSobota.SelectedValue = data.IdUbytovaniePiatokSobota.ToString();
        chbSobotaRanajky.Checked = data.SobotaRanajky;
        chbSobotaObed.Checked = data.SobotaObed;
        chbSobotaVecera.Checked = data.SobotaVecera;
        chbSobotaVecera2.Checked = data.SobotaVecera2;
        ddlUbytovanieSobotaNedela.SelectedValue = data.IdUbytovanieSobotaNedela.ToString();
        chbNedelaRanajky.Checked = data.NedelaRanajky;
        chbNedelaObed.Checked = data.NedelaObed;
        chbSach.Checked = data.Sach;
        chbPingPong.Checked = data.PingPong;
        ddlTricko.SelectedValue = (data.IdTricko ?? 0).ToString();
        ddlSluziaci.SelectedValue = (data.IdSluziaci ?? 0).ToString();
        ddlDobrovolnik.SelectedValue = (data.IdDobrovolnik ?? 0).ToString();
        txtPoznamka.Text = data.Poznamka;
        lblRegistrationDate.Text = data.DtRegistered.HasValue ? data.DtRegistered.Value.ToString(new CultureInfo("sk-SK")) : "";
        lblPaymentDate.Text = data.DtPlatba.HasValue ? data.DtPlatba.Value.Date.ToString("d.M.yyyy") : "";
        lblArrivalDate.Text = data.DtPrisli.HasValue ? data.DtPrisli.Value.ToString(new CultureInfo("sk-SK")) : "";
        lblZaplatili.Text = Currency(data.Zaplatili);
        lblCosts.Text = Currency(data.Naklady);
        lblDonation.Text = Currency(data.Dar);
        lblPreplatok.Text = Currency(data.Preplatok);
        var surplus = data.Preplatok >= 0.01;
        var debt = data.Preplatok <= -0.01;
        lblPreplatok.CssClass = debt ? "negative" : "positive";
        //btnDarovaliNam.Visible = surplus;
        //btnDarovaliSme.Visible = debt;
        btnZaplatiliNam.Visible = debt;
        btnZaplatiliSme.Visible = surplus;
        btnPrisli.Visible = !data.DtPrisli.HasValue;
        txtAmount.Text = Currency(Math.Abs(data.Preplatok));
        lblRegistracnyPoplatok.Text = data.RegistraciaZadarmo ? "Zadarmo" : Currency(data.RegistracnyPoplatok);
        txtRegistracnyOverride.Text = data.RegistracnyOverride == null ? "" : string.Format("{0:0.00}", data.RegistracnyOverride);

        lblTitle.Text = data.Meno + " " + data.Priezvisko;

        if (data.Group.Count > 0)
        {
            trGroup.Visible = true;
            lblGroup.Text = string.Join("<br/>", data.Group.Select(x => string.Format("<a href=\"/Detail.aspx?id={0}\" target=\"new\">{1}</a>", x.Id, x.Name)));
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        if (_saveClicked)
        {
            var data = GetDataFromPage();
            if (data != null)
            {
                try
                {
                    Database.UpdateUser(data);

                    // updated a user
                    _reload = true;
                    lblSuccess.Text = "Zmeny boli úspešne uložené";
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Message + "<br/>" + ex.InnerException;
                }
            }
        }

        if (_reload)
        {
            trGroup.Visible = false;

            var data = Database.GetDetail(_id);
            if (data.Id.HasValue)
            {
                UpdatePageFromData(data);
            }
            else
            {
                Response.Redirect("/Detail.aspx");
            }
        }

        trDobrovolnik.Visible = ddlSluziaci.SelectedValue == "1";

        lblCenaRanajky.Text = Currency(Prices.Ranajky);
        lblCenaObed.Text = Currency(Prices.Obed);
        lblCenaVecera.Text = Currency(Prices.Vecera);
        lblCenaVecera2.Text = Currency(Prices.Vecera2);
        lblCenaUbytovanie.Text = string.Format("0/0/{0}/{1}", Prices.Internat1, Prices.Internat2);

        int idSluziaci;
        if (int.TryParse(ddlSluziaci.SelectedValue, out idSluziaci))
        {
            var sluziaci = _dropDownData.Sluziaci.FirstOrDefault(x => x.Id == idSluziaci);
            if (sluziaci.FreeFood)
            {
                lblCenaRanajky.Text = "0";
                lblCenaObed.Text = "0";
                lblCenaVecera.Text = "0";
                lblCenaVecera2.Text = "0";
            }
            if (sluziaci.FreeDorm)
            {
                lblCenaUbytovanie.Text = "0";
            }
        }
        base.OnPreRender(e);
    }

    private string Currency(float f)
    {
        return string.Format("{0:0.00}", f);
    }
}
