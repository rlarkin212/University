<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlanningPoker.aspx.cs" Inherits="CIT12.PlanningPoker" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li class="active">Planning Poker</li>
    </ul>

    <div class="heading">
        <h3>Planning Poker</h3>
    </div>

    <label class="control-label" for="txtValues">Values</label>
    <asp:TextBox ID="txtValues" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
    <small>Pleas Enter a Series Of Values Speprated By Either A , Or A Space </small>
    <br />
    <asp:RequiredFieldValidator ID="rfvValues" runat="server" ControlToValidate="txtValues" ErrorMessage="Please Enter A Series Of Values" ForeColor="Red">
    </asp:RequiredFieldValidator>

    <br />
    <br />

    <div class="container">


        <div class="row">

            <div class="col ">
                <asp:Button ID="btnGetStats" runat="server" Text="Calculate Statistics" OnClick="btnGetStats_Click" CssClass="btn btn-primary" />
            </div>

        </div>

    </div>
    <br />



    <%--results--%>
    <div class="container">
        <%-- first row--%>
        <div class="row">

            <div class="col-sm-4">
                <label class="h4">Median Value : </label>
                <asp:Label ID="lblMedian" runat="server" Text=""></asp:Label>
            </div>

            <div class="col-sm-4">
                <label class="h4">Mean Value : </label>
                <asp:Label ID="lblMean" runat="server" Text=""></asp:Label>
            </div>

            <div class="col-sm-4">
                <label class="h4">Mode Value : </label>
                <asp:Label ID="lblMode" runat="server" Text=""></asp:Label>
            </div>

        </div>

        <br />

        <%--second row --%>
        <div class="row">

            <div class="col-sm-4">
                <label class="h4">Max Value : </label>
                <asp:Label ID="lblMax" runat="server" Text=""></asp:Label>
            </div>

            <div class="col-sm-4">
                <label class="h4">Min Value : </label>
                <asp:Label ID="lblMin" runat="server" Text=""></asp:Label>
            </div>

            <div class="col-sm-4">
                <label class="h4">Standard Deviation Value : </label>
                <asp:Label ID="lblStandardDeviation" runat="server" Text=""></asp:Label>
            </div>

        </div>

    </div>




</asp:Content>
