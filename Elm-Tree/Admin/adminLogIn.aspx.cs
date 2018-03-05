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


public partial class Admin_adminLogIn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void signInBtn_Click(object sender, EventArgs e)
    {
        string user = adminUsername.Text;
        string password = adminPassword.Text;

        string connectionString = WebConfigurationManager.ConnectionStrings["elmTreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        string query = "SELECT  * FROM adminUsers WHERE username=@theuser AND password=@thepassword";
        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@theuser", user);
        myCommand.Parameters.AddWithValue("@thePassword", password);

        SqlDataReader rdr = myCommand.ExecuteReader();

        if (rdr.HasRows)
        {
            while (rdr.Read())
            {
                string myName = rdr["Id"].ToString();

                Session["adminUser"] = myName;
                Response.Redirect("Default.aspx");
            }
        }


    }
}