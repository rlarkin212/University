<%@ Page Title="View Modules" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewModules.aspx.cs" Inherits="CIT12.Admin.AdminViewModules" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>View Modules</h3>
    </div>

    <div class="container">

        <asp:Label ID="lblActive" runat="server" Text="Active Modules"></asp:Label>

        <asp:GridView ID="gvActive" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" DataSourceID="SqlViewActive" OnRowCommand="gvActive_RowCommand" EmptyDataText="There are currently no enabled modules for this course">
            <Columns>                
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" />
                <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints" />
                <asp:BoundField DataField="PreReqModules" HeaderText="PreReqModules" SortExpression="PreReqModules" />
                <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription" />
            
             <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEditModule" runat="server" class="btn btn-primary" Text="Edit Module Details" CommandName ="EditModule"/>
                        <asp:Button ID="btnDeleteModule" runat="server" class="btn btn-primary" Text="Remove Module" CommandName ="DeleteModule"/>
                        </ItemTemplate>                   
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("Id") %>' runat="server" />
                         <asp:HiddenField ID="HiddenFieldSchId" Value='<%# Eval("CourseId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlViewActive" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT Id, CourseId, Title, Code, Level, SemesterId, CatPoints, PreReqModules, ModuleDescription, Active FROM tbl_modules WHERE (Active = 1) AND (CourseId = @courseId)">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="1" Name="courseId" SessionField="s_CourseId" />
            </SelectParameters>
        </asp:SqlDataSource>

        <br />

        <asp:Label ID="lblInactive" runat="server" Text="Inactive Modules"></asp:Label>

      
        <asp:GridView ID="gvInactive" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" DataSourceID="SqlViewInactive" OnRowCommand="gvInactive_RowCommand" EmptyDataText="There are currently no disabled modules for this course">
             <Columns>                
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" />
                <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints" />
                <asp:BoundField DataField="PreReqModules" HeaderText="PreReqModules" SortExpression="PreReqModules" />
                <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription" />
            
             <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnEditModule" runat="server" class="btn btn-primary" Text="Edit Module Details" CommandName ="EditModule"/>
                        <asp:Button ID="btnDeleteModule" runat="server" class="btn btn-primary" Text="Remove Module" CommandName ="DeleteModule"/>
                    </ItemTemplate>                   
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenFieldId" Value='<%# Eval("Id") %>' runat="server" />
                        <asp:HiddenField ID="HiddenFieldSchId" Value='<%# Eval("CourseId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlViewInactive" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT Id, CourseId, Title, Code, Level, SemesterId, CatPoints, PreReqModules, ModuleDescription, Active FROM tbl_modules WHERE (Active != 1) AND (CourseId = @courseId)">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="1" Name="courseId" SessionField="s_CourseId" />
            </SelectParameters>
        </asp:SqlDataSource>

      
    </div>

   

</asp:Content>
