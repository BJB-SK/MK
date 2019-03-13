<%@ Control Language="C#" AutoEventWireup="true" Inherits="RegistrationInfo" Codebehind="RegistrationInfo.ascx.cs" %>

<div class="normalText">
    <div class="box">
        <asp:TextBox runat="server" ID="txtMeno" Width="300px" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtPriezvisko" Width="300px" AutoPostBack="false" /><br />
        <asp:Panel runat="server" ID="pnlTelefon">
            <asp:TextBox runat="server" ID="txtPhoneNumber" Width="300px" AutoPostBack="false" /><br />
        </asp:Panel>
        <asp:TextBox runat="server" ID="txtEmail" Width="300px" AutoPostBack="false" /><br />
        Zbor: <asp:DropDownList runat="server" ID="ddlZbor" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtZbor" Width="300px" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtPoznamka" TextMode="MultiLine" Rows="5" Width="300px" />
    </div>
    <div class="box">
        <table id="registration">
            <tr>
                <td colspan="4">Registračný poplatok</td>
                <td>
                    <asp:Label runat="server" ID="lblRegistracnyPoplatok" />
                </td>
            </tr>
            <tr>
                <td>&nbsp</td>
            </tr>
            <tr class="daysHeader">
                <td>&nbsp;</td>
                <td>
                    <span>Piatok</span>
                </td>
                <td>
                    <span>Sobota</span>
                </td>
                <td>
                    <span>Nedeľa</span>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
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
                <td>&nbsp;</td>
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
                <td>&nbsp;</td>
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
                <td>&nbsp;</td>
                <td>
                    <asp:CheckBox runat="server" ID="chbUbytovaniePiatokSobota" AutoPostBack="false"/>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chbUbytovanieSobotaNedela" AutoPostBack="false"/>
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:Label runat="server" ID="lblCenaUbytovanie" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:CheckBox runat="server" ID="chbTichaTriedaPiatokSobota" AutoPostBack="false"/>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chbTichaTriedaSobotaNedela" AutoPostBack="false"/>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp</td>
            </tr>
            <tr class="sports">
                <td>Športy</td>
                <td colspan="3">
                    <asp:CheckBox runat="server" ID="chbSach" Text="Šach"/>
                    <asp:CheckBox runat="server" ID="chbPingPong" Text="Ping pong"/>
                </td>
            </tr>
            <tr runat="server" ID="trTricko" class="imgSelector">
                <td>Tričko</td>
                <td colspan="3">
                    <asp:DropDownList runat="server" ID="ddlTricko" AutoPostBack="true" />
                    <br />
                    <asp:RadioButtonList runat="server" ID="rblTricko"
                        BorderStyle="Groove"
                        BorderWidth="1px" 
                        RepeatDirection="Horizontal"
                        RepeatLayout="Flow"
                        RepeatColumns="2">
                        <asp:ListItem Value="zl" Selected="True">
                            <img src='img/TRICKO_zlte.png' alt='Žlté' title='Žlté tričko' width="150"/>
                        </asp:ListItem>
                        <asp:ListItem Value="ru">
                            <img src='img/TRICKO_ruzove.png' alt='Ružové' title='Ružové tričko' width="150"/>
                        </asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblCenaTricko" />
                </td>
            </tr>
            <tr runat="server" ID="trMikina" class="imgSelector">
                <td>Mikina</td>
                <td colspan="3">
                    <asp:DropDownList runat="server" ID="ddlMikina" AutoPostBack="true" />
                    <br />
                    <asp:RadioButtonList runat="server" ID="rblMikina"
                        BorderStyle="Groove"
                        BorderWidth="1px" 
                        RepeatDirection="Horizontal"
                        RepeatLayout="Flow"
                        RepeatColumns="2">
                        <asp:ListItem Value="ci" Selected="True">
                            <img src='img/MIKINA_cierna.png' alt='Čierna' title='Čierna mikina' width="150"/>
                        </asp:ListItem>
                        <asp:ListItem Value="zl">
                            <img src='img/MIKINA_zlta.png' alt='Žltá' title='Žltá mikina' width="150"/>
                        </asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblCenaMikina" />
                </td>
            </tr>
            <tr>
                <td>Slúžiaci</td>
                <td colspan="3">
                    <asp:DropDownList runat="server" ID="ddlJob" AutoPostBack="true" />
                </td>
            </tr>
            <tr>
                <td>Spolu</td>
                <td colspan="3">
                    <asp:Button runat="server" ID="btnRecalculate" Text="Prepočítať" />
                </td>
                <td>
                    <asp:Label runat="server" ID="lblTotalCost" />
                </td>
            </tr>
        </table>
    </div>
</div>
