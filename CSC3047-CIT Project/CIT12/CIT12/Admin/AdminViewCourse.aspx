<%@ Page Title="View Courses" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewCourse.aspx.cs" Inherits="CIT12.Admin.AdminViewCourse" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>View Course</h3>
    </div>

    <div class="container">

        <asp:Label ID="lblActive" runat="server" Text="Active Courses"></asp:Label>

        <asp:GridView ID="gvActive" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" GridLines="None" CellSpacing="-1" DataSourceID="SqlViewActive" OnRowCommand="gvActive_RowCommand" EmptyDataText="There are currently no enabled courses">
            <Columns>                
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                <asp:CheckBoxField DataField="Active" HeaderText="Active" InsertVisible="False" SortExpression="Active" Visible="False" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEditCourse" runat="server" Text="Edit Course Details"  class="btn btn-primary" CommandName ="EditCourse"/>
                        <asp:Button ID="btnViewModules" runat="server" Text="View Course Modules" class="btn btn-info" CommandName ="ViewModules"/>
                        </ItemTemplate>                   
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("Id") %>' runat="server" />
                        <asp:HiddenField ID="HiddenFieldSchoolId" Value='<%# Eval("SchoolId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlViewActive" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT * FROM [tbl_course] WHERE ([Active] = @Active)">
            <SelectParameters>
                <asp:Parameter DefaultValue="True" Name="Active" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>

        <br />

        <asp:Label ID="lblInactive" runat="server" Text="Inactive Courses"></asp:Label>

      
        <asp:GridView ID="gvInactive" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" GridLines="None" CellSpacing="-1" DataSourceID="SqlInactive" OnRowCommand="gvInactive_RowCommand" EmptyDataText="There are currently no disabled courses">
            <Columns>                
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                <asp:CheckBoxField DataField="Active" HeaderText="Active" InsertVisible="False" SortExpression="Active" Visible="False" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEditCourse" runat="server" class="btn btn-primary" Text="Edit Course Details" CommandName ="EditCourse"/>
                        <asp:Button ID="btnViewModules" runat="server" class="btn btn-info" Text="View Course Modules" CommandName ="ViewModules"/>
                        </ItemTemplate>                   
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("Id") %>' runat="server" />
                        <asp:HiddenField ID="HiddenFieldSchoolId" Value='<%# Eval("SchoolId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlInactive" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT * FROM [tbl_course] WHERE ([Active] = @Active)">
            <SelectParameters>
                <asp:Parameter DefaultValue="False" Name="Active" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>

      
    </div>

   

</asp:Content>
