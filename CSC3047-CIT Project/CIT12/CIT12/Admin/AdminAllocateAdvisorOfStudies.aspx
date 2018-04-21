<%@ Page Title="Allocate Student Advisor Of Studies" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAllocateAdvisorOfStudies.aspx.cs" Inherits="CIT12.Admin.AdminAllocateAdvisorOfStudies" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageStudent.aspx">Manage Student Info</a></li>
        <li class="active">Allocate Student Advisor Of Studies</li>
    </ul>

    <div class="heading">
        <h3>Allocate Student Advisor Of Studies</h3>
    </div>
    <br />

    <div class="form-group">
        <div class="row">
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
        </div>
    </div>

    <%--student panel--%>
    <asp:Panel ID="pnlStudent" runat="server">

        <div class="form-group">
            <div class="row">
                <div>
                    <label>Student Number</label>
                    <asp:TextBox ID="txtStudentNumber" runat="server" Placeholder="EG.40107426" CssClass="form-control"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-block" />
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <asp:GridView ID="gvStudents" runat="server" DataSourceID="dsStudents" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Are Found For This Module" GridLines="None" CellSpacing="-1" OnRowCommand="gvStudents_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Number" HeaderText="Student Number" SortExpression="Number"></asp:BoundField>
                        <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" ReadOnly="True"></asp:BoundField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnAddTutor" runat="server" Text="Assign Personal Tutor" CssClass="btn btn-primary btn-block" CommandName="cmdAssignTutor" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>


        <asp:SqlDataSource runat="server" ID="dsStudents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName FROM tbl_user WHERE (tbl_user.Role = @role)" FilterExpression="Number LIKE '{0}%'">
            <SelectParameters>
                <asp:Parameter DefaultValue="10" Name="role"></asp:Parameter>
            </SelectParameters>
            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtStudentNumber" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>

    </asp:Panel>

    <%--academic panel--%>
    <asp:Panel ID="pnlAcademics" runat="server" Visible="false">

        <div class="form-group">
            <div class="row">
                <div>
                    <label>Staff Number</label>
                    <asp:TextBox ID="txtStaffNumber" runat="server" Placeholder="EG.40107426" CssClass="form-control"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnSearchStaff" runat="server" Text="Search" CssClass="btn btn-primary btn-block" />
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <asp:GridView ID="gvAcademic" runat="server" DataSourceID="dsAcademic" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Acadmics Are Found Fot This Number" GridLines="None" CellSpacing="-1" OnRowCommand="gvAcademic_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Number" HeaderText="Number" SortExpression="Number"></asp:BoundField>
                        <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" ReadOnly="True"></asp:BoundField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnAssignToStudent" runat="server" Text="Assign To Student" CssClass="btn btn-success btn-block" CommandName="cmdAssignToStudent" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <asp:SqlDataSource runat="server" ID="dsAcademic" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName FROM tbl_user WHERE (tbl_user.Role = @role OR tbl_user.Role = @role2)" FilterExpression="Number LIKE '{0}%'">
            <SelectParameters>
                <asp:Parameter DefaultValue="20" Name="role"></asp:Parameter>
                <asp:Parameter DefaultValue="40" Name="role2"></asp:Parameter>
            </SelectParameters>
            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtStaffNumber" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>


    </asp:Panel>


</asp:Content>
