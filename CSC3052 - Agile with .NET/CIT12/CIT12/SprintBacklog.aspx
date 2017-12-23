<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SprintBacklog.aspx.cs" Inherits="CIT12.SprintBacklog" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="UserProjects.aspx">User Projects</a></li>
        <li><a href="Sprints.aspx">Sprints</a></li>
        <li class="active">Sprint Backlog</li>
    </ul>


    <asp:Panel ID="pnlSprintBacklog" runat="server">

        <div class="heading">
            <h3>Sprint Backlog</h3>
            <asp:Label ID="lblProjectName" runat="server" Text=""></asp:Label>
        </div>

        <div class="container">

            <asp:GridView ID="gvSprintBacklog" runat="server" AutoGenerateColumns="False" DataSourceID="dsSprintBacklog" DataKeyNames="Id" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" PageSize="10" EmptyDataText="No User Stories Have Been Added To This Sprint" OnRowCommand="gvSprintBacklog_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="SprintId" HeaderText="SprintId" SortExpression="SprintId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="BacklogId" HeaderText="BacklogId" SortExpression="BacklogId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="UserStory" HeaderText="UserStory" SortExpression="UserStory"></asp:BoundField>
                    <asp:BoundField DataField="Value" HeaderText="Value" SortExpression="Value"></asp:BoundField>

                    <asp:TemplateField>
                        <HeaderTemplate>View Tasks</HeaderTemplate>
                        <ItemTemplate>
                            <asp:Button ID="btnAddTasks" runat="server" Text="View Tasks" CssClass="btn btn-block btn-primary" CommandName="AddTask"/></ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>




            <asp:SqlDataSource runat="server" ID="dsSprintBacklog" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_SprintBacklog.Id, tbl_SprintBacklog.SprintId, tbl_SprintBacklog.BacklogId, tbl_ProductBacklog.UserStory, tbl_ProductBacklog.Value FROM tbl_SprintBacklog 
                INNER JOIN tbl_ProductBacklog ON tbl_SprintBacklog.BacklogId = tbl_ProductBacklog.Id INNER JOIN tbl_Sprints ON tbl_SprintBacklog.SprintId = tbl_Sprints.Id
                WHERE([SprintId] = @sprintId)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_sprintId" Name="sprintId" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

    </asp:Panel>

    <asp:Panel ID="pnlAddSprintBacklog" runat="server">

        <div class="heading">
            <h3>Add User Stories To Sprint Backlog</h3>
        </div>

        <asp:GridView ID="gvProductBacklog" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsProjectBacklog" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" PageSize="10" EmptyDataText="No User Stories Have Been Added To This Product Backlog" OnRowCommand="gvProductBacklog_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="ProjectId" HeaderText="ProjectId" SortExpression="ProjectId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="UserStory" HeaderText="UserStory" SortExpression="UserStory"></asp:BoundField>
                <asp:BoundField DataField="Value" HeaderText="Value" SortExpression="Value"></asp:BoundField>

                <asp:TemplateField>
                    <HeaderTemplate>Add To Sprint Backlog</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnAddToBacklog" runat="server" Text="Add To Sprint Backlog" CssClass="btn btn-block btn-success" CommandName="Add" />
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>




        <asp:SqlDataSource runat="server" ID="dsProjectBacklog" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_ProductBacklog] WHERE ([ProjectId] = @ProjectId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_projectId" Name="ProjectId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>



</asp:Content>
