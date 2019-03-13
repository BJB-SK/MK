<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Inherits="Detail" Codebehind="Detail.aspx.cs" %>

<asp:Content ID="Content" ContentPlaceHolderID="Body" Runat="Server">
    <asp:UpdatePanel runat="server" ID="upRegistration">
        <ContentTemplate>
            <asp:UpdateProgress runat="server" ID="UpdateProgress1" AssociatedUpdatePanelID="upRegistration" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="centeredOverlay">
                        <asp:Label runat="server" ID="lblPleaseWait" Text="Prosím čakajte" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <h2><asp:Label runat="server" ID="lblTitle" /></h2>
            <div>
                <div class="inlineBlock">
                    <table>
                        <tr runat="server" id="trGroup">
                            <td>V skupine s</td>
                            <td><asp:Literal runat="server" ID="lblGroup" /></td>
                        </tr>
                        <tr runat="server" id="trId">
                            <td>Visačka</td>
                            <td><asp:Label runat="server" ID="lblId" /></td>
                        </tr>
                        <tr>
                            <td>Meno</td>
                            <td><asp:TextBox runat="server" ID="txtFirstName" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Priezvisko</td>
                            <td><asp:TextBox runat="server" ID="txtLastName" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><asp:TextBox runat="server" ID="txtEmail" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Telefón</td>
                            <td><asp:TextBox runat="server" ID="txtPhoneNumber" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Zbor</td>
                            <td><asp:DropDownList runat="server" ID="ddlChurch" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Iný zbor</td>
                            <td><asp:TextBox runat="server" ID="txtOtherChurch" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Slúžiaci</td>
                            <td><asp:DropDownList runat="server" ID="ddlJob" AutoPostBack="true" /></td>
                        </tr>
                        <tr>
                            <td>Poznámka</td>
                            <td><asp:TextBox runat="server" ID="txtNote" TextMode="MultiLine" Rows="5" Width="250px"/></td>
                        </tr>
                        <tr>
                            <td>Extra poplatok</td>
                            <td><asp:TextBox runat="server" ID="txtExtraFee" Width="50px" AutoPostBack="false"/></td>
                        </tr>
                        <tr runat="server" id="trTotalCost">
                            <td>Spolu</td>
                            <td><asp:Label runat="server" ID="lblTotalCost" CssClass="negative bigFont" /></td>
                        </tr>
                        <tr runat="server" id="trRegistrationDate">
                            <td>Registrovali sa</td>
                            <td><asp:Label runat="server" ID="lblRegistrationDate" /></td>
                        </tr>
                        <tr runat="server" id="trPaymentDate">
                            <td>Platba prišla</td>
                            <td><asp:Label runat="server" ID="lblPaymentDate" /></td>
                        </tr>
                        <tr runat="server" id="trArrivalDate">
                            <td>Prišli</td>
                            <td><asp:Label runat="server" ID="lblArrivalDate" /></td>
                        </tr>
                        <tr runat="server" id="trPaid">
                            <td>Zaplatili</td>
                            <td><asp:Label runat="server" ID="lblPaid" /></td>
                        </tr>
                        <tr runat="server" id="trCosts">
                            <td>Náklady</td>
                            <td><asp:Label runat="server" ID="lblCosts" /></td>
                        </tr>
                        <tr runat="server" id="trDonation">
                            <td>Darovali</td>
                            <td>
                                <asp:Label runat="server" ID="lblDonation" />
                                <asp:TextBox runat="server" ID="txtDonation" Width="100px" AutoPostBack="true" CssClass="negative" />
                            </td>
                        </tr>
                        <tr runat="server" id="trSurplus">
                            <td>Preplatok</td>
                            <td><asp:Label runat="server" ID="lblSurplus" /></td>
                        </tr>
                    </table>
                </div>
                <div class="inlineBlock">
                    <table>
                        <tr>
                            <td style="vertical-align:top">
                                Ešte sa dá objednať:<br />
                                <asp:ListBox runat="server" ID="lbProductsAvailable" SelectionMode="Multiple">
                                </asp:ListBox>
                            </td>
                            <td style="vertical-align:top">
                                <br />
                                <asp:Button runat="server" ID="btnAdd" Text=">>" OnClick="btnAdd_Click" />
                                <br /><br /><br />
                                <asp:Button runat="server" ID="btnRemove" Text="<<" OnClick="btnRemove_Click" />
                            </td>
                            <td style="vertical-align:top">
                                Má objednané:<br />
                                <asp:ListBox runat="server" ID="lbProductsOrdered" SelectionMode="Multiple">
                                </asp:ListBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <br />
            <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" CssClass="bigFont"/>
            <asp:TextBox runat="server" ID="txtAmount" Width="100px" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnTheyPaidUs" Text="Zaplatili nám" OnClick="btnTheyPaidUs_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnWePaidThem" Text="Zaplatili sme im" OnClick="btnWePaidThem_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnTheyDonatedToUs" Text="Darovali nám" OnClick="btnTheyDonatedToUs_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnWeDonatedToThem" Text="Darovali sme im" OnClick="btnWeDonatedToThem_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnShowedUp" Text="Prišli" OnClick="btnShowedUp_Click" CssClass="bigFont" />
            <br /><br />
            <asp:Label ID="lblError" runat="server" Text="" CssClass="error"/>
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="valid"/>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
