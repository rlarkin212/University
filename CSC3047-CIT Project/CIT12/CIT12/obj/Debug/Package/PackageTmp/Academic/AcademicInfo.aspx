<%@ Page Title="Academic Info" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicInfo.aspx.cs" Inherits="CIT12.Academic.AcademicInfo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Academic Info</li>
    </ul>

    <div class="heading">
        <h3>Academic Info</h3>
    </div>

    <br />

    <div class="container">
        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Module List</h3>
                    </div>
                    <div class="panel-body">
                        <p>View a list of modules you have been assigned to</p>
                        <a class="btn btn-primary" href="AcademicModuleList.aspx">View Modules</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Course Module Structure</h3>
                    </div>
                    <div class="panel-body">
                        <p>View The Module Structure For A Course </p>
                        <a class="btn btn-primary" href="AcademicCourseModuleStructure.aspx">View Module Structure</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Module Specification</h3>
                    </div>
                    <div class="panel-body">
                        <p>Search For A Module Specification </p>
                        <a class="btn btn-primary" href="AcademicModuleSpec.aspx">View Specification</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Module Description</h3>
                    </div>
                    <div class="panel-body">
                        <p>Edit A Module Description </p>
                        <a class="btn btn-primary" href="AcademicChangeModuleDescription.aspx">Edit Description</a>
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
