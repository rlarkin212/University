<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Accounts_Default" %>

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
         <a class="navbar-brand" href="../default.aspx">ElmTree Buy & Sell</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <div class="navbar-form navbar-right">
            <ul class="nav navbar-nav">
                    <li><a href="../itemsForSale.aspx"><span class="glyphicon glyphicon-tags"></span> Items For Sale</a></li>
                   <li><a href="Default.aspx"><span class="glyphicon glyphicon-user"></span> My Account</a></li>
                   <li><a href="../logIn.aspx"><span class="glyphicon glyphicon-log-in"></span> Login / Sign Up</a></li> 
                </ul>
                <a href="uploadItemForm.aspx" role="button" class="btn btn-success btn-lg"><span class="glyphicon glyphicon-pushpin"></span>Post An Ad</a>
              
          </div>        
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
    <!-- Nav End  -->

        <div class="jumbotron">
            <div class="container">
                
                <div class="col-lg-12">
                <h1 class="page-header">User Center</h1>
                </div>
                
                <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src="../img/items.gif" alt="" height="400" width="400">
                            <div class="caption">
                                <h4><a href="myAccount.aspx">Edit Item Info</a>
                                </h4>
                                
                            </div>
                            
                        </div>
                    </div>


                <asp:SqlDataSource ID="picSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT * FROM [users] WHERE ([Id] = @Id)">
            <SelectParameters>
                <asp:SessionParameter SessionField="user" Name="Id" Type="String"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
                
                <asp:ListView ID="profilePic" runat="server" DataSourceID="picSrc">
                    <ItemTemplate>
                <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                              <asp:Image ID="itemPic" runat="server" ImageURL='<%# "../../files/"+Eval("profilePic") %>' width="400px" /><br />
                            <div class="caption">
                                <h4><a href="editUser.aspx">Edit User Info</a>
                                </h4>
                            </div>    
                        </div>
                    </div>
                    </ItemTemplate>
                    </asp:ListView>


                <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src="../img/messages.jpg" alt="" height="400" width="400">
                            <div class="caption">
                                <h4><a href="messages.aspx">View Messages</a>
                                </h4>
                                
                            </div>
                            
                        </div>
                    </div>

                <div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="logoutBtn" role="button" runat="server" Text="Logout" OnClick="logoutBtn_Click" />  
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
