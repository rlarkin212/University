<%@ Page Title="Edit Course Details" Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Admin.Master" CodeBehind="AdminEditCourseDetails.aspx.cs" Inherits="CIT12.Admin.AdminEditCourseDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <div class="heading">
        <h3>Edit Course Details</h3>
    </div>

    <div class="container">

        <asp:Label ID="lblText" runat="server" Text="Course Details"></asp:Label>
         <br />
        <asp:Label ID="lblName" runat="server" Text="Course Title:"></asp:Label> <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        <br />

        <asp:Label ID="lblCode" runat="server" Text="Course Code:"></asp:Label> <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>
       
         <br />

        <label class="control-label" for="cbActive"> Active</label>
        <asp:CheckBox ID="cbActive" runat="server" CssClass="checkbox" />


        <asp:Label ID="lblActive" runat="server" Text="Currently Available: "></asp:Label><asp:RadioButtonList ID="rblActive" runat="server">
            <asp:ListItem Value="True">Yes</asp:ListItem>
            <asp:ListItem Value="False">No</asp:ListItem>
        </asp:RadioButtonList>

        <asp:Button ID="btnUpdate" runat="server" Text="Update Course Details" OnClick="btnUpdate_Click" />
    </div>

</asp:Content>