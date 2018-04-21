<%@ Page Title="Add Student Marks" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicAddStudentMarks.aspx.cs" Inherits="CIT12.Academic.AcademicAddStudentMarks" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li><a href="AcademicInfo.aspx">Academic Info</a></li>
        <li class="active">Add Student Marks</li>
    </ul>

    <div class="heading">
        <h3>Add Student Marks</h3>
    </div>

    <asp:Panel ID="pnlModuleList" runat="server">

        <div class="heading">
            <h3>Module List</h3>
        </div>

        <asp:GridView ID="gvModuleList" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Have Not Been Assigned To Any Modules" GridLines="None" CellSpacing="-1" DataSourceID="dsModuleList" OnRowCommand="gvModuleList_RowCommand" OnRowDataBound="gvModuleList_RowDataBound">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Submission Date" SortExpression="Date"></asp:BoundField>
                <%--button template--%>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnClassList" runat="server" Text="View Class List" CssClass="btn btn-block btn-info" CommandName="cmdViewClassList" />
                    </ItemTemplate>
                </asp:TemplateField>
                <%--error template--%>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="lblModuleListError" runat="server" Text="" CssClass="text-danger"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>



        <asp:SqlDataSource runat="server" ID="dsModuleList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.CatPoints, tbl_course.Name, tbl_semester.Semester, tbl_moduleMarksEndDate.Date FROM tbl_modules INNER JOIN tbl_moduleStaff ON tbl_modules.Id = tbl_moduleStaff.ModuleId INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id INNER JOIN tbl_moduleMarksEndDate ON tbl_modules.Id = tbl_moduleMarksEndDate.ModuleId WHERE (tbl_moduleStaff.StaffId = @loggedUserId) ORDER BY tbl_modules.Id ASC">
            <SelectParameters>
                <asp:SessionParameter Name="loggedUserId" SessionField="s_loggedUserId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


    </asp:Panel>

    <%--  class list --%>
    <asp:Panel ID="pnlClassList" runat="server" Visible="false">

        <div class="heading">
            <h3>Class List</h3>
            <asp:Label ID="lblModule" runat="server" Text="" CssClass="h4"></asp:Label>
        </div>

        <br />

        <%--search box --%>
        <div class="container">
            <small>Filter List Via Student Number</small>
            <div class="row">

                <div class="col-md-4">
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

        <asp:Label ID="lblMarksSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
        <asp:GridView ID="gvClassList" runat="server" DataSourceID="dsClassList" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Have Been Enrolled In This Module" GridLines="None" CellSpacing="-1" OnRowCommand="gvClassList_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Number" HeaderText="Number" SortExpression="Number"></asp:BoundField>
                <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnSetMarks" runat="server" Text="Set Marks" CssClass="btn btn-block btn-primary" CommandName="cmdSetMarks" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="dsClassList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)  AS FullName, tbl_user.EmailAddress, tbl_years.Year, tbl_years.Id AS YearId FROM tbl_user INNER JOIN tbl_studentModule ON tbl_user.Id = tbl_studentModule.StudentId INNER JOIN tbl_years ON tbl_studentModule.YearId = tbl_years.Id WHERE (tbl_studentModule.ModuleId = @moduleId AND tbl_studentModule.YearId = @yearId) ORDER BY FullName" FilterExpression="Number LIKE '%{0}%'">
            <SelectParameters>
                <asp:SessionParameter Name="moduleId" SessionField="s_mouduleId" Type="Int32" />
                <asp:SessionParameter Name="yearId" SessionField="s_yearId" Type="Int32" />
            </SelectParameters>

            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtStudentNumber" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>



    </asp:Panel>

    <%--set amrks panel--%>
    <asp:Panel ID="pnlSetMarks" runat="server" Visible="false">

        <div class="heading">
            <asp:Label ID="lblStudent" runat="server" Text="" CssClass="h4"></asp:Label>
        </div>

        <br />

        <%--marks list view--%>
        <asp:ListView ID="lvMarks" runat="server" DataSourceID="dsStudentmarks">
            <ItemTemplate>

                <div class="container">
                    <div class="row">

                        <asp:Label ID="lblAcademicRecordId" runat="server" Text='<%# Eval("Id") %>' Visible="false"></asp:Label>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <u>
                                <asp:Label ID="lblComponentType" runat="server" Text='<%# Eval("ComponentType") %>' CssClass="h4"></asp:Label></u>
                        </div>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <strong>
                                <label for="txtMark" class="control-label">Mark</label>
                            </strong>
                            <asp:TextBox ID="txtMark" runat="server" Text='<%# Eval("Mark") %>' CssClass="form-control" MaxLength="2"></asp:TextBox>
                        </div>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <strong>
                                <label for="txtClassification" class="control-label">Classification</label>
                            </strong>
                            <asp:TextBox ID="txtClassification" runat="server" Text='<%# Eval("Classification") %>' CssClass="form-control" MaxLength="5"></asp:TextBox>
                        </div>


                    </div>
                </div>

                <hr />
            </ItemTemplate>
        </asp:ListView>

        <br />
        <asp:Button ID="btnSubmitMarks" runat="server" Text="Submit Marks" CssClass="btn btn-lg btn-success" OnClick="btnSubmitMarks_Click" />


        <asp:SqlDataSource runat="server" ID="dsStudentMarks" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_academicRecord.Id, tbl_moduleComponentTypes.ComponentType, tbl_academicRecord.Mark, tbl_academicRecord.Classification FROM tbl_moduleComponents INNER JOIN tbl_moduleComponentTypes ON tbl_moduleComponents.ComponentTypeCode = tbl_moduleComponentTypes.ComponentTypeCode INNER JOIN tbl_academicRecord ON tbl_moduleComponents.Id = tbl_academicRecord.ModuleComponentId WHERE (tbl_academicRecord.StudentId = @studentId) AND (tbl_academicRecord.ModuleId = @moduleId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_studentId" Name="studentId" Type="Int32"></asp:SessionParameter>
                <asp:SessionParameter SessionField="s_mouduleId" Name="moduleId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>


</asp:Content>
