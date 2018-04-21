<%@ Page Title="Set Student Status" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSetStudentStatus.aspx.cs" Inherits="CIT12.Admin.AdminSetStudentStatus" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageStudent.aspx">Manage Student Info</a></li>
        <li class="active">Set Student Status</li>
    </ul>


    <div class="heading">
        <h3>Set Student Status</h3>
    </div>

    <%--studnet search panel--%>
    <asp:Panel ID="pnlStudentSearch" runat="server">

        <div class="form-group">
            <div class="row">
                <div>
                    <label>Student Number : </label>
                    <asp:TextBox ID="txtStudentNumber" runat="server" Placeholder="EG.40107426" CssClass="form-control"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-block" />
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <asp:GridView ID="gvStudents" runat="server" DataSourceID="dsStudents" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This Course" GridLines="None" CellSpacing="-1" OnRowCommand="gvStudents_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Number" HeaderText="Number" SortExpression="Number"></asp:BoundField>
                        <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" ReadOnly="True"></asp:BoundField>
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnChangeStatus" runat="server" Text="Change Status" CssClass="btn btn-warning btn-block" CommandName="cmdChangeStatus" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>


        <asp:SqlDataSource runat="server" ID="dsStudents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)  AS FullName, tbl_status.Status FROM tbl_user INNER JOIN tbl_studentUser ON tbl_user.Id = tbl_studentUser.StudentId INNER JOIN tbl_status ON tbl_studentUser.StatusId = tbl_status.Id WHERE (tbl_user.Role = @role)" FilterExpression="Number LIKE '{0}%'">
            <SelectParameters>
                <asp:Parameter DefaultValue="10" Name="role"></asp:Parameter>
            </SelectParameters>
            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtStudentNumber" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>
    </asp:Panel>

    <%--set status panel--%>
    <asp:Panel ID="pnlStatus" runat="server" Visible="false">

        <div class="form-group">
            <asp:Label ID="lblStudent" runat="server" Text="" CssClass="h4"></asp:Label>
        </div>

        <div class="form-group">
            <label class="control-label" for="ddlStatus">Status</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <br />

        <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
        <br />
        <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CssClass="btn btn-success btn-lg" OnClick="btnUpdateStatus_Click" />

    </asp:Panel>


</asp:Content>
