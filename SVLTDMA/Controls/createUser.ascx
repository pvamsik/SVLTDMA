<%@ Control Language="C#" AutoEventWireup="true" CodeFile="createUser.ascx.cs" Inherits="Controls_createUser" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:CreateUserWizard ID="CreateUser" runat="server"
    CompleteSuccessText="You have successfully created the user account."
    LoginCreatedUser="False" Width="100%" OnCreatedUser="CreateUser_CreatedUser" OnLoad="CreateUser_Load" CreateUserButtonStyle-CssClass="btn btn-primary" NavigationStyle-CssClass="text-center">
    <WizardSteps>
        <asp:CreateUserWizardStep ID="CreateUserWizard" runat="server" Title="Create new User">
            <ContentTemplate>
                <div class="form-horizontal">
                    <fieldset>
                        <legend>Create User</legend>
                        <div class="form-group">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" SkinID="frmLabel">User Name</asp:Label>
                            <div class="col-lg-1">
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" Display="Dynamic"
                                    ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="col-lg-8">
                                <asp:TextBox ID="UserName" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="NameLabel" runat="server" AssociatedControlID="Name" SkinID="frmLabel">Name</asp:Label>
                            <div class="col-lg-1">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Name" Display="Dynamic"
                                    ErrorMessage="Name is required." ToolTip="Name is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="col-lg-8">
                                <asp:TextBox ID="Name" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="PhoneNumber1Label" runat="server" AssociatedControlID="PhoneNumber1" SkinID="frmLabel">Phone Number 1</asp:Label>
                            <div class="col-lg-1">
                                <asp:RegularExpressionValidator ID="PhoneNumber1_Format" runat="server" ControlToValidate="PhoneNumber1" Display="Dynamic"
                                    ErrorMessage="Phone Number must be in 10-digit US Phone format." ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$" ValidationGroup="CreateUser">*</asp:RegularExpressionValidator>
                            </div>
                            <div class="col-lg-8">
                                <asp:TextBox ID="PhoneNumber1" runat="server" class="form-control"></asp:TextBox>
                                <asp:FilteredTextBoxExtender ID="PhoneNumber1_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="PhoneNumber1">
                                </asp:FilteredTextBoxExtender>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="PhoneNumber2Label" runat="server" AssociatedControlID="PhoneNumber2" SkinID="frmLabel">Phone Number 2</asp:Label>
                            <div class="col-lg-1">
                                <asp:RegularExpressionValidator ID="PhoneNumber2_Format" runat="server" ControlToValidate="PhoneNumber2" Display="Dynamic"
                                    ErrorMessage="Phone Number must be in 10-digit US Phone format." ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$" ValidationGroup="CreateUser">*</asp:RegularExpressionValidator>
                            </div>
                            <div class="col-lg-8">
                                <asp:TextBox ID="PhoneNumber2" runat="server" class="form-control"></asp:TextBox>
                                <asp:FilteredTextBoxExtender ID="PhoneNumber2_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="PhoneNumber2">
                                </asp:FilteredTextBoxExtender>

                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" SkinID="frmLabel">Password</asp:Label>
                            <div class="col-lg-1">
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" Display="Dynamic"
                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="col-lg-8">
                                <asp:TextBox ID="Password" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword" SkinID="frmLabel">Confirm Password</asp:Label>
                            <div class="col-lg-1">
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" Display="Dynamic"
                                    ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" 
                                    ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="CreateUser"></asp:CompareValidator>
                            </div>
                            <div class="col-lg-8">
                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" SkinID="frmLabel">E-mail</asp:Label>
                            <div class="col-lg-1">
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" Display="Dynamic"
                                    ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="EmailFormat" runat="server" ControlToValidate="Email" Display="Dynamic"
                                    ErrorMessage="Email must be in example@example.com format." ToolTip="Email is Required" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CreateUser">*</asp:RegularExpressionValidator>
                            </div>
                            <div class="col-lg-8">
                                <asp:TextBox ID="Email" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="ChooseUserRoleLabel" runat="server" AssociatedControlID="rblRoleList" SkinID="frmLabel">Choose User Role</asp:Label>
                            <div class="col-lg-1"></div>
                            <div class="col-lg-8">
                                <asp:RadioButtonList ID="rblRoleList" runat="server" DataTextField="RoleName" DataValueField="RoleName"></asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                            <div class="col-lg-8">
                            </div>
                        </div>
                    </fieldset>
                </div>
            </ContentTemplate>
        </asp:CreateUserWizardStep>
        <asp:CompleteWizardStep ID="Complete" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td align="center">Complete</td>
                    </tr>
                    <tr>
                        <td>You have successfully created the user account.</td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Continue" PostBackUrl="" CssClass="btn btn-primary" 
                                Text="Complete" ValidationGroup="CreateUser" OnClick="ContinueButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:CompleteWizardStep>
    </WizardSteps>
</asp:CreateUserWizard>
<asp:Label runat="server" ID="lblError" Text="" Visible="false"></asp:Label>
<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="SELECT [RoleName] FROM [Roles]"></asp:SqlDataSource>
