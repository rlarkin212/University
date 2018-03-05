<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editItem.aspx.cs" Inherits="Accounts_editItem" %>

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
         <a class="navbar-brand" href="../default.aspx">ElmTree Buy & Sell - Admin Center</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <div class="navbar-form navbar-right">
            <ul class="nav navbar-nav">
                    <li><a href="../itemsForSale.aspx"><span class="glyphicon glyphicon-tags"></span> Edit Items For Sale</a></li>
                   <li><a href="Default.aspx"><span class="glyphicon glyphicon-user"></span> Edit User Info</a></li>
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
                <h1 class="page-header">Edit User Info</h1>
                </div>

                <div class="form-horizontal">

                     <div class="form-group"> 
					 <label for="email" class="col-sm-2 control-label">Name: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="nameEdit" CssClass="form-control" runat="server">
                    </asp:TextBox>
					</div>
				</div><br />
                  
                    <div class="form-group"> 
					 <label for="password" class="col-sm-2 control-label">Description:</label>
					 <div class="col-sm-6">
                        <asp:TextBox ID="descriptionEdit" CssClass="form-control"  runat="server" TextMode="MultiLine"></asp:TextBox>
						</div>
                    </div><br />

                     <div class="form-group"> 
					 <label for="username" class="col-sm-2 control-label">Price: </label>
					 <div class="col-sm-6">
                    <asp:TextBox ID="priceEdit" CssClass="form-control" runat="server" Placeholder="£">
                    </asp:TextBox>
					</div>
				</div><br /> 
                    
                    <div class="imgright">
                    <asp:Image ID="imagepic" runat="server" ImageURL='<%# "../files/"+Eval("ImagePath") %>' width="400px" />
                    </div> 

                    <div class="form-group"> 
					 <label for="itemImage" class="col-sm-2 control-label">Item Image:</label>
					 <div class="col-sm-6">
                    
                        <asp:FileUpload ID="itemImageEdit" CssClass="form-control" runat="server" /> 
                   <asp:Image ID="Image1" runat="server" /> 

					</div>
				</div><br />
                    
                    <div class="form-group">
                    <asp:SqlDataSource ID="itemCatSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [Category] FROM [Categories]">
                        </asp:SqlDataSource>

                        <label for="usertype" class="col-sm-2 control-label">Item Category:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="itemCatEdit" CssClass="form-control" runat="server" DataTextField="Category" DataValueField="ID" DataSourceID="itemCatSrc"></asp:DropDownList>
					 </div><br />
                        </div>
                    
                    <div class="form-group">
                     <asp:SqlDataSource ID="visSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [vis] FROM [visability]">
                        </asp:SqlDataSource>
                    
                     <label for="usertype" class="col-sm-2 control-label">Visability:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="visEdit" CssClass="form-control" runat="server" DataTextField="vis" DataValueField="ID" DataSourceID="visSrc"></asp:DropDownList>
					 </div><br />
                    </div>

                    <div class="form-group">
                        <asp:SqlDataSource ID="sponsSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [spons] FROM [spons]">
                        </asp:SqlDataSource>
                    
                     <label for="usertype" class="col-sm-2 control-label">Sponsored:</label>
					<div class="col-sm-3">
                        <asp:DropDownList ID="sponsEdit" CssClass="form-control" runat="server" DataTextField="spons" DataValueField="Id" DataSourceID="sponsSrc"></asp:DropDownList>
					 </div><br />
                    </div>

                    

                    
                
                
                </div>

                
                <div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="editItemInfoBtn" role="button" runat="server" Text="Update Item Info" OnClick="editItemInfoBtn_Click" />  
					</div><br />

                 <br />
                <br />
                <br />

                <div class="pull-right">
                    <asp:Button CssClass="btn btn-success btn-lg" ID="deleteItemBtn" role="button" runat="server" Text="Delete Item" OnClick="deleteItemBtn_Click" />  
					</div>









                </div>
            </div>
        



    </form>
</body>
</html>
