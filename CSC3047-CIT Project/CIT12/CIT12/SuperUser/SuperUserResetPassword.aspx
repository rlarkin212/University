<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/SuperUser/SuperUser.Master" AutoEventWireup="true" CodeBehind="SuperUserResetPassword.aspx.cs" Inherits="CIT12.SuperUser.SuperUserResetPassword" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <ul class="breadcrumb">
        <li><a href="SuperUserHome.aspx">Home</a></li>
        <li class="active">Reset Password</li>
    </ul>

    <div class="heading">
        <h3>Reset Password</h3>
        <small>A Users Password Will Be Reset To The First park Of Their Email Address</small>
    </div>

    <br />

    <div class="alert alert-success alert-dismissable" id="successAlert" runat="server" visible="false">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Success!</strong> The Users Password Has Been Changed
    </div>

    <div class="form">
        <fieldset>

            <div class="form-group">
                <label class="control-label" for="txtNumber">Student / Staff Number</label>
                <asp:TextBox ID="txtNumber" runat="server" CssClass="form-control"></asp:TextBox>
            </div>


            <div class="form-group">
                <asp:Label ID="lblErrorText" runat="server" Text="" CssClass="text-danger"></asp:Label>
            </div>

            <div class="form-group">
                <asp:Button ID="btnSubmitPassword" runat="server" Text="Change Password" CssClass="btn btn-success btn-lg" OnClick="btnSubmitPassword_Click" />
            </div>

        </fieldset>
    </div>





</asp:Content>
