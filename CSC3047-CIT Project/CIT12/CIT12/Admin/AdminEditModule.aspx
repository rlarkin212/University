<%@ Page Title="Admin Edit Module" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditModule.aspx.cs" Inherits="CIT12.Admin.AdminEditModule" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="heading">
        <h3>Edit Module Information: <asp:Label ID="lblCode" runat="server" Text="Code"></asp:Label></h3>
    </div>

    <div class="container">

        <label class="control-label" for="txtTitle"> Title:</label>
        <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>      
         <br />
        <label class="control-label" for="txtDesc"> Description:</label>
        <asp:TextBox ID="txtDesc" runat="server"></asp:TextBox>      
         <br />
        <label class="control-label" for="ddlLevel"> Level:</label>               
        <asp:DropDownList ID="ddlLevel" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlLevel_SelectedIndexChanged" >
            <asp:ListItem Value="1">Level 1</asp:ListItem>
            <asp:ListItem Value="2">Level 2</asp:ListItem>
            <asp:ListItem Value="3">Level 3</asp:ListItem>
        </asp:DropDownList>
        <br />
        <label class="control-label" for="ddlSemester"> Semester:</label>               
        <asp:DropDownList ID="ddlSemester" runat="server">
            <asp:ListItem Value="1">Autumn</asp:ListItem>
            <asp:ListItem Value="2">Spring</asp:ListItem>
            <asp:ListItem Value="3">Full Year</asp:ListItem>
        </asp:DropDownList>
        <br />
        <label class="control-label" for="txtCAT"> CAT Points:</label>
        <asp:TextBox ID="txtCAT" runat="server"></asp:TextBox>      
         <br />
        <label class="control-label" for="ddlPreReq"> Pre-Requisite Module:</label>               
        <asp:DropDownList ID="ddlPreReq" runat="server" DataSourceID="sqlPreReq" DataTextField="Code" DataValueField="Code" AppendDataBoundItems="True" Enabled="False">
             <asp:ListItem Value="N/A">N/A</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="sqlPreReq" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnection %>" SelectCommand="SELECT Id, CourseId, Title, Code, Level, SemesterId, CatPoints, PreReqModules, ModuleDescription, Active FROM tbl_modules WHERE (Level &lt; @level) AND (Id != @courseId) AND (CourseId = @schoolId)">
            <SelectParameters>              
                <asp:ControlParameter ControlID="ddlLevel" PropertyName="SelectedValue" DefaultValue="1" Name="level" />                
                <asp:SessionParameter DefaultValue="0" Name="courseId" SessionField="s_ModuleId" />
                <asp:SessionParameter DefaultValue="0" Name="schoolId" SessionField="s_SchoolId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />

        <asp:CheckBox ID="cbActive" runat="server" CssClass="checkbox" />

         <br />
        <asp:Button ID="btnUpdate" runat="server" class="btn btn-primary" Text="Update Module Details" OnClick="btnUpdate_Click" />




    </div>
</asp:Content>

