<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateASprint.aspx.cs" Inherits="CIT12.CreateASpriint" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="UserProjects.aspx">User Projects</a></li>
        <li><a href="Sprints.aspx">Sprints</a></li>
        <li class="active">Create A Sprint</li>
    </ul>


    <div class="heading">
        <h3>Create A Sprint</h3>
    </div>

    <div class="container">

        <div class="form-group">
            <label class="control-label" for="txtSprintName">Sprint Name</label>
            <asp:TextBox ID="txtSprintName" runat="server"></asp:TextBox>
        </div>

        <div class="form-group">
            <label id="lblStart" class="control-label" for="lblSDate">Start Date : </label>
            <asp:Label ID="lblSDate" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnStart" runat="server" Text="Pick a date" OnClick="btnStart_Click" CssClass="btn btn-primary" />
            <asp:Calendar ID="CalendarStart" runat="server" OnSelectionChanged="CalendarStart_SelectionChanged" OnDayRender="CalendarStart_DayRender"></asp:Calendar>
        </div>

        <div class="form-group">
            <label ID="lblEnd" runat="server" class="control-label" for="lblEdate">End Date : </label>
            <asp:Label ID="lblEDate" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnEnd" runat="server" Text="Pick a date" OnClick="btnEnd_Click" CssClass="btn btn-primary" />
            <asp:Calendar ID="CalendarEnd" runat="server" OnSelectionChanged="CalendarEnd_SelectionChanged" OnDayRender="CalendarEnd_DayRender"></asp:Calendar>
        </div>

        <br />
        <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add Sprint" CssClass="btn btn-lg btn-success" />

    </div>

</asp:Content>
