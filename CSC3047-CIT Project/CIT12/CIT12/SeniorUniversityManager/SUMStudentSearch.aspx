<%@ Page Title="Student Search" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMStudentSearch.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMStudentSearch" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--js to print class list--%>
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlStudentDetails.ClientID %>')
            document.getElementById('<%= btnPrintGv.ClientID %>').hidden = true
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
        <li><a href="SUMHome.aspx">Home</a></li>
        <li class="active">StudentSearch</li>
    </ul>

    <%--------------------------student panel---------------------------------%>
    <asp:Panel ID="pnlStudent" runat="server">

        <div class="form-group">
            <div class="row">
                <h3>Student Search</h3>
            </div>
        </div>

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
                                <asp:Button ID="btnAddTutor" runat="server" Text="View Student Details" CssClass="btn btn-info btn-block" CommandName="cmdViewDetails" />
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

    <%---------------------------student details panel-----------------------------%>
    <asp:Panel ID="pnlStudentDetails" runat="server" Visible="false">

        <div class="heading">
            <h3>Student Details</h3>
        </div>
        <br />

        <%--contact details--%>
        <h4>Student Contact Details</h4>
        <asp:GridView ID="gvStudentContactDetails" runat="server" DataSourceID="dsStudentContactDetails" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Student Details Found For This Student" GridLines="None" CellSpacing="-1">
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="Student Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                <asp:BoundField DataField="TermAddress" HeaderText="Term Time Address" ReadOnly="True" SortExpression="TermAddress"></asp:BoundField>
                <asp:BoundField DataField="HomeAddress" HeaderText="Home Address" ReadOnly="True" SortExpression="HomeAddress"></asp:BoundField>
                <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber"></asp:BoundField>
            </Columns>
        </asp:GridView>

        <hr />

        <%--academic record--%>
        <h4>Student Academic Record</h4>
        <asp:GridView ID="gvStudentAcademicRecord" runat="server" DataSourceID="dsStudentAcademicRecord" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Academic Record Found For This Student" GridLines="None" CellSpacing="-1" OnRowDataBound="gvStudentAcademicRecord_RowDataBound">
            <Columns>
                <asp:BoundField DataField="ModuleId" HeaderText="ModuleId" ReadOnly="True" InsertVisible="False" SortExpression="ModuleId"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="ComponentType" HeaderText="ComponentType" SortExpression="ComponentType"></asp:BoundField>
                <asp:BoundField DataField="Mark" HeaderText="Mark" SortExpression="Mark"></asp:BoundField>
                <asp:BoundField DataField="Classification" HeaderText="Classification" SortExpression="Classification"></asp:BoundField>

            </Columns>
        </asp:GridView>

        <hr />

        <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Student Details" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />


        <asp:SqlDataSource runat="server" ID="dsStudentContactDetails" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)AS FullName, tbl_user.EmailAddress, CONCAT(tbl_studentUser.TermHouseNo, ' , ', tbl_studentUser.TermStreet, ' , ', tbl_studentUser.TermTown_City, ' , ', tbl_studentUser.TermCountry) AS TermAddress,  CONCAT(tbl_studentUser.HomeHouseNo, ' , ', tbl_studentUser.HomeStreet, ' , ', tbl_studentUser.HomeTown_City, ' , ', tbl_studentUser.HomeCountry)  AS HomeAddress, tbl_studentUser.PhoneNumber FROM tbl_user INNER JOIN tbl_studentUser ON tbl_user.Id = tbl_studentUser.StudentId WHERE (tbl_user.Id = @studentId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_studentId" Name="studentId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="dsStudentAcademicRecord" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Title, tbl_moduleComponentTypes.ComponentType, tbl_academicRecord.Mark, tbl_academicRecord.Classification, tbl_modules.Id AS ModuleId FROM tbl_academicRecord INNER JOIN tbl_moduleComponents ON tbl_academicRecord.ModuleComponentId = tbl_moduleComponents.Id INNER JOIN tbl_moduleComponentTypes ON tbl_moduleComponents.ComponentTypeCode = tbl_moduleComponentTypes.ComponentTypeCode INNER JOIN tbl_modules ON tbl_moduleComponents.ModuleId = tbl_modules.Id WHERE (tbl_academicRecord.StudentId = @studentId) ORDER BY ModuleId">
            <SelectParameters>
                <asp:SessionParameter Name="studentId" SessionField="s_studentId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>



</asp:Content>
