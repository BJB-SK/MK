<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Inherits="List" Codebehind="default.aspx.cs" %>

<asp:Content ID="Content" ContentPlaceHolderID="Body" Runat="Server">
    <table>
        <tr>
            <td>Rozsah</td>
            <td>
                <asp:TextBox runat="server" ID="txtFrom" AutoPostBack="true" Width="20px"/>
                &nbsp;-&nbsp;
                <asp:TextBox runat="server" ID="txtTo" AutoPostBack="true" Width="20px"/>
            </td>
        </tr>
        <tr>
            <td>Meno</td>
            <td>
                <asp:TextBox runat="server" ID="txtName" AutoPostBack="true" Width="300px"/>
            </td>
            <td>
                <asp:Button runat="server" ID="btnClearName" Text="Všetky" OnClick="btnClearName_Click" />
            </td>
        </tr>
        <tr>
            <td>Zo zboru</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlChurch" AutoPostBack="true"/>
            </td>
            <td>
                <asp:Button runat="server" ID="btnClearChurch" Text="Všetky" OnClick="btnClearChurch_Click" />
            </td>
        </tr>
        <tr>
            <td>Má objednané</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlProduct" AutoPostBack="true"/>
            </td>
            <td>
                <asp:Button runat="server" ID="btnClearProduct" Text="Všetky" OnClick="btnClearProduct_Click" />
            </td>
        </tr>
        <tr>
            <td>Je v službe</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlJob" AutoPostBack="true"/>
            </td>
            <td>
                <asp:Button runat="server" ID="btnClearJob" Text="Všetky" OnClick="btnClearJob_Click" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:CheckBox runat="server" ID="chbArrived" AutoPostBack="true" Text="Prišli" />
                <asp:CheckBox runat="server" ID="chbNotArrived" AutoPostBack="true" Text="Neprišli" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Nájdených</td>
            <td><asp:Label runat="server" ID="lblCount" /></td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <asp:GridView runat="server" ID="gridResults"  
        AllowPaging="False"
        AllowSorting="False" 
        PageSize="20"
        AutoGenerateColumns="false" 
        OnRowCommand="gridResults_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Meno" SortExpression="FirstName">
                <ItemTemplate>
                    <a href='<%# String.Format("/Detail.aspx?id={0}", Eval(TableColumns.Id)) %>'>
                        <%# Eval(TableColumns.FirstName) %>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Priezvisko" SortExpression="LastName">
                <ItemTemplate>
                    <a href='<%# String.Format("/Detail.aspx?id={0}", Eval(TableColumns.Id)) %>'>
                        <%# Eval(TableColumns.LastName) %>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Zbor" SortExpression="Church">
                <ItemTemplate>
                    <%# Eval(TableColumns.Church) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Preplatok" SortExpression="Surplus">
                <ItemTemplate>
                    <asp:Label ID="lblSuma" runat="server" 
                        Text='<%# CashBackFormat(Eval(TableColumns.Surplus)) %>' 
                        CssClass='<%# CashBackClass(Eval(TableColumns.Surplus)) %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Akcia">
                <ItemTemplate>
                    <asp:HiddenField runat="server" ID="hdnIdUser" Value='<%# Eval(TableColumns.Id) %>'/>
                    <asp:HiddenField runat="server" ID="hdnAmount" Value='<%# Eval(TableColumns.Surplus) %>'/>
                    <asp:Button runat="server" ID="btnDoplatil"  
                        Visible='<%# (float)Eval(TableColumns.Surplus) < 0 %>' 
                        Text='<%# string.Format("Doplatili {0:0.00} euro", -(float)Eval(TableColumns.Surplus)) %>'
                        CommandName="Doplatili" 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    <asp:Button runat="server" ID="btnVratili" 
                        Visible='<%# (float)Eval(TableColumns.Surplus) > 0 %>' 
                        Text='<%# string.Format("Vrátili sme {0:0.00} euro", Eval(TableColumns.Surplus)) %>' 
                        CommandName="Vratili" 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    <asp:Button runat="server" ID="btnDaroval"
                        Visible='<%# (float)Eval(TableColumns.Surplus) > 0 %>' 
                        Text='<%# string.Format("Darovali nám {0:0.00} euro", Eval(TableColumns.Surplus)) %>' 
                        CommandName='Darovali' 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    <asp:Button runat="server" ID="btnPrisli"
                        Visible='<%# !(bool)Eval(TableColumns.ShowedUp) %>' 
                        Text='Prišli'
                        CommandName='Prisli' 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
