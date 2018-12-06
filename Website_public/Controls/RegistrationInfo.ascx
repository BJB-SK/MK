<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RegistrationInfo.ascx.cs" Inherits="RegistrationInfo" %>

<div class="normalText">
    <div class="box">
        <asp:TextBox runat="server" ID="txtMeno" Width="300px" AutoPostBack="false" /><br />
        <asp:TextBox runat="server" ID="txtPriezvisko" Width="300px" AutoPostBack="false" /><br />
        <asp:Panel runat="server" ID="pnlTelefon">
            <asp:TextBox runat="server" ID="txtTelefon" Width="300px" AutoPostBack="false" /><br />
        </asp:Panel>
        <asp:TextBox runat="server" ID="txtEmail" Width="300px" AutoPostBack="false" /><br />
        <!--<asp:Button runat="server" ID="btnAddAtSign" Text="@" />
        <asp:Button runat="server" ID="btnAddGmail" Text="@gmail.com" /><br />-->
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
                    <!--<asp:Button runat="server" ID="btnVsetkoPiatok" Text="Piatok" />
                    <asp:Button runat="server" ID="btnNicPiatok" Text="x" />-->
                </td>
                <td>
                    <span>Sobota</span>
                    <!--<asp:Button runat="server" ID="btnVsetkoSobota" Text="Sobota" />
                    <asp:Button runat="server" ID="btnNicSobota" Text="x" />-->
                </td>
                <td>
                    <span>Nedeľa</span>
                    <!--<asp:Button runat="server" ID="btnVsetkoNedela" Text="Nedeľa" />
                    <asp:Button runat="server" ID="btnNicNedela" Text="x" />-->
                </td>
                <td>
                    <!--<asp:Button runat="server" ID="btnVsetko" Text="VŠETKO!" />
                    <asp:Button runat="server" ID="btnNic" Text="x" />-->
                </td>
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
            <tr class="imgSelector">
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
                        <asp:ListItem Value="žlté" Selected="True">
                            <img src='img/TRICKO_zlte.png' alt='Žlté' title='Žlté tričko' width="150"/>
                        </asp:ListItem>
                        <asp:ListItem Value="ružové">
                            <img src='img/TRICKO_ruzove.png' alt='Ružové' title='Ružové tričko' width="150"/>
                        </asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblCenaTricko" />
                </td>
            </tr>
            <tr class="imgSelector">
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
                        <asp:ListItem Value="čierna" Selected="True">
                            <img src='img/MIKINA_cierna.png' alt='Čierna' title='Čierna mikina' width="150"/>
                        </asp:ListItem>
                        <asp:ListItem Value="žltá">
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
                    <asp:DropDownList runat="server" ID="ddlSluziaci" AutoPostBack="true" /><br />
                    <asp:DropDownList runat="server" ID="ddlDobrovolnik" AutoPostBack="false" />
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
