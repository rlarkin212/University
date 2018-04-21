<%@ Page Title="Oops" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="CIT12._404" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" type="text/css" href="Content/404.css" />

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="error-template">
                    <h1>Oops!</h1>
                    <h2>404 Not Found</h2>
                    <div class="error-details">
                        Sorry, an error has occured, Requested page not found!
                    </div>

                    <br />

                    <div class="error-actions">
                        <asp:LinkButton runat="server" ID="btnHome" OnClick="btnHome_Click" CssClass="btn btn-primary btn-lg">
                            <i class="glyphicon glyphicon-home" aria-hidden="true"></i> Take Me Home
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>



</asp:Content>
