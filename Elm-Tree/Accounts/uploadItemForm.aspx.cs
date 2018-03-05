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

public partial class Accounts_uploadItemForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../logIn.aspx");
        }
    }
    protected void signUpButton_Click(object sender, EventArgs e)
    {

        string UpPath = Server.MapPath("~/files");

        Random r = new Random();
        int rInt = r.Next(0, 10000);

        if (!Directory.Exists(UpPath))
        {
            Directory.CreateDirectory(UpPath);
          
        }
        else
        {
            int imgSize = itemImage.PostedFile.ContentLength;
            string imgName = itemImage.FileName;
            string imgPath = "~/files/" + rInt + imgName;

            if (itemImage.PostedFile.ContentLength > 1500000)
            {
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big.')", true);
            }
            else
            {
                //then save it to the Folder
                itemImage.SaveAs(Server.MapPath(imgPath));
                // myinfo.Text = "file " + imgPath + " uploaded";
            }

            
        }

        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        
        string name = itemName.Text;
        string description = itemDescription.Text;
        DateTime postedDate = DateTime.Now;
        decimal price = Convert.ToDecimal(itemPrice.Text);
        string image = rInt + itemImage.FileName;
        int userId = Convert.ToInt16(Session["user"]);
        int sponsored = Convert.ToInt16(itemSpons.SelectedValue);
        int category = Convert.ToInt16(itemCategory.SelectedValue);
        int vis = Convert.ToInt16(itemVis.SelectedValue);
        int views = 0;

        string query = "INSERT INTO itemsForSale (Name,Descrption,PostedDate,Price,ImagePath,UserId,Sponsored,CategoryID,visability,Views) VALUES (@name,@description,@postedDate,@price,@image,@userId,@sponsored,@category,@vis,@views)";

        SqlCommand myCommand = new SqlCommand(query, myConnection);


        myCommand.Parameters.AddWithValue("@name", name);
        myCommand.Parameters.AddWithValue("@description", description);
        myCommand.Parameters.AddWithValue("@postedDate", postedDate);
        myCommand.Parameters.AddWithValue("@price", price);
        myCommand.Parameters.AddWithValue("@image", image);
        myCommand.Parameters.AddWithValue("@userId", userId);
        myCommand.Parameters.AddWithValue("@sponsored", sponsored);
        myCommand.Parameters.AddWithValue("@category", category);
        myCommand.Parameters.AddWithValue("@vis", vis);
        myCommand.Parameters.AddWithValue("@views", views);

        myCommand.ExecuteNonQuery();
       
        myConnection.Close();

        Response.Redirect("../itemsForSale.aspx");


    }
}