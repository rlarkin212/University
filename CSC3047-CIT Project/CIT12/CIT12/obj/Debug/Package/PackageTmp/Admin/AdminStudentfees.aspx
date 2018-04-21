<%@ Page Title="Student Fees" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentfees.aspx.cs" Inherits="CIT12.Admin.AdminStudentfees" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageStudent.aspx">Manage Student Info</a></li>
        <li class="active">Student Fees</li>
    </ul>



    <div class="heading">
        <h3>View Student Payment</h3>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <small>Filter List Via Student Number</small>
                <br />
                <br />
                <label class="control-label" for="txtStudentNumber">Student Number</label>
                <asp:TextBox ID="txtStudentNumber" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

        </div>

        <br />

        <div class="row">
            <div class="col-md-4">
                <asp:Button ID="btnFilterStudents" runat="server" Text="Search" CssClass="btn btn-primary btn-block" />
            </div>
        </div>

    </div>
    <br />
    <asp:GridView ID="gvAdminStudentFees" runat="server" DataSourceID="dsAdminStudentFees" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="There are no student's available to view" GridLines="None" CellSpacing="-1" OnDataBound="gvAdminStudentFees_DataBound">
        <Columns>
            <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" ReadOnly="True"></asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"></asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price"></asp:BoundField>
            <asp:BoundField DataField="FeesPaid" HeaderText="FeesPaid" SortExpression="FeesPaid"></asp:BoundField>

        </Columns>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="dsAdminStudentFees" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_feesType.Type, tbl_feesType.Price, tbl_studentUser.FeesPaid FROM tbl_user INNER JOIN tbl_studentUser ON tbl_user.Id = tbl_studentUser.Id INNER JOIN tbl_feesType ON tbl_user.Id = tbl_feesType.Id
WHERE tbl_user.Role = @role"
        FilterExpression="Number LIKE '{0}%'">
        <FilterParameters>
            <asp:ControlParameter Name="Number" ControlID="txtStudentNumber" PropertyName="Text" />
        </FilterParameters>

        <SelectParameters>
            <asp:Parameter DefaultValue="10" Name="role"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
