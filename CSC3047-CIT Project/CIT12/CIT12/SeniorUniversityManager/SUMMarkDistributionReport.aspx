<%@ Page Title="Mark Distribution Stats" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMMarkDistributionReport.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMMarkDistributionReportaspx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js" type="text/javascript"></script>

    <ul class="breadcrumb">
        <li><a href="SUMHome.aspx">Home</a></li>
        <li><a href="SUMReports.aspx">Reports</a></li>
        <li class="active">Stuent Mark Distribution Stats</li>
    </ul>


    <asp:Label ID="lblFail" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lbl3rd" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lbl2_2" runat="server" Text="" CssClass="hidden"></asp:Label>
    <asp:Label ID="lbl2_1" runat="server" Text="" CssClass="hidden"></asp:Label>
     <asp:Label ID="lbl1st" runat="server" Text="" CssClass="hidden"></asp:Label>

     <asp:Label ID="lblChartType" runat="server" Text="" CssClass="hidden"></asp:Label>


    <div class="row">
        <div class="row">
            <h3>Student Mark Distribution Stats</h3>
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

    <asp:Panel ID="pnlMarkStats" runat="server">

        <div class="row" style="height: 50%; width: 50%">
            <canvas id="myChart" width="300" height="300"></canvas>
            <script>

                var fail = document.getElementById('<%= lblFail.ClientID %>').textContent;
                var third = document.getElementById('<%= lbl3rd.ClientID %>').textContent;
                var two_two = document.getElementById('<%= lbl2_2.ClientID %>').textContent;
                var two_one = document.getElementById('<%= lbl2_1.ClientID %>').textContent;
                var first = document.getElementById('<%= lbl1st.ClientID %>').textContent;

                 var chartType = document.getElementById('<%= lblChartType.ClientID %>').textContent;


                var ctx = document.getElementById("myChart").getContext('2d');
                var myChart = new Chart(ctx, {
                    type: chartType,
                    data: {
                        labels: ["Fail", "3rd", "2:2", "2:1", "1st"],
                        datasets: [{
                            label: 'Number of Classification Awarded',
                            data: [fail, third, two_two, two_one, first],
                            backgroundColor: [
                                'rgba(217, 35, 15, 0.8)',
                                'rgba(217, 131, 31, 0.8)',
                                'rgba(2, 165, 222, 0.8)',
                                'rgba(165, 76, 170, 0.8)',
                                'rgba(70, 148, 8, 0.8)'
                            ],
                            borderColor: [
                                'rgba(0, 0, 0, 1)',
                                'rgba(0, 0, 0, 1)',
                                'rgba(0, 0, 0, 1)',
                                'rgba(0, 0, 0, 1)',
                                'rgba(0, 0, 0, 1)'
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
