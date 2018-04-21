<%@ Page Title="Reports" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMReports.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMReports" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="SUMHome.aspx">Home</a></li>
        <li class="active">Reports</li>
    </ul>


    <div class="heading">
        <h3>Senior University Manager Reports</h3>
    </div>
    <br />
    <div class="container">
        <%-- first row--%>
        <div class="row">
            
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Student Fee Stats</h3>
                    </div>
                    <div class="panel-body">
                        <p>See the amount of fees paid, partially paid and unpaid</p>
                        <a class="btn btn-primary" href="SUMFeeStatsReport.aspx">View Fee Stats</a>
                    </div>
                </div>
            </div>

             <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Student Status Stats</h3>
                    </div>
                    <div class="panel-body">
                        <p>See the amount of students for each status</p>
                        <a class="btn btn-primary" href="SUMStudentStatusStatsReport.aspx">View Status Stats</a>
                    </div>
                </div>
            </div>

             <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Student Level Stats</h3>
                    </div>
                    <div class="panel-body">
                        <p>See the amount of students for each level</p>
                        <a class="btn btn-primary" href="SUMLevelAmountReport.aspx">View Level Stats</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Student Mark Distribution Stats</h3>
                    </div>
                    <div class="panel-body">
                        <p>See amount of each classification awarded</p>
                        <a class="btn btn-primary" href="SUMMarkDistributionReport.aspx">View Mark Stats</a>
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
