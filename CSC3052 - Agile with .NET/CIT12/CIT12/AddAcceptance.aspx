<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddAcceptance.aspx.cs" Inherits="CIT12.AddAcceptance" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li><a href="UserProjects.aspx">User Projects</a></li>
        <li><a href="ProductBacklog.aspx">Product Backlog</a></li>
        <li class="active">Acceptance Tests</li>
    </ul>
    
    <div class="heading">
        <h3>Add Acceptance Tests</h3>
    </div>

    <div class="container">
   
        <div class="form-group">
            <label class="control-label" for="txtTest">Test Description</label>
            <asp:TextBox ID="txtTest" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button ID="btnAddAcceptanceTest" runat="server" Text="Add Task" CssClass="btn btn-lg btn-success" OnClick="btnAddAcceptanceTest_Click"/>
        </div>
    </div>


    <asp:GridView ID="gvAcceptanceTests" runat="server" DataSourceID="dsAcceptanceTests" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" PageSize="10" EmptyDataText="No Acceptance Tests Have Been Created For This User Story" OnRowDataBound="gvAcceptanceTests_RowDataBound" OnRowCommand="gvAcceptanceTests_RowCommand">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:BoundField DataField="ProjectId" HeaderText="ProjectId" SortExpression="ProjectId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:BoundField DataField="BacklogId" HeaderText="BacklogId" SortExpression="BacklogId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:BoundField DataField="Test" HeaderText="Test" SortExpression="Test"></asp:BoundField>
            <asp:BoundField DataField="Passes" HeaderText="Passes" SortExpression="Passes"></asp:BoundField>

            <asp:TemplateField>
                <HeaderTemplate>Acceptance Test Passed ?</HeaderTemplate>
                <ItemTemplate>
                    <asp:Button ID="btnPasses" runat="server" Text="Test Passes" CssClass="btn btn-block btn-success" CommandName="Passed" />
                </ItemTemplate>
            </asp:TemplateField>


        </Columns>
    </asp:GridView>


    <asp:SqlDataSource runat="server" ID="dsAcceptanceTests" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_AcceptanceTest] WHERE ([BacklogId] = @BacklogId)">
        <SelectParameters>
            <asp:SessionParameter SessionField="s_BacklogId" Name="BacklogId" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
    
