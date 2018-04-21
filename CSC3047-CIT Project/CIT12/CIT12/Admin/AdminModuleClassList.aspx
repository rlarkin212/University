<%@ Page Title="Moudle Class List" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminModuleClassList.aspx.cs" Inherits="CIT12.Admin.AdminModuleClassList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlClassList.ClientID %>')
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
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Module Class List</li>
    </ul>

    <%--class list panel--%>
    <asp:Panel ID="pnlModuleList" runat="server">

        <div class="row">
            <h3>Module Class List</h3>
        </div>
        <hr />

        <div id="searchBox" runat="server" class="form-group">
            <div class="row">
                <small>Search For A Module Via A Valid Module Code</small>
                <asp:TextBox ID="txtModuleCode" runat="server" CssClass="form-control" Placeholder="eg. CSC-3057"></asp:TextBox>
                <br />
                <asp:Button ID="btnSearchModule" runat="server" Text="Search" CssClass="btn btn-lg btn-success" />
            </div>
        </div>
        <hr />

        <asp:GridView ID="gvModuleList" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsModuleList" CssClass="table table-responsive table-striped table-condensed table-hover" GridLines="None" CellSpacing="-1" EmptyDataText="No Modules Exist Wth This Module Code" OnRowCommand="gvModuleList_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints"></asp:BoundField>
                <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Course Name" SortExpression="Name"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnGetClassList" runat="server" Text="Class List" CssClass="btn btn-block btn-info" CommandName="cmdGetClassList" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="dsModuleList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.CatPoints, tbl_semester.Semester, tbl_course.Name FROM tbl_modules INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id ORDER BY tbl_modules.Level ASC" FilterExpression="Code LIKE '{0}%'">

            <FilterParameters>
                <asp:ControlParameter Name="Code" ControlID="txtModuleCode" PropertyName="Text" />
            </FilterParameters>

        </asp:SqlDataSource>
    </asp:Panel>

    <%--class list panel--%>
    <asp:Panel ID="pnlClassList" runat="server" Visible="false">

        <div class="row">
            <h3>Class List</h3>
            <asp:Label ID="lblModuleTitle" runat="server" Text="Label"></asp:Label>
        </div>
        <br />

        <asp:GridView ID="gvModuleClassList" runat="server" DataSourceID="dsAcademicModuleClassList" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Have Been Enrolled In This Module" GridLines="None" CellSpacing="-1" OnDataBound="gvModuleClassList_DataBound">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AdminStudentResults.aspx?Id={0}" DataTextField="Number" HeaderText="Student Number" SortExpression="Number" />
                <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                <asp:BoundField DataField="FullName" HeaderText="Student Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="cbEmail" runat="server" CssClass="checkbox" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <hr />

        <div class="row">

            <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Class List" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />

            <asp:Button ID="btnSendEmail" runat="server" Text="Send Email" ToolTip="Send Email" CssClass="btn btn-info btn-lg" OnClick="btnSendEmail_Click" />
        </div>





        <asp:SqlDataSource runat="server" ID="dsAcademicModuleClassList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)  AS FullName, tbl_user.EmailAddress, tbl_years.Year, tbl_years.Id AS YearId FROM tbl_user INNER JOIN tbl_studentModule ON tbl_user.Id = tbl_studentModule.StudentId INNER JOIN tbl_years ON tbl_studentModule.YearId = tbl_years.Id WHERE (tbl_studentModule.ModuleId = @moduleId) ORDER BY FullName">
            <SelectParameters>
                <asp:SessionParameter Name="moduleId" SessionField="s_mouduleId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


    </asp:Panel>


















</asp:Content>
