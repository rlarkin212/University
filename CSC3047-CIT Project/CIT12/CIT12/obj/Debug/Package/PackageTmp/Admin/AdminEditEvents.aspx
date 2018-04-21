<%@ Page Title="Edit / Delete Event Details" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditEvents.aspx.cs" Inherits="CIT12.Admin.AdminEditEvents" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Edit Event Details</li>
    </ul>


    <div class="row">
        <h3>Edit / Delete Event Details </h3>
        <small>Edit / delete the time, date and location of lectures/practicals etc.</small>
        <hr />
    </div>

    <%--module panel--%>
    <asp:Panel ID="pnlModules" runat="server">

        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <label for="ddlSchool" class="control-label">School</label>
                    <asp:DropDownList ID="ddlSchool" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged"></asp:DropDownList>
                </div>

                <div class="col-lg-4">
                    <label for="ddlCourse" class="control-label">Course</label>
                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
        </div>

        <br />
        <div class="row">
            <a class="btn btn-primary" href="AdminAddEvent.aspx">Add Events</a>
            <br />
            <br />
        </div>

        <div class="row">
            <asp:GridView ID="gvModules" runat="server" AutoGenerateColumns="False" DataSourceID="dsModules" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This School + Course Combo" GridLines="None" CellSpacing="-1" OnRowCommand="gvModules_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Module Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="SchoolId" HeaderText="SchoolId" ReadOnly="True" InsertVisible="False" SortExpression="SchoolId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                    <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                    <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription"></asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Course Name" SortExpression="Name"></asp:BoundField>
                    <asp:BoundField DataField="SchoolName" HeaderText="SchoolName" SortExpression="SchoolName"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnViewEvents" runat="server" Text="View Events" CssClass="btn btn-block btn-info" CommandName="cmdViewEvents" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>


        <asp:SqlDataSource runat="server" ID="dsModules" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.CourseId, tbl_school.Id AS SchoolId, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.ModuleDescription, tbl_course.Name, tbl_school.Name AS SchoolName FROM tbl_modules INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id INNER JOIN tbl_school ON tbl_course.SchoolId = tbl_school.Id WHERE(tbl_modules.CourseId = @courseId)" FilterExpression="SchoolId = '{0}'">
            <SelectParameters>
                <asp:SessionParameter Name="courseId" SessionField="s_courseId" Type="Int32" />
            </SelectParameters>
            <FilterParameters>
                <asp:ControlParameter Name="SchoolId" ControlID="ddlSchool" Type="Int32" />
            </FilterParameters>
        </asp:SqlDataSource>
    </asp:Panel>

    <%--events panel--%>
    <asp:Panel ID="pnlEvents" runat="server" Visible="false">

        <div class="row">
            <div class="row">
                <asp:Label ID="lblModuleName" runat="server" Text="Label"></asp:Label>
                <br />
            </div>
        </div>

        <div class="row">
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvEvents" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsEvents" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Events Are Found For This Module" GridLines="None" CellSpacing="-1" OnRowCommand="gvEvents_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"></asp:BoundField>
                    <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day"></asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"></asp:BoundField>
                    <asp:BoundField DataField="ClassTypeId" HeaderText="ClassTypeId" SortExpression="ClassTypeId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="DayId" HeaderText="DayId" SortExpression="DayId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEditEvent" runat="server" Text="Edit Event" CssClass="btn btn-block btn-primary" CommandName="cmdEditEvent" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnDeleteEvent" runat="server" Text="Delete Event" CssClass="btn btn-block btn-danger" CommandName="cmdDeleteEvent" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>

        <asp:SqlDataSource runat="server" ID="dsEvents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_timeTable.Id, tbl_classType.Type, tbl_days.Day, tbl_timeTable.Time, tbl_timeTable.Location, tbl_timeTable.ClassTypeId, tbl_timeTable.DayId FROM tbl_timeTable INNER JOIN tbl_days ON tbl_timeTable.DayId = tbl_days.Id INNER JOIN tbl_classType ON tbl_timeTable.ClassTypeId = tbl_classType.Id WHERE (tbl_timeTable.ModuleId = @moduleId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_moduleId" Name="moduleId"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>


    <%--edit event panel--%>
    <asp:Panel ID="pnlEditEvents" runat="server" Visible="false">

        <div class="container">

            <div class="form-group row">
                <label for="ddlEventType" class="control-label">Type</label>
                <asp:DropDownList ID="ddlEventType" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="form-group row">
                <label for="ddlDay" class="control-label">Day</label>
                <asp:DropDownList ID="ddlDay" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="form-group row">
                <label for="txtTime" class="control-label">Time</label>
                <asp:TextBox ID="txtTime" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvRime" ControlToValidate="txtTime" ErrorMessage="Please Enter A Time" />
            </div>

            <div class="form-group row">
                <label for="txtLocation" class="control-label">Location</label>
                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvLocation" ControlToValidate="txtLocation" ErrorMessage="Please Enter A Location" />
            </div>

            <div class="form-group row">
                <asp:Button ID="btnUpdateEvent" runat="server" Text="Update" CssClass="btn btn-lg btn-success" OnClick="btnUpdateEvent_Click" />
            </div>

        </div>




    </asp:Panel>




</asp:Content>
