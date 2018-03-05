<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userInfo.aspx.cs" Inherits="Admin_userInfo" %>

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
    <!--Nav Start-->
      <!--Nav Start-->

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
                    <li><a href="../itemsForSale.aspx"><span class="glyphicon glyphicon-tags"></span> Items For Sale</a></li>
                   <li><a href="myAccount.aspx"><span class="glyphicon glyphicon-user"></span> My Account</a></li>
                   <li><a href="../logIn.aspx"><span class="glyphicon glyphicon-log-in"></span> Login / Sign Up</a></li> 
                </ul>
                <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-pushpin"></span> Post An Ad</button>
              
          </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
    <!-- Nav End  -->

        <asp:SqlDataSource ID="userInfoSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT * FROM [users]"></asp:SqlDataSource>

      
            <div class="container">
                
                <div class="col-lg-12">
                <h1 class="page-header">User Info</h1>
                </div>
                
                <div class="row">
                    <asp:ListView ID="ListView1" runat="server" DataSourceID="userInfoSrc">
                        <ItemTemplate>
                            <div>
                            <h4>Email Address - <asp:Label ID="email" runat="server" Text='<%# Eval("emailAddress") %>' /><br /></h4>
                            <h4>Username - <asp:Label ID="username" runat="server" Text='<%# Eval("username") %>' /><br /></h4>
                            <h4>Password - <asp:Label ID="password" runat="server" Text='<%# Eval("password") %>' /><br /></h4>
                            
                           <h4>UserType ID - <asp:Label ID="typeOfUser" runat="server" Text='<%# Eval("userType") %>' /><br /></h4>
                            <asp:HyperLink CssClass="btn btn-success btn-lg" ID="editBtn" role="button"  runat="server" NavigateUrl='<%# "editUserInfo.aspx?userIdEdit=" + Eval("Id") %>'>Edit/Delete</asp:HyperLink>
                                </div><br />
                        </ItemTemplate>
                    </asp:ListView>
           
            </div>
        </div>
 
       
    </form>
</body>
</html>
