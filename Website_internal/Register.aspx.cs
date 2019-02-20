using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Register : Page
{
    public const string KeyDropDownData = "KeyDropDownData";

    private bool _saveClicked;
    private PageLoadInfo _dropDownData;

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        _dropDownData = ViewState[KeyDropDownData] as PageLoadInfo ?? new PageLoadInfo();
    }

    protected override object SaveViewState()
    {
        ViewState[KeyDropDownData] = _dropDownData;
        return base.SaveViewState();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _dropDownData = Database.GetPageLoadInfo();

            Common.FillChurches(ddlZbor, _dropDownData.Zbory);
            Common.FillSluziaci(ddlSluziaci, _dropDownData.Sluziaci, true);
            Common.FillDobrovolnici(ddlDobrovolnik, _dropDownData.Dobrovolnici);
            Common.FillInternat(ddlUbytovaniePiatokSobota, _dropDownData.Ubytovanie);
            Common.FillInternat(ddlUbytovanieSobotaNedela, _dropDownData.Ubytovanie);
        }
        btnLenDnes.OnClientClick = string.Format("$('#{0}').val('{1}');return false;", txtRegistracnyOverride.ClientID, Prices.LenDnes);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        _saveClicked = true;
    }

    protected override void OnPreRender(EventArgs e)
    {
        var idZbor = ddlZbor.SelectedValue.StringToInt();
        if (idZbor == 0 || idZbor == -1) idZbor = null;
        var idDobrovolnik = ddlDobrovolnik.SelectedValue.StringToInt();
        if (idDobrovolnik == 0) idDobrovolnik = null;
        var idUbytovaniePiatokSobota = ddlUbytovaniePiatokSobota.SelectedValue.StringToInt();
        if (idUbytovaniePiatokSobota == 0) idUbytovaniePiatokSobota = null;
        var idUbytovanieSobotaNedela = ddlUbytovanieSobotaNedela.SelectedValue.StringToInt();
        if (idUbytovanieSobotaNedela == 0) idUbytovanieSobotaNedela = null;
        var idSluziaci = ddlSluziaci.SelectedValue.StringToInt();
        if (idSluziaci == 0) idSluziaci = null;

        trDobrovolnik.Visible = ddlSluziaci.SelectedValue == "1";

        lblCenaRanajky.Text = Currency(Prices.Ranajky);
        lblCenaObed.Text = Currency(Prices.Obed);
        lblCenaVecera.Text = Currency(Prices.Vecera);
        lblCenaVecera2.Text = Currency(Prices.Vecera2);
        lblCenaUbytovanie.Text = string.Format("{0}/{1}", Prices.Internat1, Prices.Internat2);

        if (idSluziaci.HasValue)
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

        float? registrationOverride = null;
        float tmp;
        if (!string.IsNullOrWhiteSpace(txtRegistracnyOverride.Text) &&
            float.TryParse(txtRegistracnyOverride.Text, out tmp))
            registrationOverride = tmp;

        var errors = new List<string>();
        //if (string.IsNullOrWhiteSpace(txtMeno.Text)) errors.Add(Common.ChybaMeno);
        //if (string.IsNullOrWhiteSpace(txtPriezvisko.Text)) errors.Add(Common.ChybaPriezvisko);
        if (!string.IsNullOrWhiteSpace(txtEmail.Text))
        {
            if (!Common.ValidateEmail(txtEmail.Text.Trim())) errors.Add(Common.ChybaEmail);
        }
        float sponzorskyDar = 0;
        if (!string.IsNullOrWhiteSpace(txtDar.Text))
        {
            if (!float.TryParse(txtDar.Text, out sponzorskyDar)) errors.Add(Common.ChybaSponzorskyDar);
        }
        lblError.Text = "";
        if (errors.Count > 0)
        {
            lblError.Text = string.Join("<br/>", errors);
        }
        else
        {
            var data = new NewRegistration
            {
                Meno = txtMeno.Text,
                Priezvisko = txtPriezvisko.Text,
                Email = txtEmail.Text,
                Telefon = txtTelefon.Text,
                IdZbor = idZbor,
                InyZbor = txtInyZbor.Text,
                Sach = chbSach.Checked,
                PingPong = chbPingPong.Checked,
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
                Dar = sponzorskyDar,
                RegistrationOverride = registrationOverride
            };
            lblTotalCost.Text = Currency(data.GetCost(_dropDownData.Sluziaci, _dropDownData.Poplatky));

            if (_saveClicked)
            {
                int? newId;
                try
                {
                    newId = Database.RegisterNewUser(data);
                    if (newId.HasValue)
                    {
                        // just created a user
                        Response.Redirect(string.Format("/Detail.aspx?id={0}", newId.Value));
                    }
                    else
                    {
                        lblError.Text = "Niečo sa pokazilo. Kontaktujte administrátora.";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Message + "<br/>" + ex.InnerException;
                }
            }
        }
        base.OnPreRender(e);
    }

    private string Currency(float f)
    {
        return string.Format("{0:0.00}", f);
    }
}
