<%@ Page Title="Approve Descripton Changes" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicProgramManagerApproveSpecification.aspx.cs" Inherits="CIT12.Academic.AcademicProgramManagerApproveSpecification" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Approve Moudle Description Changes</li>
    </ul>

    <div class="heading">
        <h3>Approve Specification Changes</h3>
    </div>

    <br />
    <asp:Label ID="lblError_Success" runat="server" Text="" CssClass="text-danger"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gvSpecChanges" runat="server" DataSourceID="dsSpecChanges" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Module Description Changes Have Been Proposed" GridLines="None" CellSpacing="-1" OnRowCommand="gvSpecChanges_RowCommand">
        <Columns>
            <asp:BoundField DataField="ModuleId" HeaderText="ModuleId" SortExpression="ModuleId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:BoundField DataField="Title" HeaderText="Module Title" SortExpression="Title"></asp:BoundField>
            <asp:BoundField DataField="Code" HeaderText="Module Code" SortExpression="Code"></asp:BoundField>
            <asp:BoundField DataField="AcademicId" HeaderText="AcademicId" SortExpression="AcademicId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:BoundField DataField="FullName" HeaderText="Change Requester" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
            <asp:BoundField DataField="Id" HeaderText="ChangeId" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:BoundField DataField="PendingChanges" HeaderText="Pending Changes" SortExpression="PendingChanges"></asp:BoundField>
            <%--approve button--%>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button runat="server" Text="Approve Changes" CssClass="btn btn-block btn-success" CommandName="cmdApproveChanges" />
                </ItemTemplate>
            </asp:TemplateField>
            <%--deny button--%>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button runat="server" Text="Deny Changes" CssClass="btn btn-block btn-danger" CommandName="cmdDenyChanges" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>





    <asp:SqlDataSource runat="server" ID="dsSpecChanges" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_pendingModuleDescriptionChanges.ModuleId, tbl_modules.Title, tbl_modules.Code, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname)  AS FullName, tbl_pendingModuleDescriptionChanges.PendingChanges, tbl_pendingModuleDescriptionChanges.AcademicId, tbl_pendingModuleDescriptionChanges.Id FROM tbl_academicProgramManagerModule INNER JOIN tbl_modules ON tbl_academicProgramManagerModule.ModuleId = tbl_modules.Id INNER JOIN tbl_pendingModuleDescriptionChanges ON tbl_modules.Id = tbl_pendingModuleDescriptionChanges.ModuleId INNER JOIN tbl_user ON tbl_pendingModuleDescriptionChanges.AcademicId = tbl_user.Id WHERE (tbl_academicProgramManagerModule.AcademicProgramManagerId = @loggedUserId)">
        <SelectParameters>
            <asp:SessionParameter SessionField="s_loggedUserId" Name="loggedUserId"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
