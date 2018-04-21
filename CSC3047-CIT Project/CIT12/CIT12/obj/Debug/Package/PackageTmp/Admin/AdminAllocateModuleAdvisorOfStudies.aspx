<%@ Page Title="Allocate Module Advisor Of Studies" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAllocateModuleAdvisorOfStudies.aspx.cs" Inherits="CIT12.Admin.AdminAllocateModuleAdvisorOfStudies" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Allocate Moudle Advisor Of Studies</li>
    </ul>


    <%--academic panel--%>
    <asp:Panel ID="pnlAcacdemic" runat="server">
        <div class="row">
            <h3>Allocate Module Advisor Of Studies </h3>
        </div>

        <div class="form-group">
            <div class="row">
                <div>
                    <label for="txtSaffNumber" class="control-label">Student Number</label>
                    <asp:TextBox ID="txtSaffNumber" runat="server" Placeholder="EG.40107426" CssClass="form-control"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-block" />
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <asp:GridView ID="gvAcacemic" runat="server" DataSourceID="dsAcademics" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Users Are Found For This Staff Number" GridLines="None" CellSpacing="-1" OnRowCommand="gvAcacemic_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Number" HeaderText="Staff Number" SortExpression="Number"></asp:BoundField>
                        <asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="FullName" ReadOnly="True"></asp:BoundField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnAssignToModule" runat="server" Text="Assign To Module" CssClass="btn btn-info btn-block" CommandName="cmdAssignToModule" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <asp:SqlDataSource runat="server" ID="dsAcademics" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName FROM tbl_user WHERE (tbl_user.Role = @role OR tbl_user.Role = @role2)" FilterExpression="Number LIKE '{0}%'">
            <SelectParameters>
                <asp:Parameter DefaultValue="20" Name="role"></asp:Parameter>
                <asp:Parameter DefaultValue="40" Name="role2"></asp:Parameter>
            </SelectParameters>
            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtSaffNumber" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>
    </asp:Panel>


    <%--module panel--%>
    <asp:Panel ID="pnlSelectModule" runat="server" Visible="false">


        <div class="row">
            <div class="col-md4">
                <label class="control-label" for="ddlLevels">Course</label>
                <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
            </div>
        </div>

        <br />

        <asp:Label ID="lblSuccessMessage" runat="server" Text="asd" CssClass="text-success"></asp:Label>
        <br />
        <div class="row">
            <asp:GridView ID="gvModules" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsModules" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This Course" GridLines="None" CellSpacing="-1" OnRowCommand="gvModules_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                    <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription"></asp:BoundField>
                    <asp:TemplateField>
                        <HeaderTemplate>Note</HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="txtNote" runat="server" CssClass="form-control"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnAssign" runat="server" Text="Assign To Module" CssClass="btn btn-block btn-success" CommandName="btnAssignToModule" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="dsModules" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.CourseId, tbl_modules.Title, tbl_modules.Code, tbl_modules.ModuleDescription FROM tbl_modules INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id" FilterExpression="CourseId = '{0}'">
                <FilterParameters>
                    <asp:ControlParameter Name="CourseId" ControlID="ddlCourse" PropertyName="SelectedValue" />
                </FilterParameters>
            </asp:SqlDataSource>
        </div>




    </asp:Panel>












</asp:Content>
