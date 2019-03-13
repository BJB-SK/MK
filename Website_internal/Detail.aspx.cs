using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class Detail : Page
{
    public const string KeyDropDownData = "KeyDropDownData";
    public const string KeyData = "KeyData";

    private bool _reload;
    private int? _id;
    private PageLoadInfo _dropDownData;
    private DetailData _data;
    private bool _saveClicked;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        var idString = Request.QueryString["id"];
        int idValue;
        _id = null;
        if (!string.IsNullOrEmpty(idString) && int.TryParse(idString, out idValue))
        {
            _id = idValue;
        }
    }

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        _dropDownData = ViewState[KeyDropDownData] as PageLoadInfo ?? new PageLoadInfo();
        _data = ViewState[KeyData] as DetailData ?? new DetailData();
    }

    protected override object SaveViewState()
    {
        ViewState[KeyDropDownData] = _dropDownData;
        return base.SaveViewState();
    }

    private void GenerateControls(List<Product> data)
    {
        lbProductsAvailable.Items.Clear();
        foreach (var item in data.Where(x => !x.IsOrdered && (x.Available == null || x.NotOrdered > 0)))
        {
            var text = item.Name + ", €" + item.Price;
            if (item.Available != null) text += ", ostáva " + item.NotOrdered;
            lbProductsAvailable.Items.Add(new ListItem(text, item.Id.ToString()));
        }
        lbProductsAvailable.Rows = Math.Max(1, Math.Min(20, lbProductsAvailable.Items.Count));

        lbProductsOrdered.Items.Clear();
        foreach (var item in data.Where(x => x.IsOrdered))
        {
            var text = item.Name + ", €" + item.Price;
            lbProductsOrdered.Items.Add(new ListItem(text, item.Id.ToString()));
        }
        lbProductsOrdered.Rows = Math.Max(1, lbProductsOrdered.Items.Count);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _dropDownData = Database.GetPageLoadInfo();
            GenerateControls(_dropDownData.Products);

            Common.FillDropDown(ddlChurch, _dropDownData.Churches, new ListItem(Common.ChybaZbor, "0"));
            Common.FillJobs(ddlJob, _dropDownData.Jobs, true);

            LoadData();
        }
        lblSuccess.Text = "";
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
                            Database.AddPayment(_id.Value, paymentToUs * amount,
                                (paymentToUs > 0 ? "Platba na mieste" : "Vratenie preplatku") +
                                ", IP = " + Common.GetIpAddress());
                            LoadData();
                        }

                        if (donationToUs != 0)
                        {
                            Database.AddDonation(_id.Value, donationToUs * amount);
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

    protected void btnTheyDonatedToUs_Click(object sender, EventArgs e)
    {
        Transaction(0, 1);
    }

    protected void btnTheyPaidUs_Click(object sender, EventArgs e)
    {
        Transaction(1, 0);
    }

    protected void btnWePaidThem_Click(object sender, EventArgs e)
    {
        Transaction(-1, 0);
    }

    protected void btnWeDonatedToThem_Click(object sender, EventArgs e)
    {
        Transaction(0, -1);
    }

    protected void btnShowedUp_Click(object sender, EventArgs e)
    {
        Database.ShowedUp(_id.Value);
        LoadData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in lbProductsAvailable.Items)
        {
            if (item.Selected)
            {
                var foundProduct = _dropDownData.Products.FirstOrDefault(x => x.Id.ToString() == item.Value);
                if (foundProduct != null)
                {
                    foundProduct.IsOrdered = true;
                }
            }
        }
        GenerateControls(_dropDownData.Products);
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in lbProductsOrdered.Items)
        {
            if (item.Selected)
            {
                var foundProduct = _dropDownData.Products.FirstOrDefault(x => x.Id.ToString() == item.Value);
                if (foundProduct != null)
                {
                    foundProduct.IsOrdered = false;
                }
            }
        }
        GenerateControls(_dropDownData.Products);
    }

    private List<int> GetOrderedProducts()
    {
        var result = new List<int>();
        foreach (ListItem item in lbProductsOrdered.Items)
        {
            int idProduct;
            if (int.TryParse(item.Value, out idProduct))
            {
                result.Add(idProduct);
            }
        }
        return result;
    }

    private DetailData GetDataFromPage()
    {
        var errors = new List<string>();
        if (string.IsNullOrWhiteSpace(txtFirstName.Text)) errors.Add(Common.ChybaMeno);
        if (string.IsNullOrWhiteSpace(txtLastName.Text)) errors.Add(Common.ChybaPriezvisko);
        if (!string.IsNullOrWhiteSpace(txtEmail.Text) && !Common.ValidateEmail(txtEmail.Text.Trim())) errors.Add(Common.ChybaEmail);
        var idChurch = ddlChurch.SelectedValue.StringToInt();
        if (idChurch == 0 || idChurch == -1) idChurch = null;
        var idJob = ddlJob.SelectedValue.StringToInt();
        if (idJob == 0) idJob = null;
        lblError.Text = "";
        if (errors.Count > 0)
        {
            lblError.Text = string.Join("<br/>", errors);
            return null;
        }
        float? extraFee = null;
        float tmp;
        if (!string.IsNullOrWhiteSpace(txtExtraFee.Text) &&
            float.TryParse(txtExtraFee.Text, out tmp))
            extraFee = tmp;
        float donation = 0;
        if (!string.IsNullOrWhiteSpace(txtDonation.Text))
        {
            if (!float.TryParse(txtDonation.Text, out donation)) errors.Add(Common.ChybaSponzorskyDar);
        }

        var data = new DetailData()
        {
            Id = _id,
            FirstName = txtFirstName.Text,
            LastName = txtLastName.Text,
            Email = txtEmail.Text,
            PhoneNumber = txtPhoneNumber.Text,
            IdChurch = idChurch,
            OtherChurch = txtOtherChurch.Text,
            IdJob = idJob,
            Note = txtNote.Text,
            Donation = donation,
            ExtraFee = extraFee,
            OrderedProducts = GetOrderedProducts(),
        };
        return data;
    }

    private void UpdatePageFromData(DetailData data)
    {
        lblId.Text = data.Id.ToString();
        txtFirstName.Text = data.FirstName;
        txtLastName.Text = data.LastName;
        txtEmail.Text = data.Email;
        txtPhoneNumber.Text = data.PhoneNumber;
        ddlChurch.SelectedValue = (data.IdChurch ?? 0).ToString();
        txtOtherChurch.Text = data.OtherChurch;
        ddlJob.SelectedValue = (data.IdJob ?? 0).ToString();
        txtNote.Text = data.Note;
        lblRegistrationDate.Text = data.DtRegistered.HasValue ? data.DtRegistered.Value.ToString(new CultureInfo("sk-SK")) : "";
        lblPaymentDate.Text = data.DtPlatba.HasValue ? data.DtPlatba.Value.Date.ToString("d.M.yyyy") : "";
        lblArrivalDate.Text = data.DtShowedUp.HasValue ? data.DtShowedUp.Value.ToString(new CultureInfo("sk-SK")) : "";
        lblPaid.Text = Currency(data.Paid);

        lblCosts.Text = Currency(data.Costs);
        lblDonation.Text = Currency(data.Donation);
        lblSurplus.Text = Currency(data.Surplus);
        var surplus = data.Surplus >= 0.01;
        var debt = data.Surplus <= -0.01;
        lblSurplus.CssClass = debt ? "negative" : "positive";
        //btnDarovaliNam.Visible = surplus;
        //btnDarovaliSme.Visible = debt;
        btnTheyPaidUs.Visible = debt;
        btnWePaidThem.Visible = surplus;
        btnShowedUp.Visible = !data.DtShowedUp.HasValue;
        txtAmount.Text = Currency(Math.Abs(data.Surplus));
        // lblRegistracnyPoplatok.Text = data.RegistraciaZadarmo ? "Zadarmo" : Currency(data.ExtraFee);
        // txtRegistrationOverride.Text = data.RegistrationOverride == null ? "" : string.Format("{0:0.00}", data.RegistrationOverride);

        if (data.Group.Count > 0)
        {
            lblGroup.Text = string.Join("<br/>", data.Group.Select(x => string.Format("<a href=\"/Detail.aspx?id={0}\" target=\"new\">{1}</a>", x.Id, x.Name)));
        }

        _dropDownData.Products = data.Products;
        GenerateControls(data.Products);
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
                    if (!_id.HasValue)
                    {
                        _id = Database.RegisterNewUser(data);
                        if (_id.HasValue)
                        {
                            // just created a user
                            Response.Redirect(string.Format("/Detail.aspx?id={0}", _id.Value));
                        }
                        else
                        {
                            lblError.Text = "Niečo sa pokazilo. Kontaktujte administrátora.";
                        }
                    }
                    else
                    {
                        Database.UpdateUser(data);

                        // updated a user
                        _reload = true;
                        lblSuccess.Text = "Zmeny boli úspešne uložené";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Message + "<br/>" + ex.InnerException;
                }
            }
        }

        if (_reload && _id.HasValue)
        {
            _data = Database.GetDetail(_id.Value);
            if (_data.Id.HasValue)
            {
                UpdatePageFromData(_data);
            }
            else
            {
                Response.Redirect("/Detail.aspx");
            }
        }

        if (!_id.HasValue) {
            int idJob;
            if (int.TryParse(ddlJob.SelectedValue, out idJob))
            {
                var foundJob = _dropDownData.Jobs.FirstOrDefault(x => x.Id == idJob);
                // foundJob.



            }

            lblTotalCost.Text = Currency(
                GetOrderedProducts()
                .Select(x => _dropDownData.Products.FirstOrDefault(y => y.Id == x))
                .Aggregate(0f, (sum, product) => sum + (product != null ? product.Price : 0))
            );
        }

        trId.Visible = _id.HasValue;
        trGroup.Visible = _id.HasValue && _data.Group.Count > 0;
        trRegistrationDate.Visible = _id.HasValue;
        trPaymentDate.Visible = _id.HasValue;
        trArrivalDate.Visible = _id.HasValue;
        trPaid.Visible = _id.HasValue;
        trCosts.Visible = _id.HasValue;
        trDonation.Visible = _id.HasValue;
        trSurplus.Visible = _id.HasValue;
        txtAmount.Visible = _id.HasValue;
        btnTheyPaidUs.Visible = _id.HasValue;
        btnWePaidThem.Visible = _id.HasValue;
        btnTheyDonatedToUs.Visible = _id.HasValue;
        btnWeDonatedToThem.Visible = _id.HasValue;
        btnShowedUp.Visible = _id.HasValue;

        trTotalCost.Visible = !_id.HasValue;

        lblTitle.Text = _id.HasValue ? _data.FirstName + " " + _data.LastName : "Nový účastník / účastníčka";
        btnSave.Text = _id.HasValue ? "Uložiť zmeny" : "Registrovať nového účastníka";

        base.OnPreRender(e);
    }

    private string Currency(float f)
    {
        return string.Format("{0:0.00}", f);
    }
}
