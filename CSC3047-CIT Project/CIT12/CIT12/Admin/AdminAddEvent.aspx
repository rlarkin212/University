<%@ Page Title="Add Event To Module" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddEvent.aspx.cs" Inherits="CIT12.Admin.AdminAddEvent" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Add Event</li>
    </ul>

    <div class="row">
        <h3>Add Event To Module</h3>
        <small>Add events to modules such as lectures and practicals</small>
        <hr />
    </div>

    <%--modules panel--%>
    <asp:Panel ID="pnlModules" runat="server">

        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <label class="control-label" for="ddlSchool">School</label>
                    <asp:DropDownList ID="ddlSchool" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="control-label" for="ddlCourse">Course</label>
                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
                </div>

            </div>
        </div>


        <br />
        <div class="row">
            <a class="btn btn-primary" href="AdminEditEvents.aspx">Edit Events</a>
            <br />
            
        </div>
        

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
                            <asp:Button ID="btnAddEvents" runat="server" Text="Create Events" CssClass="btn btn-primary btn-block" CommandName="cmdAddEvent" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnAddOneOffEvents" runat="server" Text="Create One Off Event" CssClass="btn btn-info btn-block" CommandName="cmdAddOneOffEvent" />
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


    <%--add event panel--%>
    <asp:Panel ID="pnlAddEvent" runat="server" Visible="false">

        <div class="container">
            <label class="control-label" for="ddlClassType">Class Type</label>
            <asp:DropDownList ID="ddlClassType" runat="server" CssClass="form-control"></asp:DropDownList>


            <label class="control-label" for="ddlDay">Day</label>
            <asp:DropDownList ID="ddlDay" runat="server" CssClass="form-control"></asp:DropDownList>


            <br />
            <small>Please Enter Times In The 24 Hour Format</small>
            <div class="row">

                <div class="col-md-4">
                    <label class="control-label" for="txtStartTime">Start</label>
                    <asp:TextBox ID="txtStartTime" runat="server" CssClass="form-control" Placeholder="eg.09:00" MaxLength="5"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <label class="control-label" for="txtEndTime">End</label>
                    <asp:TextBox ID="txtEndTime" runat="server" CssClass="form-control" Placeholder="eg.10:00" MaxLength="5"></asp:TextBox>
                </div>
            </div>

            <label class="control-label" for="txtLocation">Location</label>
            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>

            <br />
            <asp:Label ID="lblClassError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            <br />
            <asp:Button ID="btnSubmitClassTimes" runat="server" Text="Add Event" CssClass="btn btn-lg btn-success" OnClick="btnSubmitClassTimes_Click" />

        </div>

    </asp:Panel>


    <%--add one off event--%>
    <asp:Panel ID="pnlOneOffEvent" runat="server" Visible="false">


           <div class="row">
            <h4>Add One Off Events</h4>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label class="control-label" for="txtTitle">Event Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvTitle" ControlToValidate="txtTitle" ErrorMessage="Please Enter A Title" ForeColor="Red" />
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtDescription">Event Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvDescription" ControlToValidate="txtDescription" ErrorMessage="Please Enter A Description" ForeColor="Red" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label class="control-label" for="txtTime">Event Time</label>
                <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" Placeholder="eg. 13:00" MaxLength="5"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvTime" ControlToValidate="txtTime" ErrorMessage="Please Enter A Time" ForeColor="Red" />
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtEventLocation">Event Location</label>
                <asp:TextBox ID="txtEventLocation" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvLocation" ControlToValidate="txtEventLocation" ErrorMessage="Please Enter A Location"  ForeColor="Red"/>
            </div>
        </div>

        <br />


        <div class="row">
            <div class="col-md-4">
                <asp:Calendar ID="calDate" runat="server" OnSelectionChanged="calDate_SelectionChanged"></asp:Calendar>
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtDate">Event Date</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvDate" ControlToValidate="txtDate" ErrorMessage="Please Enter A Date" />
            </div>

        </div>

        <br />

        <div class="row">
            <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            <br />
            <asp:Button ID="btnSubmitEvent" runat="server" Text="Create Event" CssClass="btn btn-lg btn-success" OnClick="btnSubmitEvent_Click" />
        </div>


        
    </asp:Panel>



</asp:Content>
