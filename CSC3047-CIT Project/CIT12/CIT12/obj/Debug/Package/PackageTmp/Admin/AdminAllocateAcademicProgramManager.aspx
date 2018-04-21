<%@ Page Title="Allocate Academic Program Manager" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAllocateAcademicProgramManager.aspx.cs" Inherits="CIT12.Admin.AdminAllocateAcademicProgramManager" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Allocate Academic Program Manager</li>
    </ul>


    <div class="row">
        <h3>Allocate Academic Program Manager</h3>
    </div>

    <%--program manager panel--%>
    <asp:Panel ID="pnlProgramManager" runat="server">

        <div class="form-group">
            <div class="row">
                <div>
                    <label>Staff Number</label>
                    <asp:TextBox ID="txtStaffNumber" runat="server" Placeholder="EG.40107426" CssClass="form-control"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-block" />
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <asp:GridView ID="gvProgramManagers" runat="server" DataSourceID="dsProgramManagers" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Academic Program Mangers Are Found For This Number" GridLines="None" CellSpacing="-1" OnRowCommand="gvProgramManagers_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Number" HeaderText="Staff Number" SortExpression="Number"></asp:BoundField>
                        <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" ReadOnly="True"></asp:BoundField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnAssignProgramManager" runat="server" Text="Allocate Academic Program Manager" CssClass="btn btn-primary btn-block" CommandName="cmdAssignProgramManager" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>


        <asp:SqlDataSource runat="server" ID="dsProgramManagers" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName FROM tbl_user WHERE (tbl_user.Role = @role)" FilterExpression="Number LIKE '{0}%'">
            <SelectParameters>
                <asp:Parameter DefaultValue="40" Name="role"></asp:Parameter>
            </SelectParameters>
            <FilterParameters>
                <asp:ControlParameter Name="Number" ControlID="txtStaffNumber" PropertyName="Text" />
            </FilterParameters>
        </asp:SqlDataSource>

    </asp:Panel>

    <%--course panel--%>
    <asp:Panel ID="pnlCourse" runat="server" Visible="false">

        <div class="form-group">
            <div class="row">
                <div>
                    <label class="control-label" for="ddlSchool">School</label>
                    <asp:DropDownList ID="ddlSchool" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <asp:Label ID="lblSuccessMessage" runat="server" Text="" CssClass="text-success"></asp:Label>
                <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsCourses" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Courses Are Found For This School" GridLines="None" CellSpacing="-1" OnRowCommand="gvCourses_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="SchoolId" HeaderText="SchoolId" SortExpression="SchoolId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Course Name" SortExpression="Name"></asp:BoundField>
                        <asp:BoundField DataField="Code" HeaderText="Course Code" SortExpression="Code"></asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnAssisgn" runat="server" Text="Assign" CommandName="cmdAssign" CssClass="btn btn-block btn-success" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:SqlDataSource runat="server" ID="dsCourses" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_course]" FilterExpression="SchoolId = '{0}'">
                    <FilterParameters>
                         <asp:ControlParameter Name="SchoolId" ControlID="ddlSchool" PropertyName="SelectedValue" />
                    </FilterParameters>
                </asp:SqlDataSource>

            </div>
        </div>



    </asp:Panel>







</asp:Content>
