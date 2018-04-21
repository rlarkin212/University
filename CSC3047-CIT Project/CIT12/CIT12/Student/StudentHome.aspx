<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="Student.Master" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="CIT12.Student.StudentHome" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>Student Dashboard</h3>
        <asp:Label ID="lblStudent_Number" runat="server" Text="" CssClass="h4"></asp:Label>
    </div>
    <br />
    <div class="container">
        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Class Timetable</h3>
                    </div>
                    <div class="panel-body">
                        <p>View a time table of lectures, tutorials and practicals</p>
                        <a class="btn btn-primary" href="StudentTimetable.aspx">View Timetable</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Academic Information</h3>
                    </div>
                    <div class="panel-body">
                        <p>View course list, module spec, academic record etc.</p>
                        <a class="btn btn-primary" href="StudentAcademic.aspx">View Academic Info</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Team Management</h3>
                    </div>
                    <div class="panel-body">
                        <p>Create projects teams, create events, emails etc.</p>
                        <a class="btn btn-primary" href="StudentTeams.aspx">Manage Teams</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Room Booking</h3>
                    </div>
                    <div class="panel-body">
                        <p>Book a room for meetings, studying etc.</p>
                        <a class="btn btn-primary" href="StudentRoomBooking.aspx">Book A Room</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Your Room Bookings</h3>
                    </div>
                    <div class="panel-body">
                        <p>View your room bookings</p>
                        <a class="btn btn-primary" href="StudentYourRoomBookings.aspx">View Bookings</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4" id="pnlEnrolement" runat="server">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Registration / Enrollement</h3>
                    </div>
                    <div class="panel-body">
                        <p>Enroll in modules for the forthcoming academic year</p>
                        <a class="btn btn-primary" href="StudentEnrolment.aspx">Register / Enroll</a>
                    </div>



                </div>
            </div>
        </div>
        <%--second row--%>
        <div class="row">

        </div>


        <%--end of container--%>
    </div>
</asp:Content>
