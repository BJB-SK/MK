using System;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class Sports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlSport.Items.Clear();
            ddlSport.Items.Add(new ListItem("Futbal", "1"));
            ddlSport.Items.Add(new ListItem("Volejbal", "2"));
            ddlSport.Items.Add(new ListItem("Floorbal", "3"));
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        int idSport = 1;
        int.TryParse(ddlSport.SelectedValue, out idSport);

        bool valid = true;
        lblNameError.Text = "";
        if (string.IsNullOrEmpty(txtName.Text.Trim()))
        {
            valid = false;
            lblNameError.Text = Common.ChybaMenoTimu;
        }
        
        lblCaptchaError.Text = "";
        //var reCorrect = new Regex(@"90", RegexOptions.IgnoreCase);
        //if(!reCorrect.IsMatch(txtCaptcha.Text.Trim()))
        if(txtCaptcha.Text.Trim() != "90")
        {
            valid = false;
            lblCaptchaError.Text = "To nevyzerá správne.";
        }

        lblErrorOnPage.Text = valid ? "Všetko OK" : "Ešte niečo chýba (viď červené texty vyššie)";
        lblErrorOnPage.CssClass = valid ? "valid" : "error";

        lblResult.Text = "";
        if (valid)
        {
            try
            {
                // write to database
                Database.RegisterSportsTeam(
                    idSport, 
                    txtName.Text.Trim(), 
                    txtHrac1.Text.Trim(),
                    txtHrac2.Text.Trim(),
                    txtHrac3.Text.Trim(),
                    txtHrac4.Text.Trim(),
                    txtHrac5.Text.Trim(),
                    txtHrac6.Text.Trim(),
                    txtHrac7.Text.Trim());
                Response.Redirect("~/SuccessSports.aspx");
            }
            catch (Exception ex)
            {
                lblResult.Text = ex.Message + " " + ex.InnerException;
            }
        }
    }
}
