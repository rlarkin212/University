<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelectScrum.aspx.cs" Inherits="CIT12.SelectScrum" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h3>  <asp:Label ID="lblTitle" runat="server" Text="Pick a Scrum"></asp:Label></h3>
    <asp:GridView ID="GridViewScrum" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="sqlScrum" OnRowCommand ="GridViewScrum_RowCommand" CssClass="table table-striped table-bordered table-condensed table-hover" EmptyDataText="No Sprints Are Avaliable">
        <Columns>
            <asp:BoundField DataField="Sprint_Name" HeaderText="Sprint_Name" SortExpression="Sprint_Name" />
            <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
            <asp:BoundField DataField="End" HeaderText="End" SortExpression="End" />
            
            <asp:TemplateField>
                 <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("Id") %>' runat="server" />
                        <asp:HiddenField ID="HiddenFieldProId" Value='<%# Eval("Project_Id") %>' runat="server" />
                 </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>View Sprint</HeaderTemplate>
                    <ItemTemplate>
                         <asp:Button ID="btnView" runat="server" Text="View Sprint" CssClass="btn btn-block btn-success" CommandName="Select" />
                    </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlScrum" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT tbl_Sprints.Id, tbl_Sprints.Sprint_Name, tbl_Sprints.Start, tbl_Sprints.[End], tbl_Sprints.Project_Id FROM tbl_Sprints INNER JOIN tbl_ProjectPersonnel ON tbl_Sprints.Project_Id = tbl_ProjectPersonnel.Project_Id WHERE (tbl_ProjectPersonnel.User_Id = @userId) AND (tbl_ProjectPersonnel.User_RoleCode = 30)">
        <SelectParameters>
            <asp:SessionParameter Name="userId" SessionField="s_loggedUserId" Type="Int32"/>
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>

