<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminLogIn.aspx.cs" Inherits="Admin_adminLogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>Elm Tree Buy & Sell</title>
    <link rel="stylesheet" href="styles/cssStyle.css" />

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
         <a class="navbar-brand" href="default.aspx">ElmTree Buy & Sell</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <div class="navbar-form navbar-right">
            <ul class="nav navbar-nav">
                    <li><a href="#">About</a></li>
                    <li><a href="#">Services</a></li>
                   <li><a href="itemsForSale.aspx"><span class="glyphicon glyphicon-tag"></span> Items For Sale</a></li>
                   <li><a href="userAccount.aspx"><span class="glyphicon glyphicon-user"></span> My Account</a></li>
                   <li><a href="logIn.aspx"><span class="glyphicon glyphicon-log-in"></span> Login / Sign Up</a></li> 
                </ul>
                <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-pushpin"></span> Post An Ad</button>
              
          </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
    <!-- Nav End  -->

        <div class="jumbotron">

            <div class="container">
                 <!-- Sign In -->
                <h1 class="page-header" style="text-align:center">Admin Sign In </h1>
                
                <div class="form-horizontal">
        	    <p>Please Sign In Below.</p>
             
                 <div class="form-group"> 
					 <label for="emailSignIn" class="col-sm-2 control-label">Username: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="adminUsername" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div>
                  
                    <div class="form-group"> 
					 <label for="loc" class="col-sm-2 control-label">Password:</label>
					 <div class="col-sm-6">
                        <asp:TextBox ID="adminPassword" CssClass="form-control"  runat="server" TextMode="Password"></asp:TextBox>
						</div>
                    </div>
                  
                    
					<div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="signInBtn" role="button" runat="server" Text="Sign In" OnClick="signInBtn_Click"/>  
					</div>

                    


				
                  <br/>
                    <asp:Label ID="myinfo" runat="server" Text=""  Width="100px"></asp:Label>
                  <br/>
            </div>

            </div>
        </div>
           
 <div id="footer">
      <div class="container">
        <p class="text-muted credit">&copy; 2016 Elm Tree, Inc</p>
      </div>
    </div>
    </form>
</body>
</html>
