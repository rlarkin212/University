<%@ Page Title="Course Module Structure" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMModuleStructure.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMModuleStructure" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlStructure.ClientID %>')
            document.getElementById('<%= btnPrintGv.ClientID %>').hidden = true
            document.getElementById('<%= searchBox.ClientID %>').hidden = true
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
        <li class="active">Course Module Structure</li>
    </ul>

    <asp:Panel ID="pnlStructure" runat="server">
        <div class="row">
            <h3>Course Module Stucture</h3>
        </div>
        <br />

        <div class="row" id="searchBox" runat="server">
            <div class="col-md-4">
                <label class="control-label" for="ddlCourseList">Select Course</label>
                <asp:DropDownList ID="ddlCourseList" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourseList_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="col-md4">
                <label class="control-label" for="ddlLevels">Level</label>
                <asp:DropDownList ID="ddlLevels" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>

            </div>
        </div>

        <br />

        <div class="row">
            <asp:GridView ID="gvCourseModuleStructure" runat="server" AutoGenerateColumns="False" DataSourceID="dsCourseModuleStructure" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This Course" GridLines="None" CellSpacing="-1" OnRowDataBound="gvCourseModuleStructure_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                    <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                    <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester"></asp:BoundField>
                    <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints"></asp:BoundField>
                    <asp:BoundField DataField="PreReqModules" HeaderText="PreReqModules" SortExpression="PreReqModules"></asp:BoundField>
                </Columns>
            </asp:GridView>


            <hr />
            <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Class List" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />


            <asp:SqlDataSource runat="server" ID="dsCourseModuleStructure" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.CatPoints, tbl_modules.PreReqModules, tbl_semester.Semester FROM tbl_modules INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id WHERE (tbl_course.Id = @courseId) ORDER BY tbl_modules.Level ASC" FilterExpression="Level = '{0}'">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_courseId" Name="courseId" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter Name="Level" ControlID="ddlLevels" PropertyName="SelectedValue" />
                </FilterParameters>
            </asp:SqlDataSource>
        </div>

    </asp:Panel>
















</asp:Content>
