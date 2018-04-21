<%@ Page Title="Admin Edit Course" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditCourse.aspx.cs" Inherits="CIT12.Admin.AdminEditCourse" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>Edit Course Information</h3>
    </div>

    <div class="container">


        <label class="control-label" for="txtTitle"> Title:</label>
        <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
        <br />

        <label class="control-label" for="txtCode"> Code:</label>
        <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>

         <br />
        <asp:CheckBox ID="cbActive" runat="server" CssClass="checkbox" />

         <br />
        <asp:Button ID="btnUpdate" runat="server" class="btn btn-primary" Text="Update Course Details" OnClick="btnUpdate_Click" />


    </div>
</asp:Content>

