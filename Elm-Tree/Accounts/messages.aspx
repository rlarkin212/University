<%@ Page Language="C#" AutoEventWireup="true" CodeFile="messages.aspx.cs" Inherits="Accounts_messages" %>

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
                <h1 class="page-header">Messages</h1>
                </div>

                <asp:SqlDataSource ID="messageSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT * FROM [messages] WHERE (([sellerId] = @sellerId) OR ([buyerId] = @buyerId)) ORDER BY [datePosted] DESC, [itemName]">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="user" Name="sellerId" Type="Int32"></asp:SessionParameter>
                        <asp:SessionParameter SessionField="user" Name="buyerId" Type="Int32"></asp:SessionParameter>
                    </SelectParameters>
                            </asp:SqlDataSource>

                <asp:SqlDataSource ID="usernameSrc" runat="server" ConnectionString='<%$ ConnectionStrings:elmTreeConnection %>' SelectCommand="SELECT [Id],[username] FROM [users] WHERE ([Id] = @Id)">
                    <SelectParameters>
                        <asp:SessionParameter SessionField="user" Name="Id" Type="Int32"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>



                <asp:ListView ID="messageListView" runat="server" DataSourceID="messageSrc">
                    
                    <EmptyItemTemplate>
                        <span>No Messages Found</span>
                    </EmptyItemTemplate>
                    
                    <ItemTemplate>
               
                <div class="col-lg-7">
                        <div class="panel panel-default">
                           <div class="panel-heading">
                                Buyer Name : <strong><asp:Label ID="buyerName" runat="server" Text='<%# Eval("buyerName") %>' /></strong><br/>
                               Seller ID : <strong><asp:Label ID="sellerID" runat="server" Text='<%# Eval("sellerId") %>' /></strong><br/>

                               <asp:ListView ID="userNameListView" runat="server" DataSourceID="usernameSrc">
                                   <ItemTemplate>
                                       <asp:HyperLink ID="sellerProfileLink" runat="server" NavigateUrl='<%# "sellerInfo.aspx?sellerId=" + Eval("Id") %>' >
                                       Seller Name : <strong><asp:Label ID="sellerName" runat="server" Text='<%# Eval("username") %>' /></strong><br/>
                                       </asp:HyperLink>
                                   </ItemTemplate>
                               </asp:ListView>

                               <asp:HyperLink ID="singleItemLink" runat="server" NavigateUrl='<%# "../singleItem.aspx?itemId=" + Eval("itemID") %>'>
                               Item Name: <strong><asp:Label ID="itemName" runat="server" Text='<%# Eval("itemName") %>' /></strong><br /></asp:HyperLink>
                               Sent Date: <strong><asp:Label ID="postedDate" runat="server" Text='<%# Eval("datePosted") %>' /></strong>
                                </div>
                            <div class="panel-body">
                                <strong>Message: </strong><asp:Label ID= "message" runat="server" Text='<%# Eval("message") %>' CssClass="border" />
                                
                            
                            </div><!-- /panel-body -->
                        </div><!-- /panel panel-default -->
                    </div><!-- /col-sm-5 -->

                        </ItemTemplate>
                        </asp:ListView>


                


                <div class="col-lg-7">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <asp:DropDownList ID="buyerSrc" runat="server" DataSourceID="messageSrc" DataTextField="buyerName" DataValueField="buyerId"></asp:DropDownList>
                                <asp:DropDownList ID="itemSrc" runat="server" DataSourceID="messageSrc" DataTextField="itemName" DataValueField="itemId"></asp:DropDownList>
                            </div>
                            <div class="panel-body">
                                <asp:TextBox ID="messageBox" runat="server" Placeholder="Reply?" TextMode="MultiLine" CssClass="form-control" ></asp:TextBox><br />
                                <div class="pull-right">
                                    <asp:Button ID="replyBtn" runat="server" Text="reply" CssClass="btn btn-success btn-lg" OnClick="replyBtn_Click" /></div>
                            </div><!-- /panel-body -->
                        </div><!-- /panel panel-default -->
                    </div><!-- /col-sm-5 -->




            </div>
        </div>


    </form>
</body>
</html>
