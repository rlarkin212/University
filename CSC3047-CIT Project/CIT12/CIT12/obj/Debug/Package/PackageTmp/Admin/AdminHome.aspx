<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="CIT12.Admin.AdminHome" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>Admin Home</h3>
    </div>

    <div class="container">
        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Manage Academic</h3>
                    </div>
                    <div class="panel-body">
                        <p>Manage Academic Info eg. Add A Course</p>
                        <a class="btn btn-primary" href="AdminManageAcademic.aspx">Manage Academic</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Manage Student</h3>
                    </div>
                    <div class="panel-body">
                        <p>Manage Student Info eg. Set Status</p>
                        <a class="btn btn-primary" href="AdminManageStudent.aspx">Manage Student</a>
                    </div>
                </div>
            </div>


        </div>

        <%--second row--%>
        <div class="row">
            
        </div>

        <div class="row">
            <h5><u>Academic Tools</u></h5>
            <div class="clearfix"></div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Academic Tools</h3>
                    </div>
                    <div class="panel-body">
                        <p>Access all of the academic functionality</p>
                        <a class="btn btn-primary" href="../Academic/AcademicHome.aspx">Academic Tools</a>
                    </div>
                </div>
            </div>
        </div>

        <%--end of container--%>
    </div>


</asp:Content>
