using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class singleItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();

        int itemId = Convert.ToInt16(Request.QueryString["itemId"]);
        int buyerId = Convert.ToInt16(Session["user"]);

        //seller id
        string querySellerId = "SELECT userId From itemsForSale WHERE Id=@itemId";
        SqlCommand myCommandSellerId = new SqlCommand(querySellerId, myConnection);
        myCommandSellerId.Parameters.AddWithValue("@itemId", itemId);
        SqlDataReader sellerIdRdr = myCommandSellerId.ExecuteReader();

        int sellerId;

        while (sellerIdRdr.Read())
        {
            sellerId = Convert.ToInt16(sellerIdRdr["UserID"].ToString());
            sellerIdhid.Text = sellerId.ToString();
        }
        sellerIdRdr.Close();

        //item name
        string queryItemname = "SELECT Name From itemsForSale WHERE Id=@itemId";
        SqlCommand myCommandItemName = new SqlCommand(queryItemname, myConnection);
        myCommandItemName.Parameters.AddWithValue("@itemId", itemId);
        SqlDataReader itemNameRdr = myCommandItemName.ExecuteReader();

        string itemName = "";

        while (itemNameRdr.Read())
        {
            itemName = itemNameRdr["Name"].ToString();
            itemNamehid.Text = itemName;
        }
        itemNameRdr.Close();

         //buyer name
        string queryBuyerName = "SELECT username From users WHERE Id=@buyerId";
        SqlCommand myCommandbuyerName = new SqlCommand(queryBuyerName, myConnection);
        myCommandbuyerName.Parameters.AddWithValue("@buyerId", buyerId);
        SqlDataReader buyerNameRdr = myCommandbuyerName.ExecuteReader();

        string buyerName = "";

        while (buyerNameRdr.Read())
        {
            buyerName = buyerNameRdr["username"].ToString();
            buyernamehid.Text = buyerName;
        }
        buyerNameRdr.Close();

        //view increment
        string queryViews = "SELECT Views From itemsForSale WHERE Id=@itemId";
        SqlCommand myCommandViews = new SqlCommand(queryViews, myConnection);
        myCommandViews.Parameters.AddWithValue("@itemId", itemId);
        SqlDataReader viewsRdr = myCommandViews.ExecuteReader();

        string views;

        while (viewsRdr.Read())
        {
            views = viewsRdr["Views"].ToString();
            viewsHidden.Text = views;
        }
        viewsRdr.Close();

        int i = 1;
        int currentViews = Convert.ToInt16(viewsHidden.Text);
        int updatedViews = currentViews + i;

        string updateViews = "UPDATE itemsForSale SET views=@views WHERE id=@id";

        SqlCommand myCommand = new SqlCommand(updateViews, myConnection);

        myCommand.Parameters.AddWithValue("@id", itemId);
        myCommand.Parameters.AddWithValue("@views", updatedViews);

        myCommand.ExecuteNonQuery();







        

    }
    protected void itemSearchButton_Click(object sender, EventArgs e)
    {

        string searchText = itemSearchBox.Text;
        Response.Redirect("searchItem.aspx?searchQuery=" + searchText);
    }

    protected void sendCommentBtn_Click(object sender, EventArgs e)
    {

        if (Session["user"] == null)
        {
            Response.Redirect("logIn.aspx");
        }

        
        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();

        int itemId = Convert.ToInt16(Request.QueryString["itemId"]);
        string itemName = itemNamehid.Text;
        int sellerId = Convert.ToInt16(sellerIdhid.Text);
        int buyerId = Convert.ToInt16(Session["user"]);
        string message = commentBox.Text;
        string buyerName = buyernamehid.Text;
        
        if(sellerId == buyerId){
            Response.Write("<script>alert('You Can Not Message About Your Own Item');</script>");
            commentBox.Text = "";
        }
        else
        {

      
        string query = "INSERT INTO messages (itemId,itemName,sellerId,buyerId, message,buyerName) VALUES (@itemId,@itemName,@sellerId,@buyerId,@message,@buyername)";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@itemId", itemId);
        myCommand.Parameters.AddWithValue("@itemName", itemName);
        myCommand.Parameters.AddWithValue("@sellerID", sellerId);
        myCommand.Parameters.AddWithValue("@buyerId", buyerId);
        myCommand.Parameters.AddWithValue("@message",message);
        myCommand.Parameters.AddWithValue("@buyerName", buyerName);
        
        

        myCommand.ExecuteNonQuery();
        commentBox.Text = "";
        myConnection.Close();
        }
        
    }
}