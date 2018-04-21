<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CIT12.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <h3 class="panel-title">Login</h3>
            </div>

            <%--panel body--%>
            <div class="panel-body">

                <div class="form-group">
                    <label class="control-label" for="txtNumber">Student / Staff Number</label>
                    <asp:TextBox ID="txtLoginNumber" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label class="control-label" for="txtLoginPassword">Password </label>
                    <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblLoginErrorText" runat="server" Text="" CssClass="text-danger"></asp:Label>
                </div>

                <div class="form-group">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success btn-lg" OnClick="btnLogin_Click"/>
                </div>

                <hr />

                <div class="form-group">
                    <asp:Button ID="btnForgotPassword" runat="server" Text="Forgot Password ?" CssClass="btn btn-primary btn-lg" OnClick="btnForgotPassword_Click" />
                </div>


            </div>

        </div>
    </div>




</asp:Content>
