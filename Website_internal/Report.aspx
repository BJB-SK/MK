<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Inherits="Report" Codebehind="Report.aspx.cs" %>

<asp:Content ID="Content" ContentPlaceHolderID="Body" Runat="Server">
    <table>
        <tr>
            <td>Účastníci:</td>
            <td>
                <asp:Label runat="server" ID="lblRegisteredPeople"/>
            </td>
        </tr>
        <tr>
            <td>Prišli:</td>
            <td>
                <asp:Label runat="server" ID="lblPeopleWhoShowedUp"/>
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
    </table>
    <br />
    <div>
        <div class="inlineBlock">
            <asp:GridView ID="gridProducts" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Produkt">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Vyrobené">
                        <ItemTemplate>
                            <%# Eval("Available") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Objednané">
                        <ItemTemplate>
                            <%# Eval("Ordered") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Zaplatené">
                        <ItemTemplate>
                            <%# Eval("Paid") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Zvýšilo">
                        <ItemTemplate>
                            <%# Eval("NotOrdered") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
        <div class="inlineBlock">
            <asp:GridView ID="gridJobs" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Slúžiaci">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nahlásilo sa">
                        <ItemTemplate>
                            <%# Eval("Count") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Potrebujeme">
                        <ItemTemplate>
                            <%# Eval("Max") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
        <div class="inlineBlock">
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
    <asp:GridView ID="gridNotes" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Poznámka">
                <ItemTemplate>
                    <%# Eval("Note") %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>