<%@ Page Title="Student Info" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicStudentInfo.aspx.cs" Inherits="CIT12.Academic.AcademicStudentInfo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Student Info</li>
    </ul>

    <div class="heading">
        <h3>Student Info</h3>
    </div>

    <br />
    <div class="container">
        <%-- first row--%>
        <div class="row">

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Personal Tutees</h3>
                    </div>
                    <div class="panel-body">
                        <p>View a list of personal tutees</p>
                        <a class="btn btn-primary" href="AcademicPersonalTutees.aspx">View Tutees</a>
                    </div>
                </div>
            </div>



            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Submit Student Marks</h3>
                    </div>
                    <div class="panel-body">
                        <p>Submit student marks for your modules</p>
                        <a class="btn btn-primary" href="AcademicAddStudentMarks.aspx">Submit Marks</a>
                    </div>
                </div>
            </div>

        </div>
        <%--end of container--%>
    </div>



</asp:Content>
