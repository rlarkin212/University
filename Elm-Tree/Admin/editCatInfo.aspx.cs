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

public partial class Admin_editCatInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["adminUser"] == null)
        {
            Response.Redirect("adminLogIn.aspx");
        }

        if (!IsPostBack)
        {

            string row = Request.QueryString["catIdEdit"];

            string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;


            SqlConnection myConnection = new SqlConnection(connectionString);


            myConnection.Open();

            string query = "SELECT * FROM Categories WHERE Id=@rowid";

            SqlCommand myCommand = new SqlCommand(query, myConnection);

            myCommand.Parameters.AddWithValue("@rowid", row);
            SqlDataReader rdr = myCommand.ExecuteReader();


            while (rdr.Read())
            {

                string cat = rdr["Category"].ToString();
                catEdit.Text = cat;

            }


        }
    }
    protected void editBtn_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        int row = int.Parse(Request.QueryString["catIdEdit"]);
        string cat = catEdit.Text;

        string query = "UPDATE Categories SET Category=@cat WHERE Id=@id ";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id", row);
        myCommand.Parameters.AddWithValue("@cat", cat);

        myCommand.ExecuteNonQuery();
        myConnection.Close();

        Response.Redirect("catInfo.aspx");
    }
    protected void deleteBtn_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();

        int row = int.Parse(Request.QueryString["catIdEdit"]);
        string query = "DELETE FROM Categories WHERE Id=@id";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id", row);
        myCommand.ExecuteNonQuery();
        myConnection.Close();

        Response.Redirect("catInfo.aspx");
    }
}