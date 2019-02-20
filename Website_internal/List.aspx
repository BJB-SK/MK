<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="List" %>

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
            <td>Zbor</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlChurch" AutoPostBack="true"/>
            </td>
            <td>
                <asp:Button runat="server" ID="btnClearChurch" Text="Všetky" OnClick="btnClearChurch_Click" />
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
    </table>
    <br />
    <asp:GridView runat="server" ID="gridResults"  
        AllowPaging="False"
        AllowSorting="False" 
        PageSize="20"
        AutoGenerateColumns="false" 
        OnRowCommand="gridResults_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Meno" SortExpression="Meno">
                <ItemTemplate>
                    <a href='<%# String.Format("/Detail.aspx?id={0}", Eval(TableColumns.Id)) %>'>
                        <%# Eval(TableColumns.Meno) %>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Priezvisko" SortExpression="Priezvisko">
                <ItemTemplate>
                    <a href='<%# String.Format("/Detail.aspx?id={0}", Eval(TableColumns.Id)) %>'>
                        <%# Eval(TableColumns.Priezvisko) %>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <%--
            <asp:TemplateField HeaderText="Zbor" SortExpression="Zbor">
                <ItemTemplate>
                    <%# Eval(TableColumns.Zbor) %>
                </ItemTemplate>
            </asp:TemplateField>
            --%>
            <asp:TemplateField HeaderText="Tričko" SortExpression="Tricko">
                <ItemTemplate>
                    <%# Eval(TableColumns.Tricko) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Mikina" SortExpression="Mikina">
                <ItemTemplate>
                    <%# Eval(TableColumns.Mikina) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Preplatok" SortExpression="Preplatok">
                <ItemTemplate>
                    <asp:Label ID="lblSuma" runat="server" 
                        Text='<%# CashBackFormat(Eval(TableColumns.Preplatok)) %>' 
                        CssClass='<%# CashBackClass(Eval(TableColumns.Preplatok)) %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Akcia">
                <ItemTemplate>
                    <asp:HiddenField runat="server" ID="hdnIdUser" Value='<%# Eval(TableColumns.Id) %>'/>
                    <asp:HiddenField runat="server" ID="hdnAmount" Value='<%# Eval(TableColumns.Preplatok) %>'/>
                    <asp:Button runat="server" ID="btnDoplatil"  
                        Visible='<%# (float)Eval(TableColumns.Preplatok) < 0 %>' 
                        Text='<%# string.Format("Doplatili {0:0.00} euro", -(float)Eval(TableColumns.Preplatok)) %>'
                        CommandName="Doplatili" 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    <asp:Button runat="server" ID="btnVratili" 
                        Visible='<%# (float)Eval(TableColumns.Preplatok) > 0 %>' 
                        Text='<%# string.Format("Vrátili sme {0:0.00} euro", Eval(TableColumns.Preplatok)) %>' 
                        CommandName="Vratili" 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    <asp:Button runat="server" ID="btnDaroval"
                        Visible='<%# (float)Eval(TableColumns.Preplatok) > 0 %>' 
                        Text='<%# string.Format("Darovali nám {0:0.00} euro", Eval(TableColumns.Preplatok)) %>' 
                        CommandName='Darovali' 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                    <asp:Button runat="server" ID="btnPrisli"
                        Visible='<%# !(bool)Eval(TableColumns.Prisli) %>' 
                        Text='Prišli'
                        CommandName='Prisli' 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
