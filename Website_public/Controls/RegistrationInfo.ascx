<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RegistrationInfo.ascx.cs" Inherits="RegistrationInfo" %>

<div class="normalText">
    <div class="box">
        <asp:TextBox runat="server" ID="txtMeno" Width="300px" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtPriezvisko" Width="300px" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtTelefon" Width="300px" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtEmail" Width="300px" AutoPostBack="false" /><br />
        <asp:Button runat="server" ID="btnAddAtSign" Text="@" />
        <asp:Button runat="server" ID="btnAddGmail" Text="@gmail.com" /><br />
        <asp:DropDownList runat="server" ID="ddlZbor" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtZbor" Width="300px" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtPoznamka" TextMode="MultiLine" Rows="5" Width="300px" />
    </div>
    <div class="box">
        <table>
            <tr>
                <td colspan="3">Registračný poplatok</td>
                <td>
                    <asp:Label runat="server" ID="lblRegistracnyPoplatok" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btnVsetkoPiatok" Text="Piatok" />
                    <asp:Button runat="server" ID="btnNicPiatok" Text="x" />
                </td>
                <td>
                    <asp:Button runat="server" ID="btnVsetkoSobota" Text="Sobota" />
                    <asp:Button runat="server" ID="btnNicSobota" Text="x" />
                </td>
                <td>
                    <asp:Button runat="server" ID="btnVsetkoNedela" Text="Nedeľa" />
                    <asp:Button runat="server" ID="btnNicNedela" Text="x" />
                </td>
                <td>
                    <asp:Button runat="server" ID="btnVsetko" Text="VŠETKO!" />
                    <asp:Button runat="server" ID="btnNic" Text="x" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:CheckBox runat="server" ID="chbSobotaRanajky" AutoPostBack="false" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chbNedelaRanajky" AutoPostBack="false" />
                </td>
                <td>
                    <asp:Label runat="server" ID="lblCenaRanajky" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:CheckBox runat="server" ID="chbSobotaObed" AutoPostBack="false" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chbNedelaObed" AutoPostBack="false" />
                </td>
                <td>
                    <asp:Label runat="server" ID="lblCenaObed" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox runat="server" ID="chbPiatokVecera" AutoPostBack="false" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chbSobotaVecera" AutoPostBack="false" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:Label runat="server" ID="lblCenaVecera" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox runat="server" ID="chbPiatokVecera2" AutoPostBack="false" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chbSobotaVecera2" AutoPostBack="false" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:Label runat="server" ID="lblCenaVecera2" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox runat="server" ID="chbTichaTriedaPiatokSobota" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chbTichaTriedaSobotaNedela" />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Športy</td>
                <td colspan="3">
                    <asp:CheckBox runat="server" ID="chbSach" Text="Šach"/>
                    <asp:CheckBox runat="server" ID="chbPingPong" Text="Ping pong"/>
                </td>
            </tr>
            <tr>
                <td>Tričko</td>
                <td colspan="2">
                    <asp:DropDownList runat="server" ID="ddlTricko" AutoPostBack="true" />
                    <ajax:HoverMenuExtender runat="server" ID="hme1"
                        TargetControlID="ddlTricko"
                        PopupControlID="pnlTricko"
                        HoverCssClass="popupHover"
                        PopupPosition="Right"
                        OffsetX="0"
                        OffsetY="-120"
                        PopDelay="50" />
                    <asp:Panel runat="server" ID="pnlTricko">
                        <asp:Image runat="server" ID="imgTricko" ImageUrl="~/img/tricko.png"/>
                    </asp:Panel>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblCenaTricko" />
                </td>
            </tr>
            <tr>
                <td>Slúžiaci</td>
                <td colspan="3">
                    <asp:DropDownList runat="server" ID="ddlSluziaci" AutoPostBack="true" /><br />
                    <asp:DropDownList runat="server" ID="ddlDobrovolnik" AutoPostBack="false" />
                </td>
            </tr>
            <tr>
                <td colspan="2">Spolu</td>
                <td>
                    <asp:Button runat="server" ID="btnRecalculate" Text="Prepočítať" />
                </td>
                <td>
                    <asp:Label runat="server" ID="lblTotalCost" />
                </td>
            </tr>
        </table>
    </div>
</div>
