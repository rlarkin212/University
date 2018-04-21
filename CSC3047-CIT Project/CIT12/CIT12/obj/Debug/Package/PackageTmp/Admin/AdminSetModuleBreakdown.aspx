<%@ Page Title="Set Module Breakdown" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSetModuleBreakdown.aspx.cs" Inherits="CIT12.AdminSetModuleBreakdown" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

  
    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Set Module Breakdown</li>
    </ul>

    <div class="row">
        <h3>Set Module Breakdown</h3>
        <small>Add components to a module such as tests and coursework</small>
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
                            <asp:Button ID="btnViewBreakdown" runat="server" Text="View Breakdown" CssClass="btn btn-info btn-block" CommandName="cmdViewBreakdown" />
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

    <%--pnl breakdown--%>
    <asp:Panel ID="pnlBreakDown" runat="server" Visible="false">

        <div class="row">
            <br />
            <asp:Label ID="lblModule" runat="server" Text="" CssClass="h5"></asp:Label>
        </div>


        <div class="row">
            <br />
            <asp:Button ID="btnAddComponent" runat="server" Text="Add Component" CssClass="btn btn-primary" OnClick="btnAddComponent_Click"/>
            <br />
            <br />
            <asp:Label ID="lblPercentageError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            <br />

            <asp:GridView ID="gvBreakdown" runat="server" AutoGenerateColumns="False" DataSourceID="dsModuleBreakdown" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Module Breakdown Found" GridLines="None" CellSpacing="-1" OnRowCommand="gvBreakdown_RowCommand" OnRowDataBound="gvBreakdown_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="ComponentType" HeaderText="ComponentType" SortExpression="ComponentType"></asp:BoundField>
                     <asp:BoundField DataField="Percentage" HeaderText="Percentage" SortExpression="Percentage"></asp:BoundField>
                    <asp:BoundField DataField="ComponentTypeCode" HeaderText="ComponentTypeCode" SortExpression="ComponentTypeCode" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnDeleteBreakdown" runat="server" Text="Delete" CssClass="btn btn-block btn-danger" CommandName="cmdDeleteBreakdown"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsModuleBreakdown" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_moduleComponentTypes.ComponentType, tbl_moduleComponents.ComponentTypeCode, tbl_moduleComponents.Percentage, tbl_moduleComponents.Id FROM tbl_moduleComponents INNER JOIN tbl_moduleComponentTypes ON tbl_moduleComponents.ComponentTypeCode = tbl_moduleComponentTypes.ComponentTypeCode WHERE (tbl_moduleComponents.ModuleId = @moduleId) ORDER BY tbl_moduleComponents.ComponentTypeCode">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_moduleId" Name="moduleId"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </div>


    </asp:Panel>

   <%--add component panel--%>
    <asp:Panel ID="pnlAddComponent" runat="server" Visible="false">

        <div class="container">

            <div class="form-group row">
                <label for="ddlComponentType" class="control-label">Component Type</label>
                <asp:DropDownList ID="ddlComponentType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlComponentType_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="form-group row">
                <label for="txtPercentage" class="control-label" runat="server" id="lblPercentage">Percentage</label>
                <asp:TextBox ID="txtPercentage" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group row">
                <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
                <br />
                 <asp:Button ID="btnSubmitComponent" runat="server" Text="Add Component" CssClass="btn btn-success btn-lg" OnClick="btnSubmitComponent_Click"/>
            </div>




        </div>





    </asp:Panel>








</asp:Content>
