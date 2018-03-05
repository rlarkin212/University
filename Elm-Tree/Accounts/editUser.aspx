<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editUser.aspx.cs" Inherits="Accounts_editUser" %>

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
                <button type="button" class="btn btn-success"><span class="glyphicon glyphicon-pushpin"></span> Post An Ad</button>
              
          </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
    <!-- Nav End  -->
        <div class="jumbotron">
        
            <div class="container">
        <div class="col-lg-12">
                <h1 class="page-header">Edit User Info</h1>
                </div>
                <div class="form-horizontal">
                
               <div class="form-group"> 
					 <label for="email" class="col-sm-2 control-label">Email: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="emailEdit" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div><br />
                  
                    <div class="form-group"> 
					 <label for="password" class="col-sm-2 control-label">Password:</label>
					 <div class="col-sm-6">
                        <asp:TextBox ID="passwordEdit" CssClass="form-control"  runat="server" ></asp:TextBox>
						</div>
                    </div><br />

                     <div class="form-group"> 
					 <label for="username" class="col-sm-2 control-label">Username: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="usernameEdit" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div><br /> 
                    
                    <div class="form-group"> 
					 <label for="username" class="col-sm-2 control-label">Address: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="addressEdit" CssClass="form-control" runat="server" TextMode="MultiLine">
                    </asp:TextBox>
					</div>
				</div><br />

                    <div class="form-group"> 
					 <label for="profileImage" class="col-sm-2 control-label">Profile Image:</label>
					 <div class="col-sm-6">
                    
                        <asp:FileUpload ID="profileImageEdit" CssClass="form-control" runat="server" /> 
                   <asp:Image ID="Image1" runat="server" /> 

					</div>
				</div><br />
                    
                    <div class="form-group"> 
					 <label for="username" class="col-sm-2 control-label">Postcode: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="postcodeEdit" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div><br />  
                    
                    <div class="form-group"> 
					 <label for="username" class="col-sm-2 control-label">Phone Number: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="phoneEdit" CssClass="form-control" runat="server" MaxLength="11">
                    </asp:TextBox>
					</div>
				</div><br />  
                    <div class="form-group">
                    <asp:SqlDataSource ID="userTypeSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [UserType] FROM [userTypes]">
                        </asp:SqlDataSource>

                        <label for="usertype" class="col-sm-2 control-label">Account Type:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="userTypeEdit" CssClass="form-control" runat="server" DataTextField="UserType" DataValueField="ID" DataSourceID="userTypeSrc"></asp:DropDownList>
					 </div>
                    </div><br/>

                <div class="form-group">
                        <asp:SqlDataSource ID="uniSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [uni] FROM [uni]">
                        </asp:SqlDataSource>
                    
                     <label for="usertype" class="col-sm-2 control-label">Learning Institute:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="uniEdit" CssClass="form-control" runat="server" DataTextField="uni" DataValueField="Id" DataSourceID="uniSrc"></asp:DropDownList>
					 </div><br />
                    </div><br />

                    <div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="editUserInfoBtn" role="button" runat="server" Text="Edit Info" OnClick="editUserInfoBtn_Click"/>  
					</div>
                <br />
                <br />
                <br />
                <br />

                 <div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="deleteuserBtn" role="button" runat="server" Text="Delete Account" OnClick="deleteuserBtn_Click"/>  
					</div>
				

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
