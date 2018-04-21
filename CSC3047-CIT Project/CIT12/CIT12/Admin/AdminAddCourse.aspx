<%@ Page Title="Add Course" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddCourse.aspx.cs" Inherits="CIT12.Admin.AdminAddCourseaspx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Add Course</li>
    </ul>

    <div class="heading">
        <h3>Add Course</h3>
    </div>

    <div class="form-group">
        <label class="control-label" for="ddlSchool">School</label>
        <asp:DropDownList ID="ddlSchool" runat="server" CssClass="form-control"></asp:DropDownList>
    </div>

    <div class="form-group">
        <label class="control-label" for="txtName">Name</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ID="rfvName" ControlToValidate="txtName" ErrorMessage="Please Enter A Name" ForeColor="Red" />
    </div>

    <div class="form-group">
        <label class="control-label" for="txtCode">Code</label>
        <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" Placeholder="eg. CIT"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ID="rfvCode" ControlToValidate="txtCode" ErrorMessage="Please Enter A Code" ForeColor="Red" />
    </div>


    <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
    <br />
    <asp:Button ID="btnAddCourse" runat="server" Text="Submit" CssClass="btn btn-lg btn-success" OnClick="btnAddCourse_Click" />

</asp:Content>
