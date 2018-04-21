<%@ Page Title="Student Enrolement" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicProgramManagerStudentEnrolement.aspx.cs" Inherits="CIT12.Academic.AcademicProgramManagerStudentEnrolement" %>

<asp:Content ID="BodyCntent" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" type="text/css" href="../Content/modal.css" />

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Enroll For A Student</li>
    </ul>


    <div class="row">
        <h3>Student Enrolement</h3>
        <small>Make enrolement choices on behalf of a student</small>
        <hr />
    </div>

    <%--students panel--%>
    <asp:Panel ID="pnlStudents" runat="server">
        <div class="row">
            <small>Search Via Student Number</small>
            <asp:TextBox ID="txtStudentNumber" runat="server" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:Button ID="btnStudentSearch" runat="server" Text="Search" CssClass="btn btn-primary" />
        </div>

        <br />

        <div class="row">
            <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsStudents" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Are Found For This Student Number" GridLines="None" CellSpacing="-1" OnRowCommand="gvStudents_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Number" HeaderText="Number" SortExpression="Number"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="FullName" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="StudentLevel" HeaderText="Student Level" SortExpression="StudentLevel"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEnroll" runat="server" Text="Enroll" CssClass="btn btn-block btn-info" CommandName="cmdEnroll" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="dsStudents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_studentUser.StudentLevel FROM tbl_user INNER JOIN tbl_studentUser ON tbl_user.Id = tbl_studentUser.StudentId WHERE (tbl_user.Role = @studentRole)" FilterExpression="Number LIKE '{0}%'">
                <SelectParameters>
                    <asp:Parameter DefaultValue="10" Name="studentRole"></asp:Parameter>
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter Name="Number" ControlID="txtStudentNumber" Type="Int32" />
                </FilterParameters>
            </asp:SqlDataSource>
        </div>
    </asp:Panel>

    <%--enrolemnt panel--%>
    <asp:Panel ID="pnlEnrolement" runat="server" Visible="false">

        <div class="row">

            <asp:Label ID="lblStudent" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:Label ID="lblCurrentLevel" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <small>Filter Modules Via School And Course</small>
            <br />
        </div>


        <div class="row">
            <div class="col-md-4">
                <label class="control-label" for="ddlSchool">School</label>
                <asp:DropDownList ID="ddlSchool" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="col-md-4">
                <label class="control-label" for="ddlCourse">Course</label>
                <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="col-md-4">
                <label class="control-label" for="ddlLevel">Level</label>
                <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
            </div>
        </div>

        <br>

        <div class="row">
            <asp:GridView ID="gvModules" runat="server" AutoGenerateColumns="False" DataSourceID="dsModules" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This School, Course, Level Combination" GridLines="None" CellSpacing="-1" OnRowCommand="gvModules_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                    <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                    <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester"></asp:BoundField>
                    <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints"></asp:BoundField>
                    <asp:BoundField DataField="PreReqModules" HeaderText="PreReqModules" SortExpression="PreReqModules"></asp:BoundField>
                    <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription"></asp:BoundField>
                    <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="SchoolId" HeaderText="SchoolId" ReadOnly="True" InsertVisible="False" SortExpression="SchoolId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnViewClassTimes" runat="server" Text="View Class Times" CssClass="btn btn-block btn-info" CommandName="cmdViewClassTimes" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>Enroll In Module</HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="cbEnroll" runat="server" CssClass="checkbox" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Button ID="btnSubmitEnrolement" runat="server" Text="Enroll Student" CssClass="btn btn-lg btn-success" OnClick="btnSubmitEnrolement_Click" />


            <%--view class time modal--%>
            <div class="modal fade modal-allow-overflow" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">
                                <asp:Label ID="lblModalTitle" runat="server" Text=""></asp:Label></h4>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblModalBody" runat="server" Text=""></asp:Label>

                            <asp:ListView ID="lvModalBody" runat="server" DataSourceID="dsModalClassTime">
                                <ItemTemplate>
                                    <strong>
                                        <asp:Label ID="lblDay" runat="server" Text='<%# Eval("Day") %>'></asp:Label></strong>
                                    <asp:Label ID="lblTime" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                                    <div class="clearfix"></div>
                                </ItemTemplate>
                            </asp:ListView>

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <%--module list data source--%>
            <asp:SqlDataSource runat="server" ID="dsModules" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_semester.Semester, tbl_modules.CatPoints, tbl_modules.PreReqModules, tbl_modules.ModuleDescription, tbl_modules.CourseId, tbl_school.Id AS SchoolId FROM tbl_modules INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id INNER JOIN tbl_school ON tbl_course.SchoolId = tbl_school.Id WHERE (tbl_modules.Active = 1)" FilterExpression="SchoolId = '{0}' AND CourseId = '{1}' AND Level = '{2}'">
                <FilterParameters>
                    <asp:ControlParameter Name="SchoolId" Type="Int32" ControlID="ddlSchool" PropertyName="SelectedValue" />
                    <asp:ControlParameter Name="CourseId" Type="Int32" ControlID="ddlCourse" PropertyName="SelectedValue" />
                    <asp:ControlParameter Name="Level" Type="Int32" ControlID="ddlLevel" PropertyName="SelectedValue" />
                </FilterParameters>
            </asp:SqlDataSource>

            <%--modal datasource--%>
            <asp:SqlDataSource ID="dsModalClassTime" runat="server" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_days.Day, tbl_timeTable.Time FROM tbl_days INNER JOIN tbl_timeTable ON tbl_days.Id = tbl_timeTable.DayId WHERE (tbl_timeTable.ModuleId = @moduleId)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_moduleIdForTimetable" Name="moduleId" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>



    </asp:Panel>

    <asp:Panel ID="pnlSuccess" runat="server" Visible="false">

        <div class="row">
            <h1 class="text-success">Success</h1>
        </div>

        <div class="row">
            <h3>The student have successfully been enrolled ! </h3>
            <a class="btn btn-success" href="AcademicHome.aspx">Return Home</a>
        </div>

       





    </asp:Panel>












</asp:Content>
