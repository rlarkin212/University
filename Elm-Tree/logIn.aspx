<%@ Page Language="C#" AutoEventWireup="true" CodeFile="logIn.aspx.cs" Inherits="logIn" %>

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
         <a class="navbar-brand" href="Default.aspx">ElmTree Buy & Sell</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <div class="navbar-form navbar-right">
            <ul class="nav navbar-nav">
                   <li><a href="itemsForSale.aspx"><span class="glyphicon glyphicon-tag"></span> Items For Sale</a></li>
                   <li><a href="Accounts/Default.aspx"><span class="glyphicon glyphicon-user"></span> My Account</a></li>
                   <li><a href="logIn.aspx"><span class="glyphicon glyphicon-log-in"></span> Login / Sign Up</a></li> 
                </ul>
                 <a href="Accounts/uploadItemForm.aspx" role="button" class="btn btn-success btn-lg"><span class="glyphicon glyphicon-pushpin"></span>Post An Ad</a>
              
          </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
    <!-- Nav End  -->
         

        <div class="jumbotron">

            <div class="container">
                 <!-- Sign In -->
                <h1 class="page-header" style="text-align:center">Sign In </h1>
                
                <div class="form-horizontal">
        	    <p>Please Sign In Below.</p>
             
                 <div class="form-group"> 
					 <label for="emailSignIn" class="col-sm-2 control-label">Email: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="signInEmail" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div>
                  
                    <div class="form-group"> 
					 <label for="loc" class="col-sm-2 control-label">Password:</label>
					 <div class="col-sm-6">
                        <asp:TextBox ID="signInPassword" CssClass="form-control"  runat="server" TextMode="Password"></asp:TextBox>
						</div>
                    </div>
                  
                    
					<div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="signInBtn" role="button" runat="server" Text="Sign In" OnClick="signInBtn_Click"  />  
					</div>

                    <p>Don't Have An Account Please SignUp Below</p>


				
                  <br/>
                    <asp:Label ID="myinfo" runat="server" Text=""  Width="100px"></asp:Label>
                  <br/>
            </div>
		
       
	   
                 <!-- Sign Up -->
                <h1 class="page-header" style="text-align:center">Sign Up</h1>
                <div class="form-horizontal">
        	    <p>Please Sign Up Below.</p>
             
                 <div class="form-group"> 
					 <label for="emailSignUp" class="col-sm-2 control-label">Email: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="signUpEmail" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div>
                  
                    <div class="form-group"> 
					 <label for="loc" class="col-sm-2 control-label">Password:</label>
					 <div class="col-sm-6">
                        <asp:TextBox ID="signUpPassword" CssClass="form-control"  runat="server" TextMode="Password"></asp:TextBox>
						</div>
                    </div>

                     <div class="form-group"> 
					 <label for="usernameSignUp" class="col-sm-2 control-label">Username: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="signUpUsername" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div>
                    
                    <div class="form-group"> 
					 <label for="profilePicSignUp" class="col-sm-2 control-label">Profile Picture:</label>
					 <div class="col-sm-6">
                    
                        <asp:FileUpload ID="profileImage" CssClass="form-control" runat="server" /> 
                   <asp:Image ID="Image1" runat="server" /> 

					</div>
				</div>

                     <div class="form-group"> 
					 <label for="addressSignUp" class="col-sm-2 control-label">Address: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="signUpAddress" CssClass="form-control" runat="server" TextMode="MultiLine">
                    </asp:TextBox>
					</div>
				</div>

                     <div class="form-group"> 
					 <label for="postcodeSignUp" class="col-sm-2 control-label">Postcode: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="signUpPostcode" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div>

                    <div class="form-group"> 
					 <label for="phonenNumberSignUp" class="col-sm-2 control-label">Phone Number: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="signUpPhoneNumber" CssClass="form-control" runat="server" MaxLength="11">
                    </asp:TextBox>
					</div>
				</div>

                    <div class="form-group">
                        <asp:SqlDataSource ID="userTypeSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [UserType] FROM [userTypes] WHERE ([Id] <= @Id)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="2" Name="Id" Type="Int32"></asp:Parameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <label for="usertype" class="col-sm-2 control-label">Account Type:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="signUpUserType" CssClass="form-control" runat="server" DataTextField="UserType" DataValueField="ID" DataSourceID="userTypeSrc"></asp:DropDownList>
					 </div>
                    </div>

                    <div class="form-group">
                        <asp:SqlDataSource ID="uniSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [uni] FROM [uni]">
                        </asp:SqlDataSource>

                        <label for="usertype" class="col-sm-2 control-label">Learning Institute:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="uniList" CssClass="form-control" runat="server" DataTextField="uni" DataValueField="ID" DataSourceID="uniSrc"></asp:DropDownList>
					 </div>
                    </div>
      
                    
					<div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="signUpButton" role="button" runat="server" Text="Sign Up" OnClick="signUpButton_Click"  />  
					</div>

				
                  <br/>
                    <asp:Label ID="Label1" runat="server" Text=""  Width="100px"></asp:Label>
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
