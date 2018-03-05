<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
            <h1 class="page-header" style="text-align:center">Elmtree Buy & Sell </h1>

            <div class="container">
                <div class="row">

                    <h3 style="text-align:left">Featured Items </h3>
            <div class="col-md-9">

                <div class="row">
                    <asp:SqlDataSource ID="frontPageSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Name], [Price], [ImagePath], [Sponsored], [visability], [Id] FROM [itemsForSale] WHERE (([Sponsored] = @Sponsored) AND ([visability] = @visability))">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="Sponsored" Type="Int32"></asp:Parameter>
                            <asp:Parameter DefaultValue="1" Name="visability" Type="Int32"></asp:Parameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:ListView ID="sponsView" runat="server" DataSourceID="frontPageSrc">
                        <ItemTemplate>
                            <asp:HyperLink ID="singleItemLink" runat="server" NavigateUrl='<%# "singleItem.aspx?itemId=" + Eval("Id") %>'>
                       <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                             <asp:Image ID="itemPic" runat="server" CssClass="img-thumbnail" ImageURL='<%# "../files/"+Eval("ImagePath") %>' width="400px" /><br />
                            <div class="caption">
                               <h4 class="pull-right"> £ <asp:Label ID="Label1" runat="server" Text='<%# Eval("Price") %>' /><br /></h4>
                                <h4><asp:Label ID="itemName" runat="server" Text='<%# Eval("Name") %>' /></h4>
                            </div>
                            
                        </div>
                    </div>
                                </asp:HyperLink>
                        </ItemTemplate>
                    </asp:ListView>

                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <h3>Intrested?</h3>
                        <p>View the Hundreds of Items Currently For Sale In Your Area</p>
                        <a class="btn btn-success" href="itemsForSale.aspx">View Items</a>
                    </div>

                </div>

            </div>

        </div>

    </div>
            
        </div>

          

    
    </form>
</body>
</html>
