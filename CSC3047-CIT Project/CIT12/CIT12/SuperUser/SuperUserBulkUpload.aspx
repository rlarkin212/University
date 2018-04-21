<%@ Page Title="Bulk Upload Users" Language="C#" MasterPageFile="~/SuperUser/SuperUser.Master" AutoEventWireup="true" CodeBehind="SuperUserBulkUpload.aspx.cs" Inherits="CIT12.SuperUser.SuperUserBulkUploadUser" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="SuperUserHome.aspx">Home</a></li>
        <li class="active">Upload Users</li>
    </ul>


    <div class="container">
        <div class="row">
            <h3>Bulk Upload Of User</h3>
            <small>Generic user information will only be uploaded</small>
            <br />
            <small>Please refer to the last Number values when creating a users file</small>
            <br />
            <b><small>The user number must increment from the displayed number</small></b>
            <hr />
        </div>
    </div>


    <div class="container">
        <div class="row">
            <p>Hashed Password Generator For CSV File</p>
            <div class="col-md-4">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                <br />
                <asp:Button ID="btnPasswordGen" runat="server" CssClass="btn btn-primary" Text="Generate Hashed Password" OnClick="btnPasswordGen_Click" />
                <hr />
            </div>
            <div class="col-md-4">
                <label for="lblHashPassword" class="control-label">Hashed Password</label>
                <b>
                    <asp:Label ID="lblHashPassword" runat="server" Text=""></asp:Label></b>
            </div>

        </div>
    </div>


    <div class="container">
        <div class="row">
            <label class="control-label h4" for="lblLastNumber">Last User Number</label>
            <br />
            <asp:Label ID="lblLastNumber" runat="server" Text=""></asp:Label>
        </div>
        <hr />
    </div>


    <div class="container">
        <div class="row">
            <label for="" class="control-label">Upload CSV</label>
            <asp:FileUpload ID="fuCSV" runat="server" />
            <br />
            <asp:Button ID="btnUploadCSV" runat="server" CssClass="btn btn-lg btn-success" Text="Upload" OnClick="btnUploadCSV_Click" />
            <br />
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
        </div>
    </div>





</asp:Content>
