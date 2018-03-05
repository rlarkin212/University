<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editCatInfo.aspx.cs" Inherits="Admin_editCatInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Elm Tree Buy & Sell</title>
    <link rel="stylesheet" href="../styles/cssStyle.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
   
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" />

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <nav class="navbar navbar-inverse navbar-fixed-top">
		
      <div class="container">
	  
        <div class="navbar-header">
		
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
		  
            <span class="sr-only">Toggle navigation</span>
			
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
         <a class="navbar-brand" href="default.aspx">ElmTree Buy & Sell - Admin Center</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <div class="navbar-form navbar-right">
            <ul class="nav navbar-nav">
                    <li><a href="../itemsForSale.aspx"><span class="glyphicon glyphicon-tags"></span> Edit Items For Sale</a></li>
                   <li><a href="myAccount.aspx"><span class="glyphicon glyphicon-user"></span> Edit User Info</a></li>
                   <li><a href="../logIn.aspx"><span class="glyphicon glyphicon-log-in"></span> Login / Sign Up</a></li> 
                </ul>
                <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-pushpin"></span> Post An Ad</button>
              
          </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
    <!-- Nav End  -->

        <div class="container">
                
                <div class="col-lg-12">
                <h1 class="page-header">Edit Item Info</h1>
                </div>
                <div class="form-horizontal">
                
               <div class="form-group"> 
					 <label for="email" class="col-sm-2 control-label">Category: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="catEdit" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div><br />

                    <div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="editBtn" role="button" runat="server" Text="Edit Info" OnClick="editBtn_Click"/>
                    <asp:Button ID="deleteBtn" runat="server" Text="Delete" CssClass="btn btn-lg btn-danger" OnClick="deleteBtn_Click" />  
					</div>

                </div>
            </div>

    </form>
</body>
</html>
