<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CIT12._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>CIT 12</h1>
        <p class="lead">This Is A Tool For Creating And Managing Projects Using Agile Methods</p>
        <p>
            <asp:Button ID="btnGetStarted" CssClass="btn btn-lg btn-primary" runat="server" Text="Get Started" OnClick="btnGetStarted_Click"/></p>
    </div>

    

</asp:Content>
