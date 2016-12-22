<%@ Page Language="C#" MasterPageFile="~/MasterPageIndex.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="Register" %>
<%@ Register TagPrefix="uc" TagName="RegistrationInfo" Src="~/Controls/RegistrationInfo.ascx" %>

<asp:Content runat="server" ID="ContentRegistrationHead" ContentPlaceHolderID="RegistrationHead">
    <link href="/css/Public.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/scripts/jquery-3.1.1.min.js"></script> 
</asp:Content>

<asp:Content runat="server" ID="ContentRegistrationBody" ContentPlaceHolderID="RegistrationBody">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager" />
        <div>
    <asp:UpdatePanel runat="server" ID="upRegistration">
        <ContentTemplate>
            <asp:UpdateProgress runat="server" ID="UpdateProgress1" AssociatedUpdatePanelID="upRegistration" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="centeredOverlay">
                        <asp:Label runat="server" ID="lblPleaseWait" Text="Prosím čakajte" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:RadioButtonList runat="server" ID="rblMena" AutoPostBack="true" RepeatDirection="Horizontal" RepeatLayout="Table" />
            <ajax:TabContainer runat="server" ID="tabContainer" UseVerticalStripPlacement="false">
                <ajax:TabPanel runat="server" ID="tabPanelPoplatky" HeaderText="Poplatky" CssClass="normalText">
                    <ContentTemplate>
                        Registračný poplatok závisí od <b>dátumu zaplatenia (datum odoslania penazí z účtu), nie od dátumu registrácie</b>.<br />
                        Registácia, ktorá nebude zaplatená do 15.2.2017 bude zrušená.
                        <br />
                        <asp:GridView ID="gridPoplatky" runat="server" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Platba dorazí do">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblTo" 
                                            Text='<%# ((DateTime)Eval("To")).ToString("dd.MM.yyyy") %>'
                                            CssClass='<%# Eval("CssClass") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Poplatok">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblAmount" 
                                            Text='<%# Eval("CostString") %>' 
                                            CssClass='<%# Eval("CssClass") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                        Pri registrácii na mieste platia takéto poplatky:
                        <asp:GridView ID="gridPoplatkyNaMieste" runat="server" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Typ">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblComment" Text='<%# Eval("Comment") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Poplatok">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Label1" Text='<%# Eval("CostString") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </ajax:TabPanel>
                <ajax:TabPanel runat="server" ID="tabPanelSummary" HeaderText="Zhrnutie" CssClass="normalText">
                    <ContentTemplate>
                        <asp:GridView ID="gridSummary" runat="server" AutoGenerateColumns="false" OnRowCommand="gridView_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Meno">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblTitle" Text='<%# Eval("Title") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Chyby">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblErrors" Text='<%# Eval("ErrorString") %>' CssClass='<%# Eval("CssClass") %> '/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Suma">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSuma" Text='<%# Eval("CostString") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Akcia">
                                    <ItemTemplate>
                                        <asp:Button runat="server" ID="btnDeleteUser"
                                            Text="Zmazať"
                                            CommandName="Vymazat" 
                                            CommandArgument='<%# Eval("Id") %>' 
                                            Visible='<%# !(bool)Eval("Single") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                        <table>
                            <tr>
                                <td>
                                    Sponzorský dar
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtDar" Width="50px" AutoPostBack="true" />
                                    <asp:Label runat="server" ID="lblMena" />
                                    <asp:Label runat="server" ID="lblSponzorskyDar" CssClass="error"/>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Celková suma ktorú<br />bude treba uhradiť
                                </td>
                                <td>
                                    <b><asp:Label ID="lblSuma" runat="server" /></b>
                                </td>
                            </tr>

                            <tr runat="server" id="trPayerEmail">
                                <td>
                                    Email o platbe poslať na
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtEmail" Width="300px" AutoPostBack="true"/><br />
                                    <asp:Button runat="server" ID="btnAddAtSign" Text="@" AutoPostBack="false" />
                                    <asp:Button runat="server" ID="btnAddGmail" Text="@gmail.com" AutoPostBack="false" />
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Kontrolná otázka
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCaptcha" Width="400px" AutoPostBack="true"/>
                                </td>
                            </tr>

                        </table>
                    </ContentTemplate>
                </ajax:TabPanel>
            </ajax:TabContainer>
            <asp:Button runat="server" ID="btnPrevious" Text="<< Naspäť" OnClick="btnPrevious_Click" />
            <asp:Button runat="server" ID="btnRemove" Text="Zmazať" OnClick="btnRemove_Click"/>
            <asp:Button runat="server" ID="btnAddUser" Text="Pridať účastníka" OnClick="btnAddUser_Click" />
            <asp:Button runat="server" ID="btnNext" Text="Ďalej >>" OnClick="btnNext_Click" />
            <br />
            <asp:Label ID="lblResult" runat="server" CssClass="error"/>
        </ContentTemplate>
    </asp:UpdatePanel>
                     </div>
    </form>
</asp:Content>
