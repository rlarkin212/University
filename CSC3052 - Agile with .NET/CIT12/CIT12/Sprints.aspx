<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sprints.aspx.cs" Inherits="CIT12.Sprints" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="UserProjects.aspx">User Projects</a></li>
        <li class="active">Sprints</li>
    </ul>

    <div class="heading">
        <h3> Sprints </h3>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>


    <div class="container">

        <asp:Button ID="btnAddSprint" runat="server" Text="Add Sprint" CssClass="btn btn-primary" OnClick="btnAddSprint_Click" />
        <br />
        <br />

        <asp:GridView ID="gvSprints" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsSprints" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" PageSize="10" EmptyDataText="No Sprints Have Been Added To This Project" OnRowCommand="gvSprints_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Project_Id" HeaderText="Project_Id" SortExpression="Project_Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Sprint_Name" HeaderText="Sprint Name" SortExpression="Sprint_Name"></asp:BoundField>
                <asp:BoundField DataField="Start" HeaderText="Start Date" SortExpression="Start"></asp:BoundField>
                <asp:BoundField DataField="End" HeaderText="End Date" SortExpression="End"></asp:BoundField>

                <asp:TemplateField>
                    <HeaderTemplate>Sprint Backlog</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnViewSprintBacklog" runat="server" Text="View Sprint Backlog" CssClass="btn btn-block btn-primary" CommandName ="ViewSprintBacklog"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>Find Developers</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnSearchDevelopers" runat="server" Text="Find Available Developers" CssClass="btn btn-block btn-primary" CommandName ="AvailableDevelopers"/>
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>


        <asp:SqlDataSource runat="server" ID="dsSprints" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_Sprints] WHERE ([Project_Id] = @Project_Id)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_projectId" Name="Project_Id" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>



</asp:Content>
