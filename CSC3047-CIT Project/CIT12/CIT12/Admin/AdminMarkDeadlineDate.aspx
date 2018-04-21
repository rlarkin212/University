<%@ Page Title="Set Module Mark Deadline" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminMarkDeadlineDate.aspx.cs" Inherits="CIT12.Admin.AdminMarkDeadlineDate" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Set Module Mark Deadline</li>
    </ul>

    <div class="row">
        <h3>Set Mark Deadline Date</h3>
        <small>Set the deadline date for an academic to eneter a student mark for a module
        </small>
        <hr />
    </div>


    <asp:Panel ID="pnlModules" runat="server">

        <div class="container">
            <div class="row">

                <div class="col-md-4">
                    <label class="control-label" for="ddlSchool">School</label>
                    <asp:DropDownList ID="ddlSchool" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <label class="control-label" for="ddlCourse">School</label>
                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
                </div>

            </div>
        </div>

        <br />
        <%--modules gridview--%>
        <div class="row">
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvModules" runat="server" AutoGenerateColumns="False" DataSourceID="dsModules" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="Please Select A Valid School + Course Combination" GridLines="None" CellSpacing="-1" OnRowCommand="gvModules_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="MoudleId" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="SchoolId" HeaderText="SchoolId" ReadOnly="True" InsertVisible="False" SortExpression="SchoolId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Module Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                    <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                    <asp:BoundField DataField="ModuleDescription" HeaderText="Module Description" SortExpression="ModuleDescription"></asp:BoundField>
                    <asp:BoundField DataField="SchoolName" HeaderText="School" SortExpression="SchoolName"></asp:BoundField>
                    <asp:BoundField DataField="CourseName" HeaderText="Course" SortExpression="CourseName"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnSetDeadlineDate" runat="server" Text="Set Date" CssClass="btn btn-primary btn-block" CommandName="cmdSetDate" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="dsModules" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.CourseId, tbl_school.Id AS SchoolId, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.ModuleDescription, tbl_school.Name AS SchoolName, tbl_course.Name AS CourseName FROM tbl_modules INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id INNER JOIN tbl_school ON tbl_course.SchoolId = tbl_school.Id WHERE (tbl_modules.CourseId = @CourseId)" FilterExpression="SchoolId = '{0}'">
                <FilterParameters>
                    <asp:ControlParameter Name="SchoolId" ControlID="ddlSchool" PropertyName="SelectedValue" Type="Int32" />
                </FilterParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="CourseId" SessionField="s_courseId" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </asp:Panel>

    <%--set date panel--%>
    <asp:Panel ID="pnlSetDate" runat="server" Visible="false">

        <div class="row">
            <asp:Label ID="lblModuleName" runat="server" Text="" CssClass="h4"></asp:Label>
            <br />
            <label>Current Deadline Date : </label>
            <asp:Label ID="lblCurrentDeadlineDate" runat="server" Text=""></asp:Label>
        </div>

        <div class="row">
            <asp:Calendar ID="calDeadlineDate" runat="server" OnSelectionChanged="calDeadlineDate_SelectionChanged"></asp:Calendar>
            <hr />
        </div>

        <div class="row">
            <label class="control-label" for="txtDeadlineDate">Deadline Date</label>
            <br />
            <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            <br />
            <asp:TextBox ID="txtDeadlineDate" runat="server" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:Button ID="btnSubmitDate" runat="server" Text="Set Deadline" CssClass="btn btn-lg btn-success" OnClick="btnSubmitDate_Click" />
        </div>

    </asp:Panel>





</asp:Content>
