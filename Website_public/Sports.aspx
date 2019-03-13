<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Inherits="Sports" Codebehind="Sports.aspx.cs" %>

<asp:Content ID="Content" ContentPlaceHolderID="Body" Runat="Server">
    <asp:UpdatePanel runat="server" ID="upRegistration">
        <ContentTemplate>
            <asp:UpdateProgress runat="server" ID="UpdateProgress1" AssociatedUpdatePanelID="upRegistration" DisplayAfter="500" />
            <%-- <div class="whiteText"> --%>
            <h2>Športový tím</h2>
            <h3>Volejbal</h3>
            Každé družstvo musí mať aspoň jedno dievča. V družstve môže byť max 8-9 ľudí.
            
            <h3>Futbal</h3>
            Futbal sa hrá 4+1. Prihlasuje sa celé družstvo. Ak niekto nemá družstvo a chce hrať môže sa prihlásiť ako jednotlivec. Max v druzstve je 7 ľudí.
            <h3>Floorbal</h3>
            Floorbal sa hrá 5+1. Prihlasovanie ako na futbal. Za meno do zátvorky napísať, či daný hráč má hokejku, alebo mu treba požičať. Max v družstve je 8 ludí. <br />
            Futbal a floorbal sa budú hrať tiež v hlavnej telocvični. <br /><br />
            <table>
                <tr>
                    <td>Šport</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlSport" />
                    </td>
                </tr>

                <tr>
                    <td>Meno tímu</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtName" Width="300px" />
                        <asp:Label runat="server" ID="lblNameError" CssClass="error"/>
                    </td>
                </tr>

                <tr>
                    <td>Hráč 1</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtHrac1" Width="300px" />
                    </td>
                </tr>

                <tr>
                    <td>Hráč 2</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtHrac2" Width="300px" />
                    </td>
                </tr>

                <tr>
                    <td>Hráč 3</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtHrac3" Width="300px" />
                    </td>
                </tr>

                <tr>
                    <td>Hráč 4</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtHrac4" Width="300px" />
                    </td>
                </tr>

                <tr>
                    <td>Hráč 5</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtHrac5" Width="300px" />
                    </td>
                </tr>

                <tr>
                    <td>Hráč 6</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtHrac6" Width="300px" />
                    </td>
                </tr>

                <tr>
                    <td>Hráč 7</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtHrac7" Width="300px" />
                    </td>
                </tr>

                <tr style="display:none">
                    <td>Kontrolná<br />otázka</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCaptcha" Width="300px" AutoPostBack="true"/><br />
                        <asp:Label runat="server" ID="lblCaptchaError" CssClass="error"/>
                    </td>
                </tr>

            </table>
            <br />
            <asp:Button ID="btnRegister" runat="server" Text="Registrovať" OnClick="btnRegister_Click" />
            <asp:Label runat="server" ID="lblErrorOnPage"/>
            <br />
            <br />
            <asp:Label ID="lblResult" runat="server" Text="" CssClass="error"/>
            <%-- </div> --%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
