<%@ Page Title="Senior University Manager Dashboard" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMHome.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMHome" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>Senior University Manager Dashboard</h3>
        <asp:Label ID="lblStaffNumber" runat="server" Text="" CssClass="h4"></asp:Label>
    </div>
    <br />
    <div class="container">
        <%-- first row--%>
        <div class="row">
            
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Student Search</h3>
                    </div>
                    <div class="panel-body">
                        <p>Search for a student via a valid student number</p>
                        <a class="btn btn-primary" href="SUMStudentSearch">Search</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Module Specification</h3>
                    </div>
                    <div class="panel-body">
                        <p>View and print a moudule specification</p>
                        <a class="btn btn-primary" href="SUMModuleSpec.aspx">View Specification</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Course Module Structure</h3>
                    </div>
                    <div class="panel-body">
                        <p>View and print a courses modules structure</p>
                        <a class="btn btn-primary" href="SUMModuleStructure.aspx">View Structure</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Reports</h3>
                    </div>
                    <div class="panel-body">
                        <p>View and crete high level reports</p>
                        <a class="btn btn-primary" href="SUMReports.aspx">View Reports</a>
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
