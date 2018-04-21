<%@ Page Title="Advisor Of Studies Students" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicProgramManagerViewStudents.aspx.cs" Inherits="CIT12.Academic.AcademicProgramManagerViewStudents" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlAdvisorOfStudiesStudents.ClientID %>');
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
        <li class="active">Advisor Of Studies - Students</li>
    </ul>

    <asp:Panel ID="pnlAdvisorOfStudiesStudents" runat="server">
        <div class="row">
            <h3>Advisor Of Studies Students</h3>
            <small>A List Of Students You Are Academic Program Manager For </small>
        </div>


        <div class="row">
            <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataSourceID="dsStudents" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Strudents Have Been Assigned To You" GridLines="None" CellSpacing="-1">
                <Columns>
                    <asp:BoundField DataField="Number" HeaderText="Student Number" SortExpression="Number"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsStudents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)  AS FullName, tbl_user.EmailAddress FROM tbl_advisorOfStudies INNER JOIN tbl_user ON tbl_advisorOfStudies.StudentId = tbl_user.Id WHERE (tbl_advisorOfStudies.AcademicId = @loggedUserId)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_loggedUserId" Name="loggedUserId"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </asp:Panel>

    <div class="row">
         <hr />
        <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Class List" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />
    </div>


</asp:Content>
