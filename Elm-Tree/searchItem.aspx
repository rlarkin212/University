<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchItem.aspx.cs" Inherits="searchItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Elm Tree Buy & Sell</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
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
                    <li><a href="itemsForSale.aspx"><span class="glyphicon glyphicon-tags"></span> Items For Sale</a></li>
                   <li><a href="Accounts/Default.aspx"><span class="glyphicon glyphicon-user"></span> My Account</a></li>
                   <li><a href="logIn.aspx"><span class="glyphicon glyphicon-log-in"></span> Login / Sign Up</a></li> 
                </ul>
                 <a href="Accounts/uploadItemForm.aspx" role="button" class="btn btn-success btn-lg"><span class="glyphicon glyphicon-pushpin"></span>Post An Ad</a>
              
          </div>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
    <!-- Nav End  -->
         <!-- item Search Bar  -->
    <nav role="navigation" class="navbar navbar-default">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="itemsForSale.aspx">Item Categories</a>

    </div>
    <!-- Collection of nav links and other content for toggling -->
    <div id="navbarCollapse" class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
           <asp:SqlDataSource ID="categorySrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [Category] FROM [Categories]">
                        </asp:SqlDataSource>
            <asp:ListView ID="ListView1" runat="server" DataSourceID="categorySrc">
                <ItemTemplate>
                    <li><asp:HyperLink ID="categoryLink" runat="server" NavigateUrl='<%# "category.aspx?catId=" + Eval("Id") %>' Text='<%# Eval("Category") %>'></asp:HyperLink></li>
                </ItemTemplate>
            </asp:ListView>
        </ul>
      <div class="col-sm-3 col-md-3 col-lg-5 pull-right">
     <div class="navbar-form pull-right" role="search">
         <div class="input-group">
             <asp:TextBox ID="itemSearchBox" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
             <div class="input-group-btn">
                 <asp:LinkButton ID="itemSearchButton" OnClick="itemSearchButton_Click" runat="server" CssClass="btn btn-success" ><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
</div>
                
    </div>
</nav>
         <!-- item search bar End  -->
         
        <asp:SqlDataSource ID="itemSearchSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id],[Name], [Price], [ImagePath] FROM [itemsForSale] WHERE ([Name] LIKE '%' + @Name + '%')">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="searchQuery" Name="Name" Type="String"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <div class="jumbotron">
            <div class="container">


                
                <div class="col-lg-12">
                <h1 class="page-header">Search Results For : <asp:Label ID="searchText" runat="server" Text=""></asp:Label></h1>
                </div>
                
                <div class="row">
                    
                    <asp:ListView ID="itemSearch" runat="server" DataSourceID="itemSearchSrc" DataKeyNames="Name">
                        <ItemTemplate>
                             
                            <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                                <asp:HyperLink ID="singleItemLink" runat="server" NavigateUrl='<%# "singleItem.aspx?itemId=" + Eval("Id") %>'>
                                
                                    <asp:Image ID="itemPic" runat="server" CssClass="img-thumbnail" ImageURL='<%# "../files/"+Eval("ImagePath") %>' width="400px" /><br />
                                <asp:Label ID="itemName" runat="server" Text='<%# Eval("Name") %>' /><br />
                                £  <asp:Label ID="itemPrice" runat="server" Text='<%# Eval("Price") %>' /><br />

                                </asp:HyperLink>  
                             </div>
                        </ItemTemplate>
                    </asp:ListView>
           
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
