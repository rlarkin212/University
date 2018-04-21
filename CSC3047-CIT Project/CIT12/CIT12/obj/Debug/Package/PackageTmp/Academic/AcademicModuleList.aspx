<%@ Page Title="Module List" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicModuleList.aspx.cs" Inherits="CIT12.Academic.AcadmicModuleList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--js to print class list--%>
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= gvModuleClassList.ClientID %>');
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
        <li><a href="AcademicInfo.aspx">Academic Info</a></li>
        <li class="active">Module List</li>
    </ul>

    <%-- module list--%>
    <asp:Panel ID="pnlModuleList" runat="server">

        <div class="heading">
            <h3>Module List</h3>
        </div>


        <asp:GridView ID="gvAcademicModuleList" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Have Not Been Assigned To Any Modules" GridLines="None" CellSpacing="-1" DataSourceID="dsAcademicModuleList" OnRowCommand="gvAcademicModuleList_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Course" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester"></asp:BoundField>
                <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnClassList" runat="server" Text="ClassList" CssClass="btn btn-block btn-info" CommandName="viewModuleClassList" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>



        <asp:SqlDataSource runat="server" ID="dsAcademicModuleList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.CatPoints, tbl_course.Name, tbl_semester.Semester FROM tbl_modules INNER JOIN tbl_moduleStaff ON tbl_modules.Id = tbl_moduleStaff.ModuleId INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id WHERE (tbl_moduleStaff.StaffId = @loggedUserId) ORDER BY tbl_modules.Level">
            <SelectParameters>
                <asp:SessionParameter Name="loggedUserId" SessionField="s_loggedUserId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


    </asp:Panel>

    <%--  class list --%>

    <asp:Panel ID="pnlModuleClassList" runat="server" Visible="false">

        <div class="heading">
            <h3>Module List</h3>
            <asp:Label ID="lblModule" runat="server" Text="" CssClass="h4"></asp:Label>
        </div>
        <%--search box --%>
        <div class="container">
            <small>Filter List Via Student Number Or Year</small>
            <div class="row">

                <div class="col-md-4">
                    <label class="control-label" for="txtStudentNumber">Student Number</label>
                    <asp:TextBox ID="txtStudentNumber" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-4">

                    <label class="control-label" for="ddlYear">Year</label>
                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="dropdown form-control"></asp:DropDownList>

                </div>

            </div>

            <br />

            <div class="row">
                <div class="col-md-4">
                    <asp:Button ID="btnFilterStudents" runat="server" Text="Search" CssClass="btn btn-primary btn-block" OnClick="btnFilterStudents_Click" />
                </div>
            </div>

        </div>
        <br />

        <%-- gv class list--%>
        <asp:GridView ID="gvModuleClassList" runat="server" DataSourceID="dsAcademicModuleClassList" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Have Been Enrolled In This Module" GridLines="None" CellSpacing="-1" OnDataBound="gvModuleClassList_DataBound">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AcademicStudentResult.aspx?Id={0}" DataTextField="Number" HeaderText="Student Number" SortExpression="Number" />
                <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                <asp:BoundField DataField="FullName" HeaderText="Student Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                <asp:BoundField DataField="Year" HeaderText="Year" ReadOnly="True" SortExpression="Year"></asp:BoundField>
                <asp:BoundField DataField="YearId" HeaderText="YearId" ReadOnly="True" SortExpression="YearId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <%--email cb --%>
                <asp:TemplateField>
                    <HeaderTemplate>Include In Email</HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="cbEmail" runat="server" CssClass="checkbox" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>

        <hr />

        <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Class List" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />

        <asp:Button ID="btnEmailToArray" runat="server" Text="Send Email" ToolTip="Send an email to all students checked" CssClass="btn btn-info btn-lg" OnClick="btnEmailToArray_Click" />

        <asp:SqlDataSource runat="server" ID="dsAcademicModuleClassList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)  AS FullName, tbl_user.EmailAddress, tbl_years.Year, tbl_years.Id AS YearId FROM tbl_user INNER JOIN tbl_studentModule ON tbl_user.Id = tbl_studentModule.StudentId INNER JOIN tbl_years ON tbl_studentModule.YearId = tbl_years.Id WHERE (tbl_studentModule.ModuleId = @moduleId AND tbl_studentModule.YearId = @yearId) ORDER BY FullName" FilterExpression="Number LIKE '%{0}%'">
            <SelectParameters>
                <asp:SessionParameter Name="moduleId" SessionField="s_academicMoudleListId" Type="Int32" />
                <asp:SessionParameter Name="yearId" SessionField="s_classYearId" Type="Int32" />
            </SelectParameters>

            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtStudentNumber" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>
    </asp:Panel>




</asp:Content>
