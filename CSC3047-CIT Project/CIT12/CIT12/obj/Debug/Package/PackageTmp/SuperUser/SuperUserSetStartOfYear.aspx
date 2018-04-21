<%@ Page Title="Set Academic Year Start Date" Language="C#" MasterPageFile="~/SuperUser/SuperUser.Master" AutoEventWireup="true" CodeBehind="SuperUserSetStartOfYear.aspx.cs" Inherits="CIT12.SuperUser.SuperUserSetStartOfYear" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="SuperUserHome.aspx">Home</a></li>
        <li class="active">Set Academic Year Start Date</li>
    </ul>


    <div class="row">
        <h3>Set Academic Year Start Date</h3>
        <small>Set the date for the star of the academic year</small>
    </div>

    <br />

    <div class="row">
        <asp:Calendar ID="calDeadlineDate" runat="server" OnSelectionChanged="calDeadlineDate_SelectionChanged"></asp:Calendar>
        <hr />
    </div>

    <div class="row">
        <label class="control-label" for="txtDeadlineDate">Academic Year Start Date</label>
        <br />
        <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
        <br />
        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
        <br />
        <asp:Button ID="btnSubmitDate" runat="server" Text="Set Deadline" CssClass="btn btn-lg btn-success" OnClick="btnSubmitDate_Click"/>
    </div>
















</asp:Content>
