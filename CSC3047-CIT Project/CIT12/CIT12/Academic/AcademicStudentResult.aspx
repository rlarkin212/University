<%@ Page Title="Search Result" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicStudentResult.aspx.cs" Inherits="CIT12.Academic.AcademicStudentResult" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlDetails.ClientID %>');
            prtContent.border = 0; //set no border here
            var WinPrint = window.open('', '', 'left=100,top=100,width=1000,height=1000,toolbar=0,scrollbars=1,status=0,resizable=1');
            WinPrint.document.write(prtContent.outerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Student Result</li>
    </ul>

    <br />

    <asp:Panel ID="pnlDetails" runat="server">

        <div class="row">
            <h3></h3>
            <br />
            <asp:GridView ID="gvStudentResult" runat="server" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" GridLines="None" CellSpacing="-1" DataSourceID="dsStudentResult" DataKeyNames="Id" OnDataBound="gvStudentResult_DataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Number" HeaderText="Student Number" SortExpression="Number"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Student Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber"></asp:BoundField>
                    <asp:BoundField DataField="TermAddress" HeaderText="Term Time Address" ReadOnly="True" SortExpression="TermAddress"></asp:BoundField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="dsStudentResult" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number,CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)AS FullName,tbl_user.EmailAddress,tbl_studentUser.PhoneNumber,CONCAT(tbl_studentUser.TermHouseNo, ' , ', tbl_studentUser.TermStreet, ' , ', tbl_studentUser.TermTown_City, ' , ', tbl_studentUser.TermCountry) AS TermAddress FROM tbl_user INNER JOIN tbl_studentUser ON tbl_user.Id = tbl_studentUser.StudentId WHERE (tbl_user.Id = @Id) ORDER BY FullName ASC">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="Id" Name="Id" Type="Int32"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <hr />

        <div class="row">
            <h3></h3>
            <br />
            <asp:GridView ID="gvAcademicRecord" runat="server" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This User" GridLines="None" CellSpacing="-1" DataSourceID="dsAcademicRecord" OnDataBound="gvAcademicRecord_DataBound">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                <asp:BoundField DataField="StudentId" HeaderText="StudentId" SortExpression="StudentId"></asp:BoundField>
                <asp:BoundField DataField="Expr1" HeaderText="Expr1" ReadOnly="True" InsertVisible="False" SortExpression="Expr1"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Module Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="ComponentType" HeaderText="Module Component Type" SortExpression="ComponentType"></asp:BoundField>
                <asp:BoundField DataField="Mark" HeaderText="Mark" SortExpression="Mark"></asp:BoundField>
                <asp:BoundField DataField="Classification" HeaderText="Classification" SortExpression="Classification"></asp:BoundField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="dsAcademicRecord" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_academicRecord.Id, tbl_academicRecord.StudentId, tbl_modules.Title, tbl_moduleComponentTypes.ComponentType, tbl_academicRecord.Mark, tbl_academicRecord.Classification, tbl_modules.Id AS Expr1 FROM tbl_academicRecord INNER JOIN tbl_moduleComponents ON tbl_academicRecord.ModuleComponentId = tbl_moduleComponents.Id INNER JOIN tbl_moduleComponentTypes ON tbl_moduleComponents.ComponentTypeCode = tbl_moduleComponentTypes.ComponentTypeCode INNER JOIN tbl_modules ON tbl_moduleComponents.ModuleId = tbl_modules.Id WHERE (tbl_academicRecord.StudentId = @Id) ORDER BY Expr1">
            <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="Id" Name="Id" Type="Int32"></asp:QueryStringParameter>
                </SelectParameters>
        </asp:SqlDataSource>
        </div>












    </asp:Panel>
     <hr />
            <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Student Inormation" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />

</asp:Content>


