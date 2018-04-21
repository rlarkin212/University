<%@ Page Title="Add / Remove Users" Language="C#" MasterPageFile="~/SuperUser/SuperUser.Master" AutoEventWireup="true" CodeBehind="SuperUserRemoveUsers.aspx.cs" Inherits="CIT12.SuperUser.SuperUserRemoveUsers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="SuperUserHome.aspx">Home</a></li>
        <li class="active">Add / Remove Users</li>
    </ul>

    <asp:Panel ID="pnlRemoveUser" runat="server">

        <div class="row">
            <h3>Add / Remove User</h3>
            <small>Add Or Remove A User From The Syestem</small>
            <hr />
        </div>

        <div class="row">
            <small>Filter via student / staff number</small>
            <asp:TextBox ID="txtUserNumber" runat="server" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary btn-lg" Text="Search" />
            <asp:Button ID="btnAddUser" runat="server" CssClass="btn btn-info btn-lg pull-right" Text="Add User" OnClick="btnAddUser_Click" />

        </div>

        <br />

        <div class="row">
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" DataSourceID="dsUsers" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This User" GridLines="None" CellSpacing="-1" OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Number" HeaderText="Student / Staff Number" SortExpression="Number"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnRemoveUser" runat="server" CssClass="btn btn-block btn-danger" Text="Remove User" CommandName="cmdRemoveUser" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsUsers" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_role.Role FROM tbl_user INNER JOIN tbl_role ON tbl_user.Role = tbl_role.RoleCode" FilterExpression="Number LIKE '{0}%'">

                <FilterParameters>
                    <asp:ControlParameter Name="Number" ControlID="txtUserNumber" PropertyName="Text" />
                </FilterParameters>

            </asp:SqlDataSource>
        </div>
    </asp:Panel>

    <%--add user panel--%>
    <asp:Panel ID="pnlAddUser" runat="server" Visible="false">

        <div>
            <h4>Add User</h4>
        </div>


        <div class="container">
            <div class="row">

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNumber" class="control-label">Student / Staff Number</label>
                    <asp:TextBox ID="txtNumber" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvNumber" ControlToValidate="txtNumber" ErrorMessage="Please Enter A Student / Staff Number" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtEmail" class="control-label">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                     <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email Must Be In The Correct Format" ForeColor="Red" />
                </div>

                <div class="clearfix"></div>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtForename" class="control-label">Forename</label>
                    <asp:TextBox ID="txtForename" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPersonalForename" ControlToValidate="txtForename" ErrorMessage="Please Enter A Forename" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtSurname" class="control-label">Surname</label>
                    <asp:TextBox ID="txtSurname" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPersonalSurname" ControlToValidate="txtSurname" ErrorMessage="Please Enter A Surname" ForeColor="Red" />
                </div>

                <div class="clearfix"></div>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPassword" class="control-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="txtPassword" ErrorMessage="Please Enter A Password" ForeColor="Red" />
                </div>
                 <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="ddlRole" class="control-label">Role</label>
                     <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>

            </div>
        </div>

        <asp:Button ID="btnSubmitUser" runat="server" Text="Add User" CssClass="btn btn-lg btn-success" OnClick="btnSubmitUser_Click"/>



    </asp:Panel>





</asp:Content>
