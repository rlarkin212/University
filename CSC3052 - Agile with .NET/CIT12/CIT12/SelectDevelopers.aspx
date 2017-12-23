<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelectDevelopers.aspx.cs" Inherits="CIT12.SelectDevelopers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="UserProjects.aspx">User Projects</a></li>
        <li><a href="Sprints.aspx">Sprints</a></li>
        <li class="active">Add Developers</li>
    </ul>


    <asp:Panel ID="pnlDevelopers" runat="server">
        <div id="successAlertMessage" runat="server" visible="false">
            <div class="alert alert-success alert-dismissable">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>Success!</strong> You've added a developer
            </div>
        </div>

        <h3>
            <asp:Label ID="lblAvail" runat="server" Text="Available Developers"></asp:Label></h3>
        <asp:GridView ID="GridViewDevelopers" runat="server" DataSourceID="sqlDevelopers" AutoGenerateColumns="False" OnRowCommand="GridViewDevelopers_RowCommand" DataKeyNames="Id" CssClass="table table-striped table-bordered table-condensed table-hover" EmptyDataText="No Developers Are Avaliable">
            <Columns>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="itemPic" runat="server" CssClass="img-responsive img-circle" ImageUrl='<%# "files/" + Eval("ProfilePic") %>' Width="150px" Height="150px" BorderWidth="0px" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename" />
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />

                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("Id") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>Add Developer</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnAdd" runat="server" Text="Add Developer" CssClass="btn btn-block btn-success" CommandName="Select" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlDevelopers" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT tbl_User.Forename, tbl_User.Surname, tbl_User.Email, tbl_User.ProfilePic, tbl_User.Id FROM tbl_ProjectPersonnel INNER JOIN tbl_User ON tbl_ProjectPersonnel.User_Id = tbl_User.Id WHERE (tbl_ProjectPersonnel.User_RoleCode = 50) AND (tbl_ProjectPersonnel.Project_Id = @proId)">
            <SelectParameters>
                <asp:SessionParameter Name="proId" SessionField="s_projectId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>




</asp:Content>
