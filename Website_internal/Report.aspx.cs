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
        lblPeopleWhoShowedUp.Text = data.ShowedUp.ToString();
        lblExpectingEur.Text = string.Format("{0:0.00} EUR", data.ExpectingEur);
        lblMoneyFromPeople.Text = string.Format("{0:0.00} EUR", data.MoneyFromPeople);

        gridProducts.DataSource = data.Products;
        gridProducts.DataBind();

        gridJobs.DataSource = data.Jobs;
        gridJobs.DataBind();

        gridNotes.DataSource = data.Notes;
        gridNotes.DataBind();
        
        gridChurches.DataSource = data.Churches;
        gridChurches.DataBind();
    }
}