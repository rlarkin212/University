<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProjects.aspx.cs" Inherits="CIT12.UserProjects" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li class="active">User Projects</li>
    </ul>

    <div class="heading">
        <h3>User Projects</h3>
    </div>


    <asp:GridView ID="gvUserProjects" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsUserProjects" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" OnRowCommand="gvUserProjects_RowCommand" EmptyDataText="No Projects Are Avaliable">
        <Columns>
            <asp:CommandField ShowEditButton="True" Visible="false"></asp:CommandField>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Details" HeaderText="Details" SortExpression="Details" />


            <asp:TemplateField>
                <HeaderTemplate>Project backlog</HeaderTemplate>
                <ItemTemplate>
                    <asp:Button ID="btnViewProductBacklog" runat="server" Text="View Product Backlog" CssClass="btn btn-block btn-primary" CommandName="ViewBacklog" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField>
                <HeaderTemplate>View Project Sprints</HeaderTemplate>
                <ItemTemplate>
                    <asp:Button ID="btnViewProjectSprints" runat="server" Text="View Project Sprints" CssClass="btn btn-block btn-primary" CommandName="ViewSprints" />
                </ItemTemplate>
            </asp:TemplateField>



        </Columns>
    </asp:GridView>





    <asp:SqlDataSource runat="server" ID="dsUserProjects" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT [Id], [Title], [Details] FROM [tbl_Projects]" DeleteCommand="DELETE FROM [tbl_Projects] WHERE [Id] = @Id" InsertCommand="INSERT INTO [tbl_Projects] ([Title], [Details]) VALUES (@Title, @Details)" UpdateCommand="UPDATE [tbl_Projects] SET [Title] = @Title, [Details] = @Details WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Title" Type="String"></asp:Parameter>
            <asp:Parameter Name="Details" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String"></asp:Parameter>
            <asp:Parameter Name="Details" Type="String"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>




</asp:Content>

