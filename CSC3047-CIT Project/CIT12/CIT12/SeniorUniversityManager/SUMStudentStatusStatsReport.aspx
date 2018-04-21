<%@ Page Title="Student Status Stats" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMStudentStatusStatsReport.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMStudentStatusStats" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js" type="text/javascript"></script>

    <ul class="breadcrumb">
        <li><a href="SUMHome.aspx">Home</a></li>
        <li><a href="SUMReports.aspx">Reports</a></li>
        <li class="active">Student Status Stats</li>
    </ul>

    <asp:Label ID="lblNormal" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblWithdrwn" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblTemporallyWithdrawn" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblSuspended" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblChartType" runat="server" Text="" CssClass="hidden"></asp:Label>

    <div class="row">
        <div class="row">
            <h3>Student Fee Stats</h3>
        </div>
    </div>

    <br />

    <div class="row">
        <div class="col-md-4">
            <asp:Button ID="btnBar" runat="server" Text="Bar Chart" CssClass="btn btn-primary" OnClick="btnBar_Click" />
        </div>
        <div class="col-md-4">
            <asp:Button ID="btnPie" runat="server" Text="Pie Chart" CssClass="btn btn-primary" OnClick="btnPie_Click" />
        </div>
    </div>

    <asp:Panel ID="pnlStats" runat="server">

        <div class="row" style="height: 50%; width: 50%">
            <canvas id="myChart" width="300" height="300"></canvas>
            <script>

                var normal = document.getElementById('<%= lblNormal.ClientID %>').textContent;
                var withdrawn = document.getElementById('<%= lblWithdrwn.ClientID %>').textContent;
                var tempWithdrawn = document.getElementById('<%= lblTemporallyWithdrawn.ClientID %>').textContent;
                var suspended = document.getElementById('<%= lblSuspended.ClientID %>').textContent;
                var chartType = document.getElementById('<%= lblChartType.ClientID %>').textContent;


                var ctx = document.getElementById("myChart").getContext('2d');
                var myChart = new Chart(ctx, {
                    type: chartType,
                    data: {
                        labels: ["Normal", "Withdrawn", "Temporarily Withdrawn", "Suspended"],
                        datasets: [{
                            label: 'Number of Students',
                            data: [normal, withdrawn, tempWithdrawn, suspended],
                            backgroundColor: [
                                'rgba(70, 148, 8, 0.8)',
                                'rgba(217, 131, 31, 0.8)',
                                'rgba(155, 71, 159, 1)',
                                'rgba(217, 35, 15, 0.8)',
                            ],
                            borderColor: [
                                'rgba(0, 0, 0, 1)',
                                'rgba(0, 0, 0, 1)',
                                'rgba(0, 0, 0, 1)',
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                });
            </script>
        </div>
    </asp:Panel>



</asp:Content>
