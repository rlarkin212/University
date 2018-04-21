<%@ Page Title="Change User Role" Language="C#" MasterPageFile="~/SuperUser/SuperUser.Master" AutoEventWireup="true" CodeBehind="SuperUserChangeRole.aspx.cs" Inherits="CIT12.SuperUser.SuperUserChangeRole" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="SuperUserHome.aspx">Home</a></li>
        <li class="active">Change User ROles</li>
    </ul>

    <div class="row">
        <h3>Change Users Roles</h3>
        <small>Temporarily chanage a users role so they can access other roles functionality </small>
        <hr />
    </div>

    <div class="row">
        <div class="col-md-4">
            <asp:Button ID="btnChangeRole" runat="server" Text="Change User Role" CssClass="btn btn-primary" OnClick="btnChangeRole_Click" />
        </div>
        <div class="col-md-4">
            <asp:Button ID="btnViewChangedUserRole" runat="server" Text="View Changed Roles" CssClass="btn btn-info" OnClick="btnViewChangedUserRole_Click" />
        </div>
    </div>
    <hr />

    <%--users panel--%>
    <asp:Panel ID="pnlUsers" runat="server">

        <div class="row">
            <asp:TextBox ID="txtNumberSearch" runat="server" CssClass="form-control"></asp:TextBox>
            <small>Filter Via Number</small>
            <br />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" />
        </div>

        <div class="clearfix"></div>
        <br />

        <div class="row">
            <asp:Label ID="lblMessage" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" DataSourceID="dsUsers" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Users Found With This Number" GridLines="None" CellSpacing="-1" OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="RoleCode" HeaderText="RoleCode" SortExpression="RoleCode" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Number" HeaderText="Staff / Student Number" SortExpression="Number"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnChangeRole" runat="server" Text="Change Role" CssClass="btn btn-primary btn-block" CommandName="cmdChangeRole" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:SqlDataSource runat="server" ID="dsUsers" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.Role AS RoleCode, tbl_role.Role FROM tbl_user INNER JOIN tbl_role ON tbl_user.Role = tbl_role.RoleCode" FilterExpression="Number LIKE '{0}%'">
            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtNumberSearch" Type="Int32" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>
    </asp:Panel>

    <%--chaneg role panel--%>
    <asp:Panel ID="pnlChangeRole" runat="server" Visible="false">

        <div class="row">
            <h4>Change Role</h4>
            <asp:Label ID="lblUserName" runat="server" Text="" CssClass="h5"></asp:Label>
        </div>

        <br />

        <div class="row">
            <label class="control-label" for="ddlRole">Role</label>
            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <br />

        <div class="row">
            <div class="col-md-4">
                <asp:Calendar ID="calDate" runat="server" OnSelectionChanged="calDate_SelectionChanged"></asp:Calendar>
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtDate">Deadline Date</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvDate" ControlToValidate="txtDate" ErrorMessage="Please Enter A Date" />
            </div>

        </div>

        <div class="row">
            <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            <br />
            <asp:Button ID="btnSubmitRoleChange" runat="server" Text="Change Role" CssClass="btn btn-lg btn-success" OnClick="btnSubmitRoleChange_Click" />
        </div>

    </asp:Panel>

    <%--Revert role change panel--%>
    <asp:Panel ID="pnlRevertRoleChange" runat="server" Visible="false">

        <div class="row">
            <h4>Revert Role Changes</h4>
        </div>

        <div class="row">
            <asp:Button ID="btnRefreshRole" runat="server" Text="Refresh Role Changes" CssClass="btn btn-danger" OnClick="btnRefreshRole_Click" />
            <br />
            <small>Revert role changes for any change over the deadline date</small>
        </div>
        <br />
        <br />

        <div class="row">
            <asp:Label ID="lblRevertSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvRevertRoleChange" runat="server" DataSourceID="dsRevertRoleChange" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Role Changes Are Found" GridLines="None" CellSpacing="-1" OnRowCommand="gvRevertRoleChange_RowCommand" OnRowDataBound="gvRevertRoleChange_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="user Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="PreviousRoleCode" HeaderText="PreviousRoleCode" SortExpression="PreviousRoleCode" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="NewRoleCode" HeaderText="CurrentRoleCode" SortExpression="NewRoleCode" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="PreviousRole" HeaderText="Previous Role" SortExpression="PreviousRole"></asp:BoundField>
                    <asp:BoundField DataField="NewRole" HeaderText="Current Role" SortExpression="NewRole"></asp:BoundField>
                    <asp:BoundField DataField="DeadlineDate" HeaderText="DeadlineDate" SortExpression="DeadlineDate" dataformatstring="{0:dd/MM/yyyy}"></asp:BoundField>
                     <asp:BoundField DataField="RoleChangeId" HeaderText="Role Change Id" SortExpression="RoleChangeId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnRevertChanges" runat="server" Text="Revert Role Change" CssClass="btn btn-block btn-danger" CommandName="cmdRevertChanges" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsRevertRoleChange" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_roleChangeTemp.PreviousRoleCode, tbl_roleChangeTemp.NewRoleCode, tbl_roleChangeTemp.PreviousRole, tbl_roleChangeTemp.NewRole, tbl_roleChangeTemp.DeadlineDate, tbl_roleChangeTemp.Id AS RoleChangeId FROM tbl_user INNER JOIN tbl_roleChangeTemp ON tbl_user.Id = tbl_roleChangeTemp.UserId"></asp:SqlDataSource>
        </div>




    </asp:Panel>








</asp:Content>
