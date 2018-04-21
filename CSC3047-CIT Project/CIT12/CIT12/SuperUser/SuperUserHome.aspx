<%@ Page Title="Super User Dashboard" Language="C#" MasterPageFile="~/SuperUser/SuperUser.Master" AutoEventWireup="true" CodeBehind="SuperUserHome.aspx.cs" Inherits="CIT12.SuperUser.SuperUserHome" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <h3>Super User Dashboard</h3>
    </div>

    <div class="container">
        <%--super user functionality row --%>
        <div class="row">

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Reset Password</h3>
                    </div>
                    <div class="panel-body">
                        <p>Reset the password for a user</p>
                        <a class="btn btn-primary" href="SuperUserResetPassword.aspx">Reset Password</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add / Remove Users</h3>
                    </div>
                    <div class="panel-body">
                        <p>Add / Remove a user from the system</p>
                        <a class="btn btn-primary" href="SuperUserRemoveUsers.aspx">Add / Remove Users</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Change Users Role</h3>
                    </div>
                    <div class="panel-body">
                        <p>Temporarily change the role of a user</p>
                        <a class="btn btn-primary" href="SuperUserChangeRole.aspx">Change Role</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Users Bulk Upload</h3>
                    </div>
                    <div class="panel-body">
                        <p>Bulk upload user details using a csv file</p>
                        <a class="btn btn-primary" href="SuperUserBulkUpload.aspx">Bulk Upload Users</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Set Academic Year Start Date</h3>
                    </div>
                    <div class="panel-body">
                        <p>Set The Date For The Start Of The Academic Year</p>
                        <a class="btn btn-primary" href="SuperUserSetStartOfYear.aspx">Set Start Date</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Buildings & Rooms</h3>
                    </div>
                    <div class="panel-body">
                        <p>Add buildings and rooms for student room bookings</p>
                        <a class="btn btn-primary" href="SuperUserAddBuildingRoom.aspx">Add Buildings / Rooms</a>
                    </div>
                </div>
            </div>


        </div>

        <%--other role functionality row --%>
        <div class="row">
            <div class="row">
                <small>Access The Tools For All Other Roles</small>
                <hr />
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Academic Tools </h3>
                    </div>
                    <div class="panel-body">
                        <p>Access academic tools</p>
                        <a class="btn btn-primary" href="../Academic/AcademicHome.aspx">Acacemic Tools</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Admin Tools </h3>
                    </div>
                    <div class="panel-body">
                        <p>Access admin tools</p>
                        <a class="btn btn-primary" href="../Admin/AdminHome.aspx">Admin Tools</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Senior University Manager Tools </h3>
                    </div>
                    <div class="panel-body">
                        <p>Access senior university manager tools</p>
                        <a class="btn btn-primary" href="../Academic/AcademicHome.aspx">Senior University Manager Tools</a>
                    </div>
                </div>
            </div>





        </div>



    </div>


</asp:Content>
