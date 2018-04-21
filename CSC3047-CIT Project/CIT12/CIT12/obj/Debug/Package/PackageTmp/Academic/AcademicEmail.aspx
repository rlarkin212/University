<%@ Page Title="Send Email" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicEmail.aspx.cs" Inherits="CIT12.Academic.AcademicEmail" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Send Email</li>
    </ul>

    <div class="heading">
        <h3>Send Email</h3>
    </div>

    <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="text-danger"></asp:Label>

    <div class="container">

        <div class="row">
            <div class="form-group col-md-4">
                <label class="control-label" for="txtHeader">Header</label>
                <asp:TextBox ID="txtHeader" runat="server" CssClass="form-control"></asp:TextBox>
                 <asp:RequiredFieldValidator runat="server" ID="rfvHeader" ControlToValidate="txtHeader" ErrorMessage="Please Enter A Header" ForeColor="Red" />
            </div>

            <div class="form-group col-md-4">
                <label class="control-label" for="txtSubject">Subject</label>
                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>
                 <asp:RequiredFieldValidator runat="server" ID="rfvSubject" ControlToValidate="txtSubject" ErrorMessage="Please Enter A Subject" ForeColor="Red" />
            </div>
        </div>


        <div class="form-group">
            <label class="control-label" for="txtBody">Body</label>
            <asp:TextBox ID="txtBody" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8"></asp:TextBox>
             <asp:RequiredFieldValidator runat="server" ID="rfvBody" ControlToValidate="txtBody" ErrorMessage="Please Enter A Body" ForeColor="Red" />
            <asp:FileUpload ID="fuAttachment" runat="server" />
        </div>

        <div class="form-group">
            <asp:Button ID="btnSendEmail" runat="server" Text="Send" CssClass="btn btn-success btn-lg" OnClick="btnSendEmail_Click" />
        </div>

    </div>




</asp:Content>
