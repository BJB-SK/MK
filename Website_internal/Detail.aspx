<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Detail.aspx.cs" Inherits="Detail" %>

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
            <div class="multiColumnContainer">
                <div class="multiColumnBlock">
                    <table>
                        <tr runat="server" id="trGroup">
                            <td>V skupine s</td>
                            <td><asp:Literal runat="server" ID="lblGroup" /></td>
                        </tr>
                        <tr>
                            <td>Visačka</td>
                            <td><asp:Label runat="server" ID="lblId" /></td>
                        </tr>
                        <tr>
                            <td>Meno</td>
                            <td><asp:TextBox runat="server" ID="txtMeno" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Priezvisko</td>
                            <td><asp:TextBox runat="server" ID="txtPriezvisko" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><asp:TextBox runat="server" ID="txtEmail" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Telefón</td>
                            <td><asp:TextBox runat="server" ID="txtTelefon" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Zbor</td>
                            <td><asp:DropDownList runat="server" ID="ddlZbor" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Iný zbor</td>
                            <td><asp:TextBox runat="server" ID="txtInyZbor" Width="250px" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Športy</td>
                            <td>
                                <asp:CheckBox runat="server" ID="chbSach" Text="Šach"/>
                                <asp:CheckBox runat="server" ID="chbPingPong" Text="Ping pong"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Tričko</td>
                            <td><asp:DropDownList runat="server" ID="ddlTricko" AutoPostBack="false"/></td>
                        </tr>
                        <tr>
                            <td>Slúžiaci</td>
                            <td><asp:DropDownList runat="server" ID="ddlSluziaci" AutoPostBack="true" /></td>
                        </tr>
                        <tr runat="server" id="trDobrovolnik">
                            <td>Dobrovoľník</td>
                            <td><asp:DropDownList runat="server" ID="ddlDobrovolnik" AutoPostBack="false" /></td>
                        </tr>
                        <tr>
                            <td>Poznámka</td>
                            <td><asp:TextBox runat="server" ID="txtPoznamka" TextMode="MultiLine" Rows="5" Width="250px"/></td>
                        </tr>
                    </table>
                </div>
                <div class="multiColumnBlock">
                    <table>
                        <tr>
                            <td>Piatok</td>
                            <td>Sobota</td>
                            <td>Nedeľa</td>
                            <td>Cena</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><asp:CheckBox runat="server" ID="chbSobotaRanajky" Text="Raňajky" AutoPostBack="true" /></td>
                            <td><asp:CheckBox runat="server" ID="chbNedelaRanajky" Text="Raňajky" AutoPostBack="true" /></td>
                            <td><asp:Label runat="server" ID="lblCenaRanajky" /></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><asp:CheckBox runat="server" ID="chbSobotaObed" Text="Obed" AutoPostBack="true" /></td>
                            <td><asp:CheckBox runat="server" ID="chbNedelaObed" Text="Obed" AutoPostBack="true" /></td>
                            <td><asp:Label runat="server" ID="lblCenaObed" /></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox runat="server" ID="chbPiatokVecera" Text="Večera" AutoPostBack="true" /></td>
                            <td><asp:CheckBox runat="server" ID="chbSobotaVecera" Text="Večera" AutoPostBack="true" /></td>
                            <td>&nbsp;</td>
                            <td><asp:Label runat="server" ID="lblCenaVecera" /></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox runat="server" ID="chbPiatokVecera2" Text="Bageta" AutoPostBack="true" /></td>
                            <td><asp:CheckBox runat="server" ID="chbSobotaVecera2" Text="Bageta" AutoPostBack="true" /></td>
                            <td>&nbsp;</td>
                            <td><asp:Label runat="server" ID="lblCenaVecera2" /></td>
                        </tr>
                        <tr>
                            <td><asp:DropDownList runat="server" ID="ddlUbytovaniePiatokSobota" AutoPostBack="true"/></td>
                            <td><asp:DropDownList runat="server" ID="ddlUbytovanieSobotaNedela" AutoPostBack="true"/></td>
                            <td>&nbsp;</td>
                            <td><asp:Label runat="server" ID="lblCenaUbytovanie" /></td>
                        </tr>
                    </table>
                </div>
                <div class="multiColumnBlock">
                    <table>
                        <tr>
                            <td>Registrovali sa</td>
                            <td><asp:Label runat="server" ID="lblRegistrationDate" /></td>
                        </tr>
                        <tr>
                            <td>Platba prišla</td>
                            <td><asp:Label runat="server" ID="lblPaymentDate" /></td>
                        </tr>
                        <tr>
                            <td>Prišli</td>
                            <td><asp:Label runat="server" ID="lblArrivalDate" /></td>
                        </tr>
                        <tr>
                            <td>Zaplatili</td>
                            <td><asp:Label runat="server" ID="lblZaplatili" /></td>
                        </tr>
                        <tr>
                            <td>Náklady</td>
                            <td><asp:Label runat="server" ID="lblCosts" /></td>
                        </tr>
                        <tr>
                            <td>Darovali</td>
                            <td><asp:Label runat="server" ID="lblDonation" /></td>
                        </tr>
                        <tr>
                            <td>Preplatok</td>
                            <td><asp:Label runat="server" ID="lblPreplatok" /></td>
                        </tr>
                    </table>
                </div>
            </div>
            <br />
            <asp:Button runat="server" ID="btnSave" Text="Uložiť zmeny" OnClick="btnSave_Click" CssClass="bigFont"/>
            <asp:TextBox runat="server" ID="txtAmount" Width="100px" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnZaplatiliNam" Text="Zaplatili nám" OnClick="btnZaplatiliNam_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnZaplatiliSme" Text="Zaplatili sme im" OnClick="btnZaplatiliSme_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnDarovaliNam" Text="Darovali nám" OnClick="btnDarovaliNam_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnDarovaliSme" Text="Darovali sme im" OnClick="btnDarovaliSme_Click" CssClass="bigFont" />
            <asp:Button runat="server" ID="btnPrisli" Text="Prišli" OnClick="btnPrisli_Click" CssClass="bigFont" />
            <br /><br />
            <asp:Label ID="lblError" runat="server" Text="" CssClass="error"/>
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="valid"/>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
