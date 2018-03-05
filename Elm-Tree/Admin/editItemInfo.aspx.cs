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

public partial class Admin_editItemInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["adminUser"] == null)
        {
            Response.Redirect("adminLogIn.aspx");
        }

        if(!IsPostBack){
            
            string row = Request.QueryString["itemIdEdit"];

            string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;

          
            SqlConnection myConnection = new SqlConnection(connectionString);

            
            myConnection.Open();

            string query = "SELECT * FROM itemsForsale WHERE Id=@rowid";
            
            SqlCommand myCommand = new SqlCommand(query, myConnection);
 
            myCommand.Parameters.AddWithValue("@rowid", row);
            SqlDataReader rdr = myCommand.ExecuteReader();

             while (rdr.Read())
            {
                
                string name = rdr["Name"].ToString();
                nameEdit.Text = name;

                string description = rdr["Descrption"].ToString();
                 descriptionEdit.Text = description;

                 string price = rdr["Price"].ToString();
                 priceEdit.Text = price;

                 string spons = rdr["Sponsored"].ToString();
                 sponsEdit.Text = spons;

                 string cat = rdr["CategoryID"].ToString();
                 catEdit.Text = cat;

                 string vis = rdr["visability"].ToString();
                 visEdit.Text = vis;

            }
        }

    }

    
    protected void deleteBtn_Click(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();

        int row = int.Parse(Request.QueryString["itemIdEdit"]);
        string query = "DELETE FROM itemsForSale WHERE Id=@id";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id", row);
        myCommand.ExecuteNonQuery();
        myConnection.Close();

        Response.Redirect("itemInfo.aspx");

    }
    protected void editBtn_Click(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        int row = int.Parse(Request.QueryString["itemIdEdit"]);
        string name = nameEdit.Text;
        string description = descriptionEdit.Text;
        string price = priceEdit.Text;
        int spons = Convert.ToInt16(sponsEdit.SelectedValue);
        int cat = Convert.ToInt16(catEdit.SelectedValue);
        int vis = Convert.ToInt16(visEdit.SelectedValue);


        string query = "UPDATE itemsForSale SET Name=@name, Descrption=@description, Price=@price, Sponsored=@spons, CategoryID=@cat, visability=@vis WHERE Id=@id ";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id", row);
        myCommand.Parameters.AddWithValue("@name", name);
        myCommand.Parameters.AddWithValue("@description", description);
        myCommand.Parameters.AddWithValue("@price", price);
        myCommand.Parameters.AddWithValue("@spons", spons);
        myCommand.Parameters.AddWithValue("@cat", cat);
        myCommand.Parameters.AddWithValue("@vis", vis);

        myCommand.ExecuteNonQuery();
        myConnection.Close();

        Response.Redirect("itemInfo.aspx");






    }
}