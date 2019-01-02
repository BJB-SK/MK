<%@ Page Language="C#" MasterPageFile="~/MasterPageIndex.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="Register" %>
<%@ Reference Control="~/Controls/RegistrationInfo.ascx" %>

<asp:Content runat="server" ID="ContentRegistrationHead" ContentPlaceHolderID="RegistrationHead">
    <link href="/css/Public.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/scripts/jquery-3.3.1.min.js"></script> 
</asp:Content>

<asp:Content runat="server" ID="ContentRegistrationBody" ContentPlaceHolderID="RegistrationBody">
    <form id="form1" runat="server">
        <asp:Panel runat="server" ID="pnlRegistrationDone" CssClass="text-center">
            <h2 class="section-heading">Registrácia skončila</h2>
            <hr class="primary">
            <p class="text-muted">Registrácia cez internet bola ukončená. Registrovať sa bude dať už len na mieste. </p>
        </asp:Panel>
        <asp:ScriptManager runat="server" ID="ScriptManager" />
        <asp:UpdatePanel runat="server" ID="upRegistration">
            <ContentTemplate>
                <asp:UpdateProgress runat="server" ID="UpdateProgress1" AssociatedUpdatePanelID="upRegistration" DisplayAfter="0">
                    <ProgressTemplate>
                        <div class="centeredOverlay">
                            <asp:Label runat="server" ID="lblPleaseWait" Text="Prosím čakajte" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:Panel runat="server" ID="pnlSuccess" CssClass="text-center">
                    <p>Registrácia prebehla úspešne! Počkajte prosím na emaily ktoré vám pošleme.</p>
                </asp:Panel>
                <asp:Panel runat="server" ID="pnlRegistration">
                    <asp:RadioButtonList runat="server" ID="rblMena" AutoPostBack="true" 
                        RepeatDirection="Horizontal" 
                        RepeatLayout="Table"
                        CssClass="currencySwitcher" />
                    <ajax:TabContainer runat="server" ID="tabContainer" UseVerticalStripPlacement="false">
                        <ajax:TabPanel runat="server" ID="tabPanelPoplatky" HeaderText="Poplatky" CssClass="normalText">
                            <ContentTemplate>
                                Registračný poplatok závisí od <b>dátumu zaplatenia (dátum odoslania peňazí z účtu), nie od dátumu registrácie</b>.<br />
                                Registrácia, za ktorú platba nedorazí na náš účet do 14.2.2019, bude zrušená.
                                <br />
                                <asp:GridView ID="gridPoplatky" runat="server" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Platba odoslaná do">
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
                                    <tr class="rows-2 centered">
                                        <td>
                                            Sponzorský dar
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtDar" Width="50px" AutoPostBack="true" />
                                            <asp:Label runat="server" ID="lblMena" />
                                            <asp:Label runat="server" ID="lblSponzorskyDar" CssClass="error"/>
                                        </td>
                                    </tr>

                                    <tr class="rows-2 centered">
                                        <td>
                                            Celková suma ktorú bude treba uhradiť
                                        </td>
                                        <td>
                                            <b><asp:Label ID="lblSuma" runat="server" /></b>
                                        </td>
                                    </tr>

                                    <tr runat="server" id="trPayerEmail" class="rows-2 centered">
                                        <td>
                                            Email o platbe poslať na
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtEmail" Width="300px" AutoPostBack="true"/><br />
                                            <!-- <asp:Button runat="server" ID="btnAddAtSign" Text="@" AutoPostBack="false" />
                                            <asp:Button runat="server" ID="btnAddGmail" Text="@gmail.com" AutoPostBack="false" /> -->
                                        </td>
                                    </tr>

                                    <tr style="display:none">
                                        <td>
                                            Kontrolná otázka
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtCaptcha" Width="400px" AutoPostBack="true"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <h3>GDPR</h3>
                                            <ul>
<li>
    Vaše osobné údaje (ktoré ste zadali v tomto formulári + údaje o platbe) potrebujeme uložiť až po dobu konania konferencie.
</li>
<li>
    Po ukončení konferencie Vám pošleme mail s odkazom na dotazník kde nám môžete dať spätnú väzbu.
</li>
<li>
    Potom všetky údaje čo najrýchlejšie zmažeme.
</li>
<li>
    Nemusíte uviesť svoje skutočné meno / priezvisko (potrebujeme Vás len nejako identifikovať na registrácii),
    ale mail musí sedieť (pošleme Vám tam informácie o platbe).
</li>
<li>
    Telefónne číslo potrebujeme len u dobrovoľníkov, aby sme ich vedeli kontaktovať.
    Telefónne čísla dobrovoľníkov dostanú vedúci služieb na ktoré sa prihlásili.
</li>
<li>
    Ak chcete vedieť aké údaje o Vás máme alebo požiadať o ich zmazanie, 
    prosím napíšte mail na <a href="mailto:mladeznickakonfera@gmail.com">mladeznickakonfera@gmail.com</a>
</li>
                                            </ul>
                                            <br />
                                            <asp:CheckBox runat="server" ID="chbGdprConsent" Text="Súhlasím" CssClass="gdpr" />
                                            <asp:Label runat="server" ID="lblGdprMissing" CssClass="error" Text="<< Prosím prečítajte si GDPR info a zaškrtnite súhlas" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </ajax:TabPanel>
                    </ajax:TabContainer>
                    <div id="button-bar">
                        <asp:Button runat="server" ID="btnPrevious" Text="<< Naspäť" OnClick="btnPrevious_Click" />
                        <asp:Button runat="server" ID="btnRemove" Text="Zmazať" OnClick="btnRemove_Click"/>
                        <asp:Button runat="server" ID="btnAddUser" Text="Pridať účastníka" OnClick="btnAddUser_Click" />
                        <asp:Button runat="server" ID="btnNext" Text="Ďalej >>" OnClick="btnNext_Click" />
                    </div>
                    <br />
                    <asp:Label ID="lblResult" runat="server" CssClass="error"/>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
