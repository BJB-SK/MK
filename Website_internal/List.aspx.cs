using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class List : Page
{
    protected static class TableColumns
    {
        public const string Id = "Id";
        public const string IdAccount = "IdAccount";
        public const string Meno = "Meno";
        public const string Priezvisko = "Priezvisko";
        public const string Zbor = "Zbor";
        public const string Tricko = "Tricko";
        public const string Mikina = "Mikina";
        public const string Preplatok = "Preplatok";
        public const string Prisli = "Prisli";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadFilter();
            chbArrived.Checked = true;
            chbNotArrived.Checked = true;
        }
    }
    
    private void LoadFilter()
    {
        var data = Database.GetFilter();

        ddlChurch.Items.Clear();
        ddlChurch.Items.Add(new ListItem { Value = "", Text = "Všetky" });
        foreach(var item in data)
        {
            ddlChurch.Items.Add(new ListItem { Value = item.Id.ToString(), Text = item.Name});
        }
    }

    protected void btnClearName_Click(object sender, EventArgs e)
    {
        txtName.Text = "";
    }

    protected void btnClearChurch_Click(object sender, EventArgs e)
    {
        ddlChurch.SelectedValue = "";
    }
    
    protected void gridResults_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowIndex;
        if(int.TryParse(e.CommandArgument.ToString(), out rowIndex))
        {
            GridViewRow row = gridResults.Rows[rowIndex];

            var hdnIdUser = (HiddenField)row.FindControl("hdnIdUser");
            var hdnAmount = (HiddenField)row.FindControl("hdnAmount");

            int idUser;
            float amount;

            if (int.TryParse(hdnIdUser.Value, out idUser) &&
                float.TryParse(hdnAmount.Value, out amount))
            {
                switch (e.CommandName)
                {
                    case "Darovali":
                        // donation += preplatok
                        Database.AddDonation(idUser, amount);
                        break;
                    case "Doplatili":
                        // add payment = -preplatok
                        Database.AddPayment(idUser, -amount, "Platba na mieste, IP = " + Common.GetIpAddress());
                        break;
                    case "Vratili":
                        // add payment = -preplatok
                        Database.AddPayment(idUser, -amount, "Vratenie preplatku, IP = " + Common.GetIpAddress());
                        break;
                    case "Prisli":
                        Database.ShowedUp(idUser);
                        break;
                }
            }
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        int idChurch = 0;
        int.TryParse(ddlChurch.SelectedValue, out idChurch);

        var findName = txtName.Text.Trim().ToUpper();
        var from = txtFrom.Text.Trim().ToUpper();
        var to = txtTo.Text.Trim().ToUpper();
        var arrived = chbArrived.Checked;
        var notArrived = chbNotArrived.Checked;

        var data = Database.GetList(findName, idChurch, from, to, arrived, notArrived);

        gridResults.DataSource = data;
        gridResults.DataBind();

        base.OnPreRender(e);
    }

    protected string CashBackFormat(object x)
    {
        var f = x as float?;
        if (!f.HasValue || f.Value == 0) return "";
        return string.Format("{0:0.00}", x);
    }

    protected string CashBackClass(object x)
    {
        var f = x as float?;
        if (!f.HasValue || f.Value == 0) return "";
        return f.Value >= -0.01 ? "positive" : "negative";
    }
}
