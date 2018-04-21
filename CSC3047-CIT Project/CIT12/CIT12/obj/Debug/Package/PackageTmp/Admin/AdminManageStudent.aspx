<%@ Page Title="Manage Stuedent Info" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageStudent.aspx.cs" Inherits="CIT12.Admin.AdminManageStudent" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li class="active">Manage Student Info</li>
    </ul>

    <div class="heading">
        <h3>Manage Studnet Info</h3>
    </div>

    <div class="container">
        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Allocate Personal Tutor</h3>
                    </div>
                    <div class="panel-body">
                        <p>Allocate a Personal Tutor To A Student</p>
                        <a class="btn btn-primary" href="AdminAllocatePersonalTutor.aspx">Allocate Personal Tutor</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Allocate Advisor Of Studies</h3>
                    </div>
                    <div class="panel-body">
                        <p>Allocate an Advisor Of Studies To A Student</p>
                        <a class="btn btn-primary" href="AdminAllocateAdvisorOfStudies">Allocate Advosir Of Studies</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Set Student Status</h3>
                    </div>
                    <div class="panel-body">
                        <p>Update a Student Status</p>
                        <a class="btn btn-primary" href="AdminSetStudentStatus.aspx">Set Student Status</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Modify Student Marks</h3>
                    </div>
                    <div class="panel-body">
                        <p>Modify the module marks for a student</p>
                        <a class="btn btn-primary" href="AdminUpdateStudentmarks.aspx">Modify Student Marks</a>
                    </div>
                </div>
            </div>

             <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">View Student Details</h3>
                    </div>
                    <div class="panel-body">
                        <p>View and edit the details for a studnet </p>
                        <a class="btn btn-primary" href="AdminStudentDetails.aspx">View Student Details</a>
                    </div>
                </div>
            </div>


        </div>

        <%--second row--%>


        <%--end of container--%>
    </div>









</asp:Content>
