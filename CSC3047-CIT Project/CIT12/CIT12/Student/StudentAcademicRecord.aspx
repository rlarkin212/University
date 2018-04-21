<%@ Page Title="Academic Record" Language="C#" MasterPageFile="Student.Master" AutoEventWireup="true" CodeBehind="StudentAcademicRecord.aspx.cs" Inherits="CIT12.Student.StudentAcademicRecord" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--js to print module list gridview--%>
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= printPnl.ClientID %>');
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
        <li><a href="StudentHome.aspx">Home</a></li>
        <li><a href="StudentAcademic.aspx">Academic</a></li>
        <li class="active">Academic Record</li>
    </ul>

    <asp:Panel ID="printPnl" runat="server">

        <div class="heading">
            <h3>Academic Record</h3>
        </div>

        <asp:GridView ID="gvAcademicRecord" runat="server" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This User" GridLines="None" CellSpacing="-1" OnRowDataBound="gvAcademicRecord_RowDataBound" DataSourceID="dsAcademicRecord">
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

        <asp:SqlDataSource runat="server" ID="dsAcademicRecord" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_academicRecord.Id, tbl_academicRecord.StudentId, tbl_modules.Title, tbl_moduleComponentTypes.ComponentType, tbl_academicRecord.Mark, tbl_academicRecord.Classification, tbl_modules.Id AS Expr1 FROM tbl_academicRecord INNER JOIN tbl_moduleComponents ON tbl_academicRecord.ModuleComponentId = tbl_moduleComponents.Id INNER JOIN tbl_moduleComponentTypes ON tbl_moduleComponents.ComponentTypeCode = tbl_moduleComponentTypes.ComponentTypeCode INNER JOIN tbl_modules ON tbl_moduleComponents.ModuleId = tbl_modules.Id WHERE (tbl_academicRecord.StudentId = @loggedUserId) ORDER BY Expr1">
            <SelectParameters>
                <asp:SessionParameter Name="loggedUserId" SessionField="s_loggedUserId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


        <hr />

        <div class="heading">
            <h3>Personal Tutor</h3>
        </div>

        <asp:GridView ID="gvPersonalTutor" runat="server" DataSourceID="dsPersonalTutor" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Personal Tutor Details Are Found" GridLines="None">
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"></asp:BoundField>
                <asp:BoundField DataField="Office" HeaderText="Office" SortExpression="Office"></asp:BoundField>
                <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber"></asp:BoundField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="dsPersonalTutor" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_staffUser.Office, tbl_staffUser.PhoneNumber FROM tbl_academicPersonalTutees INNER JOIN tbl_user ON tbl_academicPersonalTutees.AcademicId = tbl_user.Id INNER JOIN tbl_staffUser ON tbl_user.Id = tbl_staffUser.StaffId WHERE (tbl_academicPersonalTutees.StudentId = @studentId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_loggedUserId" Name="studentId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <hr />

        <div class="heading">
            <h3>Advisor Of Studies</h3>
        </div>

        <asp:GridView ID="gvAdvisorOfStudies" runat="server" AutoGenerateColumns="False" DataSourceID="dsAdvisorOfStudies" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Personal Advisor Of Studies Details Are Found" GridLines="None">
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="FullName" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"></asp:BoundField>
                <asp:BoundField DataField="Office" HeaderText="Office" SortExpression="Office"></asp:BoundField>
                <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber"></asp:BoundField>
            </Columns>
        </asp:GridView>


        <asp:SqlDataSource runat="server" ID="dsAdvisorOfStudies" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_staffUser.Office, tbl_staffUser.PhoneNumber FROM tbl_user INNER JOIN tbl_advisorOfStudies ON tbl_user.Id = tbl_advisorOfStudies.AcademicId INNER JOIN tbl_staffUser ON tbl_user.Id = tbl_staffUser.StaffId WHERE (tbl_advisorOfStudies.StudentId = @studentId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_loggedUserId" Name="studentId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <hr />

    </asp:Panel>

    <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Academic Record, Personal Tutor And Advisor OF Studies Details" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />



</asp:Content>
