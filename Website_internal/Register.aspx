<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

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
            <h2>Nový účastník / účastníčka</h2>
            <div class="multiColumnContainer">
                <div class="multiColumnBlock">
                    <table>
                        <tr>
                            <td>Meno</td>
                            <td><asp:TextBox runat="server" ID="txtMeno" Width="250px" Text="Anonym" AutoPostBack="false"/></td>
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
                            <td><asp:Label runat="server" ID="lblCenaRanajky" CssClass="negative"/></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><asp:CheckBox runat="server" ID="chbSobotaObed" Text="Obed" AutoPostBack="true" /></td>
                            <td><asp:CheckBox runat="server" ID="chbNedelaObed" Text="Obed" AutoPostBack="true" /></td>
                            <td><asp:Label runat="server" ID="lblCenaObed" CssClass="negative"/></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox runat="server" ID="chbPiatokVecera" Text="Večera" AutoPostBack="true" /></td>
                            <td><asp:CheckBox runat="server" ID="chbSobotaVecera" Text="Večera" AutoPostBack="true" /></td>
                            <td>&nbsp;</td>
                            <td><asp:Label runat="server" ID="lblCenaVecera" CssClass="negative"/></td>
                        </tr>
                        <tr>
                            <td><asp:CheckBox runat="server" ID="chbPiatokVecera2" Text="Bageta" AutoPostBack="true" /></td>
                            <td><asp:CheckBox runat="server" ID="chbSobotaVecera2" Text="Bageta" AutoPostBack="true" /></td>
                            <td>&nbsp;</td>
                            <td><asp:Label runat="server" ID="lblCenaVecera2" CssClass="negative"/></td>
                        </tr>
                        <tr>
                            <td><asp:DropDownList runat="server" ID="ddlUbytovaniePiatokSobota" AutoPostBack="true"/></td>
                            <td><asp:DropDownList runat="server" ID="ddlUbytovanieSobotaNedela" AutoPostBack="true"/></td>
                            <td>&nbsp;</td>
                            <td><asp:Label runat="server" ID="lblCenaUbytovanie" CssClass="negative"/></td>
                        </tr>
                    </table>
                </div>
                <br /><br />
                <div class="multiColumnBlock">
                    <table>
                        <tr>
                            <td>Dar</td>
                            <td><asp:TextBox runat="server" ID="txtDar" Width="100px" AutoPostBack="true" CssClass="negative" /></td>
                        </tr>
                        <tr>
                            <td>Override</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtRegistracnyOverride" Width="100px" AutoPostBack="true" CssClass="negative" />
                                <asp:Button runat="server" ID="btnLenDnes" Text="Len dnes" />
                            </td>
                        </tr>
                        <tr>
                            <td>Spolu</td>
                            <td><asp:Label runat="server" ID="lblTotalCost" CssClass="negative bigFont" /></td>
                        </tr>
                    </table>
                    <asp:Button runat="server" ID="btnSave" Text="Registrovať nového účastníka" OnClick="btnSave_Click" CssClass="bigFont" />
                </div>
            </div>
            <br />
            <asp:Label ID="lblError" runat="server" Text="" CssClass="error"/>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
