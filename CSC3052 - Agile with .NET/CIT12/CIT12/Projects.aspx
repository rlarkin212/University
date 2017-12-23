<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="CIT12.Projects" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li class="active">Projects</li>
    </ul>

    
<div class = "container">
     <div class ="heading">
         <h2>Projects</h2>
     </div>
    <asp:Panel ID="pnlLogInRequired" runat="server" Visible="False">
        <p>To See Your Projects Please Log In</p>
    </asp:Panel>
    <asp:Panel ID="pnlOngoing" runat="server">
      <div class ="subhead">
        <h4>Ongoing Projects</h4>
      </div>
        
        <asp:GridView ID="GridViewCurrentProjects" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="sqlCurrentProjects" OnSelectedIndexChanged="GridViewCurrentProjects_SelectedIndexChanged" CssClass="table table-striped table-bordered table-condensed table-hover" EmptyDataText="No Projects Are Avaliable">

           <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="Details" HeaderText="Details" SortExpression="Details" />
                <asp:BoundField DataField="ProjectManagerId" HeaderText="ProjectManagerId" SortExpression="ProjectManagerId" Visible="False" />
                <asp:CheckBoxField DataField="Complete" HeaderText="Complete" SortExpression="Complete" Visible="False" />

                <asp:TemplateField>
                            <HeaderTemplate>View Project</HeaderTemplate>
                    <ItemTemplate>
                            <asp:Button ID="bnViewProject" runat="server" Text="View Project" CssClass="btn btn-block btn-success" CommandName="Select" />
                     </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>

        <asp:SqlDataSource ID="sqlCurrentProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT * FROM [tbl_Projects] WHERE (([ProjectManagerId] = @ProjectManagerId) AND ([Complete] = @Complete)) ORDER BY [Id] DESC">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="ProjectManagerId" SessionField="s_loggedUserId" Type="Int32" />
                <asp:Parameter DefaultValue="False" Name="Complete" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
       
    </asp:Panel>

    <br />

    <asp:Panel ID="pnlPrevious" runat="server">
    <div class ="subhead">
       <h4>Previous Projects</h4>
        <asp:GridView ID="GridViewPreviousProjects" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="sqlPreviousProjects" GridLines="None" OnSelectedIndexChanged="GridViewPreviousProjects_SelectedIndexChanged" CssClass="table table-striped table-bordered table-condensed table-hover" EmptyDataText="No Projects Are Avaliable">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="Details" HeaderText="Details" SortExpression="Details" />
                <asp:BoundField DataField="ProjectManagerId" HeaderText="ProjectManagerId" SortExpression="ProjectManagerId" Visible="False" />
                <asp:CheckBoxField DataField="Complete" HeaderText="Complete" SortExpression="Complete" Visible="False" />
             
                <asp:TemplateField>
                            <HeaderTemplate>View Project</HeaderTemplate>
                    <ItemTemplate>
                            <asp:Button ID="bnViewProject" runat="server" Text="View Project" CssClass="btn btn-block btn-success" CommandName="Select" />
                     </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sqlPreviousProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT * FROM [tbl_Projects] WHERE ([Complete] = @Complete) ORDER BY [Id]">
            <SelectParameters>
                <asp:Parameter DefaultValue="True" Name="Complete" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
      
    </asp:Panel>


    </div>

</asp:Content>

