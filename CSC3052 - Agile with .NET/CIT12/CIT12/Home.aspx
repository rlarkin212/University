<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CIT12.Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="heading">
        <h3>Home</h3>
    </div>

    <div class="container">

        <br />

        <%-- first row--%>
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Create A Project</h3>
                    </div>
                    <div class="panel-body">
                        <p>Create A New Project And Assign Your Self As Project Manager</p>
                        <a class="btn btn-primary" href="CreateProject.aspx">Create A Project</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Project Manager View</h3>
                    </div>
                    <div class="panel-body">
                        <p>View Projects And Assign Roles</p>
                        <a class="btn btn-primary" href="Projects.aspx">View Projects</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">View Projects</h3>
                    </div>
                    <div class="panel-body">
                        <p>View Projects That You Have Been Assigned To</p>
                        <a class="btn btn-primary" href="UserProjects.aspx">View Projects</a>
                    </div>
                </div>
            </div>

        </div>

        <%--second row--%>
        <div class="row">

            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Planning Poker</h3>
                    </div>
                    <div class="panel-body">
                        <p>Get Statistics Based on Planning Poker Values</p>
                        <a class="btn btn-primary" href="PlanningPoker.aspx">View Planning Poker</a>
                    </div>
                </div>
            </div>



        </div>



    </div>



</asp:Content>
