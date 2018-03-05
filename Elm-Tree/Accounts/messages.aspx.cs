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

public partial class Accounts_messages : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../logIn.aspx");
        }
    }
   
    protected void replyBtn_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();


        int itemId = Convert.ToInt16(itemSrc.SelectedValue);
        string itemName = itemSrc.SelectedItem.Text;

        string message = messageBox.Text;

        int sellerId = Convert.ToInt16(Session["user"]);

        int buyerId = Convert.ToInt16(buyerSrc.SelectedValue);
        string buyerName = buyerSrc.SelectedItem.Text;

        DateTime datePosted = DateTime.Now;

        string query = "INSERT INTO messages (itemId,itemname,sellerId,buyerId,message,buyerName,datePosted) VALUES (@itemId,@itemName,@sellerId,@buyerId,@message,@buyerName,@datePosted)";
        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@itemId", itemId);
        myCommand.Parameters.AddWithValue("@itemName", itemName);
        myCommand.Parameters.AddWithValue("@sellerId", sellerId);
        myCommand.Parameters.AddWithValue("@buyerId", buyerId);
        myCommand.Parameters.AddWithValue("@message", message);
        myCommand.Parameters.AddWithValue("@buyerName", buyerName);
        myCommand.Parameters.AddWithValue("@datePosted", datePosted);

        myCommand.ExecuteNonQuery();
        myConnection.Close();

        messageBox.Text = "";

        Response.Redirect("messages.aspx");
        
    }
    
}