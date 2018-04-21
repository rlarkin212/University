<%@ Page Title="Module List" Language="C#" MasterPageFile="Student.Master" AutoEventWireup="true" CodeBehind="StudentModuleList.aspx.cs" Inherits="CIT12.Student.StudentModuleList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--js to print module list gridview--%>
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= gvModuleList.ClientID %>');
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
        <li class="active">Module List</li>
    </ul>

    <%--module list panel --%>
    <asp:Panel ID="pnlModuleList" runat="server">

        <div class="heading">
            <h3>Module List</h3>
            <h4>
                <asp:Label ID="lblCourse" runat="server" Text=""></asp:Label></h4>
        </div>


        <asp:GridView ID="gvModuleList" runat="server" DataSourceID="dsStudentModuleList" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This User" GridLines="None" CellSpacing="-1" OnDataBound="gvModuleList_DataBound" OnRowCommand="gvModuleList_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="SemesterId" HeaderText="SemesterId" SortExpression="SemesterId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnModuleSpec" runat="server" Text="Specification" CssClass="btn btn-block btn-info" CommandName="viewModuleSpec" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>


        <hr />

        <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Module List" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />


        <asp:SqlDataSource runat="server" ID="dsStudentModuleList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_modules.Id, tbl_modules.CourseId, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.SemesterId, tbl_modules.CatPoints, tbl_semester.Semester, tbl_studentModule.StudentId FROM tbl_modules INNER JOIN tbl_studentModule ON tbl_modules.Id = tbl_studentModule.ModuleId INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id WHERE (tbl_studentModule.StudentId = @loggedUserId) ORDER BY tbl_modules.Level ASC">
            <SelectParameters>
                <asp:SessionParameter Name="loggedUserId" SessionField="s_loggedUserId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>



    </asp:Panel>

    <%--module spec panel--%>
    <asp:Panel ID="pnlModuleSpec" runat="server" Visible="false">
        <div class="heading">
            <h3>Module Specification</h3>
            <h4>
                <asp:Label ID="lblModuleSpecName" runat="server" Text=""></asp:Label></h4>
        </div>



        <asp:GridView ID="gvModuleSpec" runat="server" DataSourceID="dsModuleSpec" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Info Found For This Module" GridLines="None" CellSpacing="-1">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription"></asp:BoundField>
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints"></asp:BoundField>
                <asp:BoundField DataField="PreReqModules" HeaderText="PreReqModules" SortExpression="PreReqModules"></asp:BoundField>
                <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester"></asp:BoundField>
                <asp:BoundField DataField="StaffFullName" HeaderText="Staff" SortExpression="StaffFullName"></asp:BoundField>

            </Columns>
        </asp:GridView>


        <asp:SqlDataSource runat="server" ID="dsModuleSpec" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.CatPoints, tbl_modules.PreReqModules, tbl_semester.Semester,CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS StaffFullName, tbl_modules.ModuleDescription FROM tbl_modules INNER JOIN tbl_moduleStaff ON tbl_modules.Id = tbl_moduleStaff.ModuleId INNER JOIN tbl_user ON tbl_moduleStaff.Id = tbl_user.Id INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id WHERE (tbl_modules.Id = @moduleId)">
            <SelectParameters>
                <asp:SessionParameter Name="moduleId" SessionField="s_moduleId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>




</asp:Content>
