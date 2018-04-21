<%@ Page Title="Academic Dashboard" Language="C#" MasterPageFile="Academic.Master" AutoEventWireup="true" CodeBehind="AcademicHome.aspx.cs" Inherits="CIT12.Academic.AcademicHome" %>

<asp:Content ID="BodyCotent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>Academic Dashboard</h3>
        <asp:Label ID="lblAcademicNumber" runat="server" Text="" CssClass="h4"></asp:Label>
    </div>

    <br />

    <div class="container">
        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Timetable</h3>
                    </div>
                    <div class="panel-body">
                        <p>View a time table of lectures, tutorials etc.</p>
                        <a class="btn btn-primary" href="AcademicTimetable">View Timetable</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Academic Information</h3>
                    </div>
                    <div class="panel-body">
                        <p>View modules you are assigned to, class lists etc.</p>
                        <a class="btn btn-primary" href="AcademicInfo.aspx">View Academic Info</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Student Information</h3>
                    </div>
                    <div class="panel-body">
                        <p>View personal tutees, submit marks etc.</p>
                        <a class="btn btn-primary" href="AcademicStudentInfo.aspx">View Student Info</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Student Search</h3>
                    </div>
                    <div class="panel-body">
                        <p>Search for studnets via a valid studnet number</p>
                        <a class="btn btn-primary" href="AcademicStudentSearch.aspx">Search</a>
                    </div>
                </div>
            </div>

        </div>

        <%--second row--%>
        <div class="row">
        </div>

        <%--academic program manager--%>
        <asp:Panel ID="pnlAcademicProgramManager" runat="server" Visible="false">
            <div class="clearfix"></div>
            <h4>Academic Program Manager Tools</h4>
            <div class="row">

                <div class="col-sm-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Module Description Changes</h3>
                        </div>
                        <div class="panel-body">
                            <p>Approve module description changes</p>
                            <a href="AcademicProgramManagerApproveSpecification.aspx" class="btn btn-primary">Approve Changes</a>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Advisor Of Studies Student</h3>
                        </div>
                        <div class="panel-body">
                            <p>View students you are advisor of studies for</p>
                            <a href="AcademicProgramManagerViewStudents.aspx" class="btn btn-primary">View Students</a>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Respond To Help Requests</h3>
                        </div>
                        <div class="panel-body">
                            <p>Respond to enrolement help requests</p>
                            <a href="AcademicProgramManagerEnrolementHelp.aspx" class="btn btn-primary">Respond</a>
                        </div>
                    </div>
                </div>



            </div>
        </asp:Panel>

        <%--end of container--%>
    </div>

</asp:Content>
