<%@ Page Title="Academic Info" Language="C#" MasterPageFile="Student.Master" AutoEventWireup="true" CodeBehind="StudentAcademic.aspx.cs" Inherits="CIT12.Student.StudentAcademic" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <ul class="breadcrumb">
        <li><a href="StudentHome.aspx">Home</a></li>
        <li class="active">Academic</li>
    </ul>

    <div class="heading">
        <h3>Academic Section</h3>
    </div>

    <div class="container">
        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Module List</h3>
                    </div>
                    <div class="panel-body">
                        <p>View the modules within your course</p>
                        <a class="btn btn-primary" href="StudentModuleList.aspx">View Module List</a>
                    </div>
                </div>
            </div>


            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Academic Records</h3>
                    </div>
                    <div class="panel-body">
                        <p>View and print your academic records</p>
                        <a class="btn btn-primary" href="StudentAcademicRecord.aspx">View Academic Records</a>
                    </div>
                </div>
            </div>


        </div>

    </div>



</asp:Content>
