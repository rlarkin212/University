<%@ Page Title="Manage Academic Info" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageAcademic.aspx.cs" Inherits="CIT12.Admin.AdminManageAcademic" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li class="active">Manage Academic Info</li>
    </ul>

    <div class="heading">
        <h3>Manage Academic Info</h3>
    </div>

    <div class="container">
        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Course</h3>
                    </div>
                    <div class="panel-body">
                        <p>Add A Course</p>
                        <a class="btn btn-primary" href="AdminAddCourse">Add A Course To A School</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Module</h3>
                    </div>
                    <div class="panel-body">
                        <p>Add A Module</p>
                        <a class="btn btn-primary" href="AdminAddModule">Add A Module To A Course</a>
                    </div>
                </div>
            </div>


            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Assign Module Advisor Of Studies</h3>
                    </div>
                    <div class="panel-body">
                        <p>Assign an advisor of studies to a module</p>
                        <a class="btn btn-primary" href="AdminAllocateModuleAdvisorOfStudies.aspx">Assign Advisor Of Studies</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Assign Course Academic Program Managers</h3>
                    </div>
                    <div class="panel-body">
                        <p>Assign an academic program manager to a course </p>
                        <a class="btn btn-primary" href="AdminAllocateAcademicProgramManager.aspx">Assign Academic Program Manager</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">View Module Class List</h3>
                    </div>
                    <div class="panel-body">
                        <p>View and print the class list for a module</p>
                        <a class="btn btn-primary" href="AdminModuleClassList.aspx">View Class List</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">View Course Class List</h3>
                    </div>
                    <div class="panel-body">
                        <p>View and print the class list for a course</p>
                        <a class="btn btn-primary" href="AdminCourseClassList.aspx">View Class List</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Set Module Breakdown</h3>
                    </div>
                    <div class="panel-body">
                        <p>Set the module component breakdown</p>
                        <a class="btn btn-primary" href="AdminSetModuleBreakdown.aspx">Set Breakdown</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Set Module Mark Deadline Date</h3>
                    </div>
                    <div class="panel-body">
                        <p>Set and update the mark deadline for modules</p>
                        <a class="btn btn-primary" href="AdminMarkDeadlineDate.aspx">Set Deadline</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Events</h3>
                    </div>
                    <div class="panel-body">
                        <p>Add events such as lectures to a module</p>
                        <a class="btn btn-primary" href="AdminAddEvent.aspx">Add Events</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Edit / Delete Event Details</h3>
                    </div>
                    <div class="panel-body">
                        <p>Change / delete the details of lectures etc.</p>
                        <a class="btn btn-primary" href="AdminEditEvents.aspx">Edit / Delete Events</a>
                    </div>
                </div>

            </div>


        </div>

        <%--end of container--%>
    </div>

</asp:Content>
