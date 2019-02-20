<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Report" %>

<asp:Content ID="Content" ContentPlaceHolderID="Body" Runat="Server">
    <div class="multiColumnContainer">
        <div class="multiColumnBlock">
            <table>
                <tr>
                    <td>Účastníci:</td>
                    <td>
                        <asp:Label runat="server" ID="lblRegisteredPeople"/>
                    </td>
                </tr>
                <tr>
                    <td>Očakávame:</td>
                    <td>
                        <asp:Label runat="server" ID="lblExpectingEur"/>
                    </td>
                </tr>
                <tr>
                    <td>Prišlo:</td>
                    <td>
                        <asp:Label runat="server" ID="lblMoneyFromPeople"/>
                    </td>
                </tr>
                <tr>
                    <td>Šach:</td>
                    <td>
                        <asp:Label runat="server" ID="lblSach"/>
                    </td>
                </tr>
                <tr>
                    <td>Ping pong:</td>
                    <td>
                        <asp:Label runat="server" ID="lblPingPong"/>
                    </td>
                </tr>
            </table>
            <br />
        </div>
        <div class="multiColumnBlock">
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td>Pi</td>
                    <td>Za</td>
                    <td>So</td>
                    <td>Za</td>
                    <td>Ne</td>
                    <td>Za</td>
                </tr>
                <tr>
                    <td>Raňajky</td>
                    <td colspan="2">&nbsp;</td>
                    <td><asp:Label runat="server" ID="lblSobotaRanajky" /></td>
                    <td><asp:Label runat="server" ID="lblSobotaRanajkyZaplatene" /></td>
                    <td><asp:Label runat="server" ID="lblNedelaRanajky" /></td>
                    <td><asp:Label runat="server" ID="lblNedelaRanajkyZaplatene" /></td>
                </tr>
                <tr>
                    <td>Obed</td>
                    <td colspan="2">&nbsp;</td>
                    <td><asp:Label runat="server" ID="lblSobotaObed" /></td>
                    <td><asp:Label runat="server" ID="lblSobotaObedZaplatene" /></td>
                    <td><asp:Label runat="server" ID="lblNedelaObed" /></td>
                    <td><asp:Label runat="server" ID="lblNedelaObedZaplatene" /></td>
                </tr>
                <tr>
                    <td>Večera</td>
                    <td><asp:Label runat="server" ID="lblPiatokVecera"/></td>
                    <td><asp:Label runat="server" ID="lblPiatokVeceraZaplatene"/></td>
                    <td><asp:Label runat="server" ID="lblSobotaVecera" /></td>
                    <td><asp:Label runat="server" ID="lblSobotaVeceraZaplatene" /></td>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>Bageta</td>
                    <td><asp:Label runat="server" ID="lblPiatokVecera2" /></td>
                    <td><asp:Label runat="server" ID="lblPiatokVecera2Zaplatene" /></td>
                    <td><asp:Label runat="server" ID="lblSobotaVecera2" /></td>
                    <td><asp:Label runat="server" ID="lblSobotaVecera2Zaplatene" /></td>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>Tichá trieda</td>
                    <td colspan="2">
                        <asp:Label runat="server" ID="lblTichaTriedaPiatokSobota" />
                    </td>
                    <td colspan="2">
                        <asp:Label runat="server" ID="lblTichaTriedaSobotaNedela" />
                    </td>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>Internát 1</td>
                    <td><asp:Label runat="server" ID="lblInternatPiatokSobota1" /></td>
                    <td><asp:Label runat="server" ID="lblInternatPiatokSobotaZaplatene1" /></td>
                    <td><asp:Label runat="server" ID="lblInternatSobotaNedela1" /></td>
                    <td><asp:Label runat="server" ID="lblInternatSobotaNedelaZaplatene1" /></td>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>Internát 2</td>
                    <td><asp:Label runat="server" ID="lblInternatPiatokSobota2" /></td>
                    <td><asp:Label runat="server" ID="lblInternatPiatokSobotaZaplatene2" /></td>
                    <td><asp:Label runat="server" ID="lblInternatSobotaNedela2" /></td>
                    <td><asp:Label runat="server" ID="lblInternatSobotaNedelaZaplatene2" /></td>
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>
            <br />
        </div>
        <div class="multiColumnBlock">
            <asp:GridView ID="gridTShirts" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Tričko">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reg">
                        <ItemTemplate>
                            <%# Eval("Ordered") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Zap">
                        <ItemTemplate>
                            <%# Eval("Paid") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
        <div class="multiColumnBlock">
            <asp:GridView ID="gridHoodies" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Mikina">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reg">
                        <ItemTemplate>
                            <%# Eval("Ordered") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Zap">
                        <ItemTemplate>
                            <%# Eval("Paid") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
        <div class="multiColumnBlock">
            <asp:GridView ID="gridSluziaci" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Slúžiaci">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Počet">
                        <ItemTemplate>
                            <%# Eval("Count") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
        <div class="multiColumnBlock">
            <asp:GridView ID="gridDobrovolnici" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Dobrovoľníci">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Počet">
                        <ItemTemplate>
                            <%# Eval("Count") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
        <div class="multiColumnBlock">
            <asp:GridView ID="gridChurches" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Zbor">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Počet">
                        <ItemTemplate>
                            <%# Eval("Count") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
    </div>
    <asp:GridView ID="gridPoznamky" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Poznámka">
                <ItemTemplate>
                    <%# Eval("Note") %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>