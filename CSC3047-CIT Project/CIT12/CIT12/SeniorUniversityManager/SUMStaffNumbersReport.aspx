<%@ Page Title="Staff Number Stats" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMStaffNumbersReport.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMStaffNumbersReport" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">



    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js" type="text/javascript"></script>

    <ul class="breadcrumb">
        <li><a href="SUMHome.aspx">Home</a></li>
        <li><a href="SUMReports.aspx">Reports</a></li>
        <li class="active">Staff Number Stats</li>
    </ul>

    <asp:Label ID="lblTwenty" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblThirty" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblFourty" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblFifty" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblSixty" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lblChartType" runat="server" Text="" CssClass="hidden"></asp:Label>

    <div class="row">
        <h3>Staff Number Stats</h3>
        <small>See the amount of employees for each role</small>
    </div>

    <br />

    <div class="row">
        <div class="col-md-4">
            <asp:Button ID="btnBar" runat="server" Text="Bar Chart" CssClass="btn btn-primary" OnClick="btnBar_Click" />
        </div>
        <div class="col-md-4">
            <asp:Button ID="btnPie" runat="server" Text="Pie Chart" CssClass="btn btn-primary" OnClick="btnPie_Click" />
        </div>
        <div class="col-md-4">
            <asp:Button ID="btnLine" runat="server" Text="Line Chart" CssClass="btn btn-primary" OnClick="btnLine_Click" />
        </div>
    </div>

    <asp:Panel ID="pnlFeeStats" runat="server">

        <div class="row" style="height: 50%; width: 50%">
            <canvas id="myChart" width="300" height="300"></canvas>
            <script>

                var Twenty = document.getElementById('<%= lblTwenty.ClientID %>').textContent;
                var Thirty = document.getElementById('<%= lblThirty.ClientID %>').textContent;
                var Fourty = document.getElementById('<%= lblFourty.ClientID %>').textContent;
                var Fifty = document.getElementById('<%= lblFifty.ClientID %>').textContent;
                var Sixty = document.getElementById('<%= lblSixty.ClientID %>').textContent;
                var chartType = document.getElementById('<%= lblChartType.ClientID %>').textContent;


                var ctx = document.getElementById("myChart").getContext('2d');
                var myChart = new Chart(ctx, {
                    type: chartType,
                    data: {
                        labels: ["Academic", "Administrator", "Academic Program Manager", "Senior University Program Manager", "Super User"],
                        datasets: [{
                            label: 'Number of Staff Members',
                            data: [Twenty, Thirty, Fourty, Fifty, Sixty],
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
