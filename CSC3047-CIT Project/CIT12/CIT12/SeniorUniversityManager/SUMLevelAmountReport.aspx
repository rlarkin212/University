<%@ Page Title="Level Count Stats" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMLevelAmountReport.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMLevelAmount" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js" type="text/javascript"></script>

    <ul class="breadcrumb">
        <li><a href="SUMHome.aspx">Home</a></li>
        <li><a href="SUMReports.aspx">Reports</a></li>
        <li class="active">Student Fee Stats</li>
    </ul>

    <asp:Label ID="lblLevel0" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblLevel1" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblLevel2" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblLevel3" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblLevel4" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblChartType" runat="server" Text="" CssClass="hidden"></asp:Label>

    <div class="row">
        <h3>Student Level Stats</h3>
        <small>See the amount of student in each level</small>    
    </div>

    <br />

    <div class="row">
        <div class="col-md-4">
            <asp:Button ID="btnBar" runat="server" Text="Bar Chart" CssClass="btn btn-primary" OnClick="btnBar_Click"/>
        </div>
         <div class="col-md-4">
            <asp:Button ID="btnPie" runat="server" Text="Pie Chart" CssClass="btn btn-primary" OnClick="btnPie_Click"/>
        </div>
        <div class="col-md-4">
            <asp:Button ID="btnLine" runat="server" Text="Line Chart" CssClass="btn btn-primary" OnClick="btnLine_Click"/>
        </div>
    </div>

 
    <asp:Panel ID="pnlFeeStats" runat="server">

        <div class="row" style="height: 50%; width: 50%">
            <canvas id="myChart" width="300" height="300"></canvas>
            <script>

                var level0 = document.getElementById('<%= lblLevel0.ClientID %>').textContent;
                var level1 = document.getElementById('<%= lblLevel1.ClientID %>').textContent;
                var level2 = document.getElementById('<%= lblLevel2.ClientID %>').textContent;
                var level3 = document.getElementById('<%= lblLevel3.ClientID %>').textContent;
                var level4 = document.getElementById('<%= lblLevel4.ClientID %>').textContent;
                var chartType = document.getElementById('<%= lblChartType.ClientID %>').textContent;


                var ctx = document.getElementById("myChart").getContext('2d');
                var myChart = new Chart(ctx, {
                    type: chartType,
                    data: {
                        labels: ["Not Enrolled", "Level 1", "Level2", "Level 3", "Level 4",],
                        datasets: [{
                            label: 'Number of Students',
                            data: [level0, level1, level2, level3, level4],
                            backgroundColor: [
                                'rgba(71, 73, 73, 0.8)',
                                'rgba(217, 35, 15, 0.8)',
                                'rgba(70, 148, 8, 0.8)',
                                'rgba(155, 71, 159, 0.8)',
                                'rgba(217, 131, 31, 0.8)'
                            ],
                            borderColor: [
                                'rgba(0, 0, 0, 1)',
                                'rgba(0, 0, 0, 1)',
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
