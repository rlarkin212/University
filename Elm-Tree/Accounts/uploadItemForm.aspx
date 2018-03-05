<%@ Page Language="C#" AutoEventWireup="true" CodeFile="uploadItemForm.aspx.cs" Inherits="Accounts_uploadItemForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
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
                   <li><a href="itemsForSale.aspx"><span class="glyphicon glyphicon-tag"></span> Items For Sale</a></li>
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
	   
                 
                <h1 class="page-header" style="text-align:center">Post An Advert</h1>
                <div class="form-horizontal">
        	    <p>Please Enter The Details Of Your Item Below </p>
             
                 <div class="form-group"> 
					 <label for="itemName" class="col-sm-2 control-label">Name: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="itemName" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div>
                  
                    <div class="form-group"> 
					 <label for="itemDescription" class="col-sm-2 control-label">Description:</label>
					 <div class="col-sm-6">
                        <asp:TextBox ID="itemDescription" CssClass="form-control"  runat="server" TextMode="Multiline"></asp:TextBox>
						</div>
                    </div>

                     <div class="form-group"> 
					 <label for="itemPrice" class="col-sm-2 control-label">Price £: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="itemPrice" CssClass="form-control" runat="server" placeholder="£">
                    </asp:TextBox>
					</div>
				</div>
                    
                    <div class="form-group"> 
					 <label for="itemImage" class="col-sm-2 control-label">Item Picture:</label>
					 <div class="col-sm-6">
                    
                        <asp:FileUpload ID="itemImage" CssClass="form-control" runat="server" /> 
                   <asp:Image ID="Image1" runat="server" /> 

					</div>
				</div>

                    <div class="form-group">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT * FROM [spons]">
                        </asp:SqlDataSource>

                        <label for="category" class="col-sm-2 control-label">Sponsored:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="itemSpons" CssClass="form-control" runat="server" DataTextField="spons" DataValueField="ID" DataSourceID="SqlDataSource1"></asp:DropDownList>
					 </div>
                    </div>

                    <div class="form-group">
                        <asp:SqlDataSource ID="categorySrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [Category] FROM [Categories]">
                        </asp:SqlDataSource>

                        <label for="category" class="col-sm-2 control-label">Category:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="itemCategory" CssClass="form-control" runat="server" DataTextField="category" DataValueField="ID" DataSourceID="categorySrc"></asp:DropDownList>
					 </div>
                    </div>

                    <div class="form-group">
                        <asp:SqlDataSource ID="itemVisSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT * FROM [visability]">
                        </asp:SqlDataSource>

                        <label for="category" class="col-sm-2 control-label">Visability:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="itemVis" CssClass="form-control" runat="server" DataTextField="vis" DataValueField="ID" DataSourceID="itemVisSrc"></asp:DropDownList>
					 </div>
                    </div>

                    
					<div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="signUpButton" role="button" runat="server" Text="Post Advert" OnClick="signUpButton_Click"/>  
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
