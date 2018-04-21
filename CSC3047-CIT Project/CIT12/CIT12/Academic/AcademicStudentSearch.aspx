<%@ Page Title="Student Search" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicStudentSearch.aspx.cs" Inherits="CIT12.Academic.StudentSearch" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Student Search</li>
    </ul>


    <div class="heading">
        <h3>Student Search
        </h3>
        <small>Search For A Student Via A Valid Student Number
        </small>
    </div>
    <br />

    <div class="form-group">
        <div class="row">
            <div>
                <label>Student Number : </label>
                <asp:TextBox ID="txtStudentNumber" runat="server" Placeholder="EG.1232378" CssClass="form-control"></asp:TextBox>
                <br />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-block" OnClick="btnSearch_Click" />
            </div>
        </div>
    </div>

    <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsStudentSearch" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Found Please Enter A Valid Student Number" GridLines="None" CellSpacing="-1" AllowPaging="true" PageSize="10">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AcademicStudentResult.aspx?Id={0}" DataTextField="Number" HeaderText="Student Number" SortExpression="Number" />
            <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename"></asp:BoundField>
            <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
        </Columns>
    </asp:GridView>


    <asp:SqlDataSource runat="server" ID="dsStudentSearch" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_user] WHERE (([Number] LIKE @Number) AND ([Role] = @Role)) ORDER BY Number ASC">
        <SelectParameters>
            <asp:SessionParameter SessionField="s_studentNumberSearch" Name="Number" Type="String"></asp:SessionParameter>
            <asp:Parameter DefaultValue="10" Name="Role" Type="Int32"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>



</asp:Content>
