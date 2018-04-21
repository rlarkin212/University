<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="CIT12.ForgotPassword" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>Forgot Password</h3>
    </div>

    <%--panel check user exists & email code --%>
    <asp:Panel ID="pnlCheckUser" runat="server">

        <div class="container">

            <div class="form-group">
                <label class="control-label" for="txtNumber">Student / Staff Number</label>
                <asp:TextBox ID="txtNumberCheck" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lblCheckErrorMessage" runat="server" Text="" CssClass="text-danger"></asp:Label>
                <br />  
                <asp:Button ID="btnCheck_Send" runat="server" Text="Send Request" CssClass="btn btn-primary btn-lg" OnClick="btnCheck_Send_Click" />
            </div>

        </div>

    </asp:Panel>


    <%--panel update password--%>
    <asp:Panel ID="pnlUpdatePassword" runat="server" Visible="false">
        <div class="container">

            <div class="row">

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label class="control-label" for="txtConfirmNumber">Confirm Student / Staff Number</label>
                    <asp:TextBox ID="txtConfirmNumber" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <%--enter key section --%>
                <div class="clearfix"></div>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label class="control-label" for="txtKey">Key</label>
                    <asp:TextBox ID="txtKey" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                </div>

                <%--enter password section --%>
                <div class="clearfix"></div>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label class="control-label" for="txtPassword">New Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regexPassword" runat="server" ControlToValidate="txtPassword"
                        ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ErrorMessage="Password must contain: Minimum 8 characters at least 1 Alphabet and 1 Number" ForeColor="Red" />
                </div>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label class="control-label" for="txtPassword">Re-enter Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>

                <%--error message area--%>
                <div class="clearfix"></div>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <asp:Label ID="lblErrorText" runat="server" Text="" CssClass="text-danger"></asp:Label>
                </div>


            </div>

        </div>

        <div class="clearfix"></div>
        <asp:Button ID="btnSubmitPassword" runat="server" Text="Change Password" CssClass="btn btn-success btn-lg" OnClick="btnSubmitPassword_Click" />

    </asp:Panel>


</asp:Content>
