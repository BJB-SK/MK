using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
        }
    }

    private void LoadData()
    {
        var data = Database.GetSummary();

        lblRegisteredPeople.Text = data.TotalPeople.ToString();
        lblPiatokVecera.Text = data.PiatokVecera.ToString();
        lblPiatokVeceraZaplatene.Text = data.PiatokVeceraZaplatene.ToString();
        lblPiatokVecera2.Text = data.PiatokVecera2.ToString();
        lblPiatokVecera2Zaplatene.Text = data.PiatokVecera2Zaplatene.ToString();
        lblTichaTriedaPiatokSobota.Text = data.TichaTriedaPiatokSobota.ToString();
        lblSobotaRanajky.Text = data.SobotaRanajky.ToString();
        lblSobotaRanajkyZaplatene.Text = data.SobotaRanajkyZaplatene.ToString();
        lblSobotaObed.Text = data.SobotaObed.ToString();
        lblSobotaObedZaplatene.Text = data.SobotaObedZaplatene.ToString();
        lblSobotaVecera.Text = data.SobotaVecera.ToString();
        lblSobotaVeceraZaplatene.Text = data.SobotaVeceraZaplatene.ToString();
        lblSobotaVecera2.Text = data.SobotaVecera2.ToString();
        lblSobotaVecera2Zaplatene.Text = data.SobotaVecera2Zaplatene.ToString();
        lblTichaTriedaSobotaNedela.Text = data.TichaTriedaSobotaNedela.ToString();
        lblNedelaRanajky.Text = data.NedelaRanajky.ToString();
        lblNedelaRanajkyZaplatene.Text = data.NedelaRanajkyZaplatene.ToString();
        lblNedelaObed.Text = data.NedelaObed.ToString();
        lblNedelaObedZaplatene.Text = data.NedelaObedZaplatene.ToString();
        lblSach.Text = data.Sach.ToString();
        lblPingPong.Text = data.PingPong.ToString();
        lblInternatPiatokSobota1.Text = data.InternatPiatokSobota1.ToString();
        lblInternatPiatokSobotaZaplatene1.Text = data.InternatPiatokSobotaZaplatene1.ToString();
        lblInternatSobotaNedela1.Text = data.InternatSobotaNedela1.ToString();
        lblInternatSobotaNedelaZaplatene1.Text = data.InternatSobotaNedelaZaplatene1.ToString();
        lblInternatPiatokSobota2.Text = data.InternatPiatokSobota2.ToString();
        lblInternatPiatokSobotaZaplatene2.Text = data.InternatPiatokSobotaZaplatene2.ToString();
        lblInternatSobotaNedela2.Text = data.InternatSobotaNedela2.ToString();
        lblInternatSobotaNedelaZaplatene2.Text = data.InternatSobotaNedelaZaplatene2.ToString();

        lblExpectingEur.Text = string.Format("{0:0.00} EUR", data.ExpectingEur);
        lblMoneyFromPeople.Text = string.Format("{0:0.00} EUR", data.MoneyFromPeople);

        gridTShirts.DataSource = data.Tricka;
        gridTShirts.DataBind();

        gridDobrovolnici.DataSource = data.Dobrovolnici;
        gridDobrovolnici.DataBind();

        gridSluziaci.DataSource = data.Sluziaci;
        gridSluziaci.DataBind();

        gridPoznamky.DataSource = data.Poznamky;
        gridPoznamky.DataBind();
        
        gridChurches.DataSource = data.Churches;
        gridChurches.DataBind();
    }
}