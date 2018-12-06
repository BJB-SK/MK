using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

public partial class Register : Page
{
    public const int TabsBefore = 1;
    public const int TabsAfter = 1;
    public const string KeyRegistrationData = "KeyRegistrationData";
    public const string KeyDropDownData = "KeyDropDownData";
    public const string KeyIndices = "KeyIndices";
    public const string KeySuccess = "KeySuccess";

    public const string UrlKeySluziaci = "sluziaci";

    private List<RegistrationEntry> _data;
    private List<RegistrationInfo> _controls;
    private List<TabPanel> _tabPanels;
    private List<int> _indices;
    bool _registerClicked = false;
    private PageLoadInfo _dropDownData;
    private bool _sluziaci;
    private bool _success;

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        _data = ViewState[KeyRegistrationData] as List<RegistrationEntry> ?? new List<RegistrationEntry>();
        _indices = ViewState[KeyIndices] as List<int> ?? new List<int>();
        _dropDownData = ViewState[KeyDropDownData] as PageLoadInfo ?? new PageLoadInfo();
        _success = (bool)ViewState[KeySuccess];
        GenerateControls();
    }

    protected override object SaveViewState()
    {
        ViewState[KeyRegistrationData] = _data;
        ViewState[KeyIndices] = _indices;
        ViewState[KeyDropDownData] = _dropDownData;
        ViewState[KeySuccess] = _success;
        return base.SaveViewState();
    }

    protected override void OnInit(EventArgs e)
    {
        _sluziaci = Request.QueryString[UrlKeySluziaci] == "true";

        var endOfRegistration = new DateTime(2019, 2, 15, 0, 0, 0);  //TODO: update
        pnlRegistrationDone.Visible = (DateTime.Now > endOfRegistration) && !_sluziaci;

        if (!IsPostBack)
        {
            _dropDownData = Database.GetPageLoadInfo();
            _data = new List<RegistrationEntry> { new RegistrationEntry() };
            _indices = new List<int> { 0 };
            GenerateControls();
            ResetActiveTab(0);
        }
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rblMena.Items.Clear();
            rblMena.Items.AddRange(_dropDownData.Currencies.ToListItems());
            rblMena.SelectedValue = "1";
        }
        txtEmail.SetPlaceHolder("Email o platbe poslať na...");
        txtCaptcha.SetPlaceHolder("Toto pole nechajte prázdne (naozaj)");
        btnAddAtSign.OnClientClick = string.Format("$('#{0}').val($('#{0}').val() + '@');return false;", txtEmail.ClientID);
        btnAddGmail.OnClientClick = string.Format("$('#{0}').val($('#{0}').val() + '@gmail.com');return false;", txtEmail.ClientID);
    }

    protected override void OnLoad(EventArgs e)
    {
        for (int i = 0; i < _data.Count; i++)
        {
            _data[i] = _controls[i].Data;
            _data[i].Id = _indices[i];
        }
        base.OnLoad(e);
    }

    private void GenerateControls()
    {
        _controls = new List<RegistrationInfo>();
        _tabPanels = new List<TabPanel>();

        for (int i = 0; i < _data.Count; i++)
        {
            AddControl(i, _indices[i]);
        }
    }

    private void ResetActiveTab(int position)
    {
        tabContainer.ActiveTabIndex = _data.Count + 1;
        tabContainer.ActiveTabIndex = position;
    }

    private void AddControl(int position, int id, RegistrationEntry data = null)
    {
        var control = (RegistrationInfo)LoadControl("~/Controls/RegistrationInfo.ascx");
        control.ID = "ucRegistrationInfo" + id;
        control.Fill(_dropDownData, _sluziaci);
        control.CheckBoxesPostBack = false;
        if (data != null) control.Data = data;
        _controls.Insert(position, control);

        var tabPanel = new TabPanel();
        tabPanel.HeaderText = "Tab number " + id;
        tabPanel.ID = "tabPanel" + id;
        _tabPanels.Insert(position, tabPanel);

        tabPanel.Controls.Add(control);
        tabPanel.Visible = true;

        tabContainer.Tabs.AddAt(position + TabsBefore, tabPanel);
        ResetActiveTab(position + TabsBefore);
    }

    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        var position = tabContainer.ActiveTabIndex - TabsBefore;
        if (position < 0) position = 0;
        if (position >= _data.Count) position = _data.Count - 1;
        var id = _indices.Max() + 1;
        var data = new RegistrationEntry(_controls[position].Data);
        _data.Insert(position + 1, data);
        _indices.Insert(position + 1, id);
        AddControl(position + 1, id, data);
    }

    private void RemoveControl(int position, bool switchToPosition)
    {
        _data.RemoveAt(position);
        _indices.RemoveAt(position);
        _controls.RemoveAt(position);
        _tabPanels.RemoveAt(position);
        tabContainer.Tabs.RemoveAt(position + TabsBefore);
        if(switchToPosition) ResetActiveTab(position + TabsBefore);
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        if (_data.Count == 1) return;
        var position = tabContainer.ActiveTabIndex - TabsBefore;
        if (position < 0 || position >= _data.Count) return;
        RemoveControl(position, true);
    }

    protected void gridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("Vymazat"))
        {
            int id;
            if(int.TryParse((string)e.CommandArgument, out id))
            {
                int? position = null;
                for(int i = 0; i < _indices.Count; i++)
                {
                    if (_indices[i] == id)
                    {
                        position = i;
                        break;
                    }
                }
                if (position.HasValue && position < _data.Count && _data.Count > 1)
                {
                    RemoveControl(position.Value, false);
                }
            }
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        var i = tabContainer.ActiveTabIndex;
        if (i < _data.Count + 1) tabContainer.ActiveTabIndex = i + 1;
        if(i == _data.Count + 1) _registerClicked = true;
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        var i = tabContainer.ActiveTabIndex;
        if (i > 0) tabContainer.ActiveTabIndex = i - 1;
    }

    protected override void OnPreRender(EventArgs e)
    {
        int idCurrency = 1;
        int.TryParse(rblMena.SelectedValue, out idCurrency);
        var currency = _dropDownData.Currencies.First(x => x.Id == idCurrency);
        lblMena.Text = currency.Name;

        var now = DateTime.UtcNow;
        foreach (var item in _dropDownData.Poplatky)
        {
            item.CostString = currency.FormatMoney(item.Amount);
            item.CssClass = (item.From ?? now) <= now && now <= (item.To ?? now) ? "currentFee" : "";
        }
        gridPoplatky.DataSource = _dropDownData.Poplatky.Where(x => x.Online);
        gridPoplatky.DataBind();

        gridPoplatkyNaMieste.DataSource = _dropDownData.Poplatky.Where(x => !x.Online);
        gridPoplatkyNaMieste.DataBind();

        float sum = 0;
        bool valid = true;
        for (int i = 0; i < _data.Count; i++)
        {
            _data[i] = _controls[i].Data;
            _data[i].Id = _indices[i];
            _tabPanels[i].HeaderText = _data[i].Title;
            _controls[i].Currency = currency;
            _data[i].Currency = currency;
            _data[i].Single = _data.Count == 1;
            _controls[i].Single = _data.Count == 1;
            var cost = _data[i].GetCost(_dropDownData.Sluziaci, _dropDownData.Poplatky);
            sum += cost;
            _data[i].CostString = currency.FormatMoney(cost);
            valid = valid && _data[i].Valid;
        }

        trPayerEmail.Visible = _data.Count > 1;

        txtEmail.CssClass = "";
        if (_data.Count > 1 && !Common.ValidateEmail(txtEmail.Text.Trim()))
        {
            valid = false;
            txtEmail.CssClass = "errorBorder";
        }

        var payerEmail = _data.Count > 1 ? txtEmail.Text.Trim().ToLower() : _data[0].Email.Trim().ToLower();

        txtCaptcha.CssClass = "";
        if(txtCaptcha.Text != "")
        {
            valid = false;
            txtCaptcha.CssClass = "errorBorder";
        }

        float sponzorskyDar = 0;
        txtDar.CssClass = "";
        if (!string.IsNullOrWhiteSpace(txtDar.Text))
        {
            if(!float.TryParse(txtDar.Text, out sponzorskyDar))
            {
                txtDar.CssClass = "errorBorder";
                valid = false;
            }
            if (sponzorskyDar < 0) sponzorskyDar = 0;
        }

        var amountToPay = sum + sponzorskyDar / currency.Rate;
        lblSuma.Text = currency.FormatMoney(amountToPay);

        if (!chbGdprConsent.Checked)
        {
            valid = false;
        }
        lblGdprMissing.Visible = !chbGdprConsent.Checked;

        // check for duplicate emails
        var emailHash = new Dictionary<string, int>();
        foreach(var item in _data)
        {
            var email = item.Email.Trim().ToLower();
            if (string.IsNullOrWhiteSpace(email)) continue;
            emailHash[email] = emailHash.ContainsKey(email) ? emailHash[email] + 1 : 1;
        }
        foreach (var item in emailHash)
        {
            if (item.Value > 1)
            {
                valid = false;
                for (int i = 0; i < _data.Count; i++)
                {
                    if (_data[i].Email.Trim().ToLower() == item.Key)
                    {
                        _data[i].Errors.Add(Common.ChybaEmailSaOpakuje);
                    }
                }
            }
        }

        lblResult.Text = "";
        if (valid && _registerClicked)
        {
            try
            {
                var emails = new List<Email>();

                if(_data.Count == 1)
                {
                    emails.Add(new Email(payerEmail, Emails.RegistrationSubject, Emails.GetSingle(_data[0], amountToPay, currency)));
                }
                else
                {
                    var payerIsRegistered = false;
                    for(var i = 0; i < _data.Count; i++)
                    {
                        _data[i].Email = _data[i].Email.Trim().ToLower();
                        if(payerEmail == _data[i].Email)
                        {
                            payerIsRegistered = true;
                            emails.Add(new Email(payerEmail, Emails.RegistrationSubject, Emails.GetMultiplePayerRegistered(_data, i, amountToPay, currency)));
                        }
                        else
                        {
                            emails.Add(new Email(_data[i].Email, Emails.RegistrationSubject, Emails.GetMultiple(_data[i], payerEmail)));
                        }
                    }
                    if(!payerIsRegistered)
                    {
                        emails.Add(new Email(payerEmail, Emails.RegistrationSubject, Emails.GetMultiplePayerNotRegistered(_data, amountToPay, currency, payerEmail)));
                    }
                }

                // write to database
                var data = Database.WriteData(_data, emails, payerEmail, sponzorskyDar, currency);
                if (data.Success)
                {
                    _success = true;
                }
                else
                {
                    // there are bad emails
                    valid = false;
                    foreach (var item in data.AlreadyRegisteredEmails)
                    {
                        for (int i = 0; i < _data.Count; i++)
                        {
                            if (_data[i].Email.Trim().ToLower() == item.Trim().ToLower())
                            {
                                _data[i].Errors.Add(Common.ChybaEmailUzZaregistrovany);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = ex.Message + " " + ex.InnerException;
            }
        }

        gridSummary.DataSource = _data;
        gridSummary.DataBind();

        pnlRegistration.Visible = !_success && !pnlRegistrationDone.Visible;
        pnlSuccess.Visible = _success && !pnlRegistrationDone.Visible;

        base.OnPreRender(e);
    }
}
