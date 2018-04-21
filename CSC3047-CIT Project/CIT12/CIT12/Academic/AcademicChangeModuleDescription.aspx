<%@ Page Title="Change Module Description" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicChangeModuleDescription.aspx.cs" Inherits="CIT12.Academic.AcademicChangeModuleDescription" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li><a href="AcademicInfo.aspx">Academic Info</a></li>
        <li class="active">Change Module Description</li>
    </ul>

    <div class="heading">
        <h3>Alter Module Description</h3>
    </div>

    <%--Module Panel--%>
    <asp:Panel ID="pnlModules" runat="server">
         <asp:Label ID="lblSuccessMessage" runat="server" Text="" CssClass="text-success"></asp:Label>
        <br />
        <asp:GridView ID="gvModules" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsModuleList" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Have Not Been Assigned To Any Modules" GridLines="None" CellSpacing="-1" OnRowCommand="gvModules_RowCommand">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEditDescription" runat="server" Text="Edit" CssClass="btn btn-block btn-primary" CommandName="cmdEditDescription" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>



        <asp:SqlDataSource runat="server" ID="dsModuleList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.Level, tbl_modules.CatPoints, tbl_course.Name, tbl_semester.Semester, tbl_moduleMarksEndDate.Date, tbl_modules.ModuleDescription FROM tbl_modules INNER JOIN tbl_moduleStaff ON tbl_modules.Id = tbl_moduleStaff.ModuleId INNER JOIN tbl_course ON tbl_modules.CourseId = tbl_course.Id INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id INNER JOIN tbl_moduleMarksEndDate ON tbl_modules.Id = tbl_moduleMarksEndDate.ModuleId WHERE (tbl_moduleStaff.StaffId = @loggedUserId) ORDER BY tbl_modules.Id">
            <SelectParameters>
                <asp:SessionParameter Name="loggedUserId" SessionField="s_loggedUserId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>


    </asp:Panel>


    <%--Description panel--%>
    <asp:Panel ID="pnlDescription" runat="server" Visible="false">

        <div class="container">

            <label class="control-label" for="txtDescription">Module Description</label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>

            <br />


            <asp:Button ID="btnUpdateDescription" runat="server" Text="Update" CssClass="bnt btn-lg btn-success" OnClick="btnUpdateDescription_Click" />

        </div>




    </asp:Panel>








</asp:Content>
