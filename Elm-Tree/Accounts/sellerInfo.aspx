<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sellerInfo.aspx.cs" Inherits="sellerInfo" %>

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
         <a class="navbar-brand" href="../Default.aspx">ElmTree Buy & Sell</a>
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


        <asp:SqlDataSource ID="sellerInfoSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id], [emailaddress],[userName], [address], [phoneNumber], [profilePic] FROM [users] WHERE ([Id] = @Id)">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="sellerId" Name="Id" Type="Int16"></asp:QueryStringParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        


        <div class="jumbotron">
            <div class="container">


                 <div class="col-lg-12">
                <h1 class="page-header">Seller Profile</h1>
                </div>

                <asp:ListView ID="sellerInfoListView" runat="server" DataSourceID="sellerInfoSrc">
                    <ItemTemplate>
    <div class="container">
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-6">
            <div class="well well-lg">
                <div class="row">
                    <div class="col-sm-6 col-md-4">
                        <asp:Image ID="profilePic" runat="server" CssClass="img-rounded img-responsive" ImageURL='<%# ".../../files/"+Eval("profilePic") %>'/>
                    </div>
                    <div class="col-sm-6 col-md-8">
                        <h4><asp:Label ID="sellerName" runat="server" Text='<%# Eval("userName")%>'/></h4>
                        
                        <p>
                            <i class="glyphicon glyphicon-envelope"></i><asp:Label ID="sellerEmail" runat="server" Text='<%# Eval("emailAddress")%>'/>
                            <br />
                            <i class="glyphicon glyphicon-home"></i><asp:Label ID="address" runat="server" Text='<%# Eval("address")%>'/>
                            <br />
                            <i class="glyphicon glyphicon-earphone"></i><asp:Label ID="phoneNumber" runat="server" Text='<%# Eval("phoneNUmber")%>'/>

                        </p>
                    </div>
                </div>
            </div>
        </div>


            </div>
        </div>
                    </ItemTemplate>
                </asp:ListView>



</div>
            </div>





    </form>
</body>
</html>
