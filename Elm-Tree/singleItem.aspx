<%@ Page Language="C#" AutoEventWireup="true" CodeFile="singleItem.aspx.cs" Inherits="singleItem" %>

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
       <div class="jumbotron">
            
           <asp:SqlDataSource ID="singleItemSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [Name],[Descrption], [Price], [ImagePath], [UserID] FROM [itemsForSale] WHERE ([Id] = @Id)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="itemId" Name="Id" Type="Int32"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>

           
            
            <!-- Content -->
            <div class="container">
                
                 <asp:ListView ID="item" runat="server" DataSourceID="singleItemSrc">
                    <ItemTemplate>
                        <h1 class="page-header" style="text-align:center"><asp:Label ID="Label2" runat="server" Text='<%# Eval("Name")%>' /> </h1>

                         <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                             
                         <asp:Image ID="itemPic" runat="server" CssClass="img-thumbnail" ImageURL='<%# "../files/"+Eval("ImagePath") %>' width="600px" /><br />
                         
                       <h3>£  <asp:Label ID="itemPrice" runat="server" Text='<%# Eval("Price")%>' /></h3><br> </div>

                        <blockquote><asp:Label ID="Label1" runat="server" Text='<%# Eval("Descrption") %>'/></blockquote>
                        
                    </ItemTemplate>
                </asp:ListView>
                
                

                   
                <div class="col-sm-7">
                    <br />
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <strong>Contact User</strong>
                            </div>
                            
                            <div class="panel-body">
                                <asp:TextBox ID="commentBox" CssClass="form-control"  runat="server" TextMode="MultiLine" PlaceHolder="Ask The Seller a Question"></asp:TextBox>
                                
                                <br /><div class="pull-right">
                                <asp:Button CssClass="btn btn-success btn-lg" ID="sendCommentBtn" role="button" runat="server" Text="Send" OnClick="sendCommentBtn_Click"/></div>

                            </div><!-- /panel-body -->
                        </div><!-- /panel panel-default -->
                    </div><!-- /col-sm-5 -->

                <asp:TextBox ID="sellerIdhid" runat="server" CssClass="hidden"></asp:TextBox>
                <asp:TextBox ID="itemNamehid" runat="server" CssClass="hidden"></asp:TextBox>
                <asp:TextBox ID="buyernamehid" runat="server" CssClass="hidden"></asp:TextBox>
                <asp:TextBox ID="sellerNameHid" runat="server" CssClass="hidden"></asp:TextBox>
                <asp:TextBox ID="viewsHidden" runat="server" CssClass="hidden"></asp:TextBox>


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
