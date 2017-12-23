<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductBacklog.aspx.cs" Inherits="CIT12.ProductBacklog" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src="Scripts/Reorder.js"></script>

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="UserProjects.aspx">User Projects</a></li>
        <li class="active">Product Backlog</li>
    </ul>

    <div class="heading">
        <h3>Product Backlog</h3>
        <asp:Label ID="lblProjectTitle" runat="server" Text=""></asp:Label>
    </div>


    <asp:Panel ID="pnlBacklog" runat="server">

        <div class="container">
            <h4>Product Backlog</h4>
            <asp:Button ID="btnAddStory" runat="server" Text="Add User Story" CssClass="btn btn-primary pull-right" OnClick="btnAddStory_Click" />
            <br />
            <br />
            <br />

            <asp:GridView ID="gvProductBacklog" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsProductBacklog" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" EmptyDataText="No User Stories Have Been Added" OnRowCommand="gvProductBacklog_RowCommand">


                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="ProjectId" HeaderText="ProjectId" SortExpression="ProjectId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="UserStory" HeaderText="User Story" SortExpression="UserStory"></asp:BoundField>
                    <asp:BoundField DataField="Value" HeaderText="Market Value" SortExpression="Value"></asp:BoundField>


                    <asp:TemplateField>
                        <HeaderTemplate>Add Acceptance Tests</HeaderTemplate>
                        <ItemTemplate>
                            <asp:Button ID="btnAddAcceptanceTest" runat="server" Text="Add Acceptance Test" CssClass="btn btn-block btn-primary" CommandName="AddAcceptanceTest" />
                        </ItemTemplate>
                    </asp:TemplateField>

                   
                </Columns>
            </asp:GridView>


            <asp:SqlDataSource runat="server" ID="dsProductBacklog" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_ProductBacklog] WHERE ([ProjectId] = @ProjectId)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_projectId" Name="ProjectId" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

    </asp:Panel>

    <asp:Panel ID="pnlAddUserStory" runat="server" Visible="false">

        <div class="heading">
            <h3>Add User Stories</h3>
        </div>

        <div class="container">

            <div class="form-group">
                <label class="control-label" for="txtUserStory">User Story</label>
                <asp:TextBox ID="txtUserStory" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserStory" runat="server" ControlToValidate="txtUserStory" ErrorMessage="User Story is a required field." ForeColor="Red">
                </asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label class="control-label" for="txtMarketValue">Market Value</label>
                <asp:TextBox ID="txtMarketValue" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMarketValue" runat="server" ControlToValidate="txtMarketValue" ErrorMessage="Market Value is a required field." ForeColor="Red">
                </asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Button ID="btnInsertUserStory" runat="server" Text="Add User Story" CssClass="btn btn-primary" OnClick="btnInsertUserStory_Click" />
            </div>





        </div>


    </asp:Panel>





</asp:Content>
