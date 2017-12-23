<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectManagerView.aspx.cs" Inherits="CIT12.ProjectManagerView" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlProTitle" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT [Title] FROM [tbl_Projects] WHERE ([Id] = @Id)">
        <SelectParameters>
            <asp:SessionParameter Name="Id" SessionField="projectId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="Projects.aspx">Projects</a></li>
        <li class="active">Project Manager View</li>
    </ul>


    <h1>

        <asp:FormView ID="fvTitle" runat="server" DataSourceID="SqlProTitle">
            <EditItemTemplate>
                Title:
                <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                Title:
                <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Title:
                <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>' />
                <br />

            </ItemTemplate>
        </asp:FormView>
    </h1>
    <asp:SqlDataSource ID="SqlProInfo" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT [Details] FROM [tbl_Projects] WHERE ([Id] = @Id)">
        <SelectParameters>
            <asp:SessionParameter Name="Id" SessionField="projectId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="FVInfo" runat="server" DataSourceID="SqlProInfo">
        <EditItemTemplate>
            Details:
            <asp:TextBox ID="DetailsTextBox" runat="server" Text='<%# Bind("Details") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            Details:
            <asp:TextBox ID="DetailsTextBox" runat="server" Text='<%# Bind("Details") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            Details:
            <asp:Label ID="DetailsLabel" runat="server" Text='<%# Bind("Details") %>' />
            <br />

        </ItemTemplate>
    </asp:FormView>
    <asp:Panel ID="pnlLogInRequired" runat="server" Visible="False">
        <p>To See Your Projects Please Log In</p>
    </asp:Panel>

    <asp:Panel ID="pnlNotPM" runat="server" Visible="False">
        <p>You're Not The Project Manager For This Project</p>
    </asp:Panel>
    <asp:Panel ID="pnlPMView" runat="server">
        
        <br />

        <div id="successAlertMessagePM" runat="server" visible="false">
            <div class="alert alert-success alert-dismissable">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>Success!</strong> You have assigned your project a project manager
            </div>
        </div>
        
        

        <div id="successAlertMessageSM" runat="server" visible="false">
            <div class="alert alert-success alert-dismissable">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>Success!</strong> You have assigned your project a scrum master
            </div>
        </div>
        <h3>
            <asp:Label ID="lblOwnerTitle" runat="server" Text="Users Available Within This Project To Become The Project Manager"></asp:Label></h3>
        <asp:GridView ID="GridViewTeamOwner" runat="server" DataSourceID="sqlTeamOwner" AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="GridViewTeamOwner_RowCommand" AllowPaging="True" GridLines="None" CssClass="table table-striped table-bordered table-condensed table-hover">
            <Columns>
                <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename" />
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:TemplateField>
                    <HeaderTemplate>Project Manager</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnMakePM" runat="server" Text="Make User the Project Manager" CssClass="btn btn-block btn-success" CommandName="Select" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("User_ID") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="sqlTeamOwner" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT DISTINCT tbl_ProjectPersonnel.User_Id, tbl_User.Id, tbl_User.Forename, tbl_User.Surname, tbl_User.Email FROM tbl_ProjectPersonnel INNER JOIN tbl_User ON tbl_ProjectPersonnel.User_Id = tbl_User.Id WHERE (tbl_ProjectPersonnel.User_RoleCode &gt;= 30) AND (tbl_ProjectPersonnel.Project_Id = @Project_ID)" DeleteCommand="DELETE FROM tbl_WorkingOn WHERE (Project_ID = @Project_ID) AND (User_Role_Code = 20)">
            <DeleteParameters>
                <asp:Parameter Name="Project_ID" />
            </DeleteParameters>
            <SelectParameters>
                <asp:SessionParameter Name="Project_ID" SessionField="projectId" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h3>
            <asp:Label ID="lblOwnerScrum" runat="server" Text="Users Available Within This Project To Become A Scrum Master"></asp:Label></h3>

        <asp:SqlDataSource ID="SqlTeamScrum" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT DISTINCT tbl_ProjectPersonnel.User_Id, tbl_User.Id, tbl_User.Forename, tbl_User.Surname, tbl_User.Email FROM tbl_ProjectPersonnel INNER JOIN tbl_User ON tbl_ProjectPersonnel.User_Id = tbl_User.Id WHERE (tbl_ProjectPersonnel.User_RoleCode &gt;= 40) AND (tbl_ProjectPersonnel.Project_Id = @Project_ID)">
            <SelectParameters>
                <asp:SessionParameter Name="Project_ID" SessionField="projectId" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridViewTeamScrum" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="sqlTeamScrum" GridLines="None" OnRowCommand="GridViewTeamScrum_RowCommand" CssClass="table table-striped table-bordered table-condensed table-hover">
            <Columns>

                <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename" />
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />

                <asp:TemplateField>
                    <HeaderTemplate>Scrum Master</HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button ID="btnMakeSM" runat="server" Text="Make User a Scrum Master" CssClass="btn btn-block btn-success" CommandName="Select" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("User_ID") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
</asp:Content>
