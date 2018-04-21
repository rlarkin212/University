<%@ Page Title="Add Module" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddModule.aspx.cs" Inherits="CIT12.Admin.AdminAddModule" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Add Module</li>
    </ul>

    <div class="heading">
        <h3>Add Module</h3>
    </div>


    <asp:Panel ID="pnlAddModule" runat="server">
        <div class="container">

            <div class="form-group">
                <label class="control-label" for="ddlCourse">Course</label>
                <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label class="control-label" for="txtModuleTitle">Module Title</label>
                <asp:TextBox ID="txtModuleTitle" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="control-label" for="txtModuleCode">Module Code</label>
                <asp:TextBox ID="txtModuleCode" runat="server" CssClass="form-control" Placeholder="eg. CSC-2047"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="control-label" for="ddlLevel">Level</label>
                <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label class="control-label" for="ddlSemester">Semester</label>
                <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label class="control-label" for="txtCAT">CAT Points</label>
                <asp:TextBox ID="txtCatPoints" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="control-label" for="ddlPreReq">Pre-Requisite Modules</label>
                <asp:TextBox ID="txtPreReq" runat="server" CssClass="form-control"></asp:TextBox>
            </div>



            <asp:Button ID="btnAddModule" runat="server" OnClick="btnAddModule_Click" Text="Add Module" CssClass="btn btn-success btn-lg" />


        </div>
    </asp:Panel>

    <%-----------------------class time panel--------------------%>
    <asp:Panel ID="pnlAddClassTime" runat="server" Visible="true">

        <div class="heading">
            <h3>Set Class Times</h3>
        </div>


        <div class="container">
            <label class="control-label" for="ddlClassType">Class Type</label>
            <asp:DropDownList ID="ddlClassType" runat="server" CssClass="form-control"></asp:DropDownList>


            <label class="control-label" for="ddlDay">Day</label>
            <asp:DropDownList ID="ddlDay" runat="server" CssClass="form-control"></asp:DropDownList>


            <br />
            <small>Please Enter Times In The 24 Hour Format</small>
            <div class="row">

                <div class="col-md-4">
                    <label class="control-label" for="txtStartTime">Start</label>
                    <asp:TextBox ID="txtStartTime" runat="server" CssClass="form-control" Placeholder="eg.09:00"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <label class="control-label" for="txtEndTime">End</label>
                    <asp:TextBox ID="txtEndTime" runat="server" CssClass="form-control" Placeholder="eg.10:00"></asp:TextBox>
                </div>
            </div>

            <label class="control-label" for="txtLocation">Location</label>
            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>


            <br />
            <asp:Label ID="lblClassError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            <br />
            <asp:Button ID="btnSubmitClassTimes" runat="server" Text="Add Class" CssClass="btn btn-lg btn-success" OnClick="btnSubmitClassTimes_Click" />

        </div>
    </asp:Panel>



</asp:Content>
