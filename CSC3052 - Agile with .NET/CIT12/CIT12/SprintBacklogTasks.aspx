<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SprintBacklogTasks.aspx.cs" Inherits="CIT12.SprintBacklogTasks" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="UserProjects.aspx">User Projects</a></li>
        <li><a href="Sprints.aspx">Sprints</a></li>
        <li><a href="SprintBacklog.aspx">Sprint Backlog</a></li>
        <li class="active">Sprint Backlog Tasks</li>
    </ul>

    <asp:Panel ID="pnlTasks" runat="server">

        <div class="heading">
            <h3>Sprint Backlog Tasks</h3>
        </div>

        <div class="container">

            <div class="form-group">
                <label class="control-label" for="txtTaskname">Task Name</label>
                <asp:TextBox ID="txtTaskName" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="control-label" for="txtInitialHours">Initial Hours</label>
                <asp:TextBox ID="txtInitialHours" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label ID="lblError" runat="server" Text="Task and Initial Hours Are Required Fields" CssClass="text-danger" Visible="false"></asp:Label>
                <br />
                <asp:Button ID="btnAddTask" runat="server" Text="Add Task" CssClass="btn btn-lg btn-success" OnClick="btnAddTask_Click" />

            </div>
        </div>

        <asp:GridView ID="gvSprintBacklogTasks" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsSprintBacklogTasks" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" PageSize="10" EmptyDataText="No Tasks Have Been Created For This User Story" OnRowCommand="gvSprintBacklogTasks_RowCommand" OnRowDataBound="gvSprintBacklogTasks_RowDataBound">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="SprintBacklogId" HeaderText="SprintBacklogId" SortExpression="SprintBacklogId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="TaskName" HeaderText="TaskName" SortExpression="TaskName"></asp:BoundField>
                <asp:BoundField DataField="InitialHours" HeaderText="InitialHours" SortExpression="InitialHours"></asp:BoundField>
                <asp:BoundField DataField="HoursLeft" HeaderText="HoursLeft" SortExpression="HoursLeft"></asp:BoundField>
                <asp:BoundField DataField="Complete" HeaderText="Complete" SortExpression="Complete"></asp:BoundField>

                <asp:TemplateField>
                    <HeaderTemplate>Update Hours</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnEditHours" runat="server" Text="Update Hours" CssClass="btn btn-block btn-primary" CommandName="UpdateTasks" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>


        <asp:SqlDataSource runat="server" ID="dsSprintBacklogTasks" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_SprintBacklogTasks] WHERE ([SprintBacklogId] = @SprintBacklogId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_sprintBacklogId" Name="SprintBacklogId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

    </asp:Panel>

    <asp:Panel ID="pnlUpdateHours" runat="server" Visible="false">

        <h3>Update Tasks</h3>


        <div class="container">

            <div class="form-group">
                <asp:Label ID="lblId" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblTask" runat="server" Text=""></asp:Label>
            </div>

            <div class="form-group">
                <asp:Label ID="lblInitialHours" runat="server" Text=""></asp:Label>
            </div>

            <div class="form-group">
                <label class="control-label" for="txtHoursLeft">Hours Left</label>
                <asp:TextBox ID="txtHoursLeft" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Button ID="btnUpdateHours" runat="server" Text="Update Hours" CssClass="btn btn-lg btn-success" OnClick="btnUpdateHours_Click" />
            </div>


        </div>

    </asp:Panel>



</asp:Content>
