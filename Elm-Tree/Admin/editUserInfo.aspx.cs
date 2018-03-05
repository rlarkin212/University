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

public partial class Admin_editUserInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["adminUser"] == null)
        {
            Response.Redirect("adminLogIn.aspx");
        }

        if (!IsPostBack)
        {
            string row = Request.QueryString["userIdEdit"];
            //get the querystring data from you URL and store it in a variable
            //this will be used in the SQL select statement
            


            //set-up object to use the web.config file
            string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;

            //set-up connection object called 'myConnection'
            SqlConnection myConnection = new SqlConnection(connectionString);

            // open database communication
            myConnection.Open();

            //create the SQL statement
            string query = "SELECT * FROM users WHERE Id=@rowid";

            //set-up SQL command and use the SQL and myConnection object
            SqlCommand myCommand = new SqlCommand(query, myConnection);
            //create a parametrised object
            myCommand.Parameters.AddWithValue("@rowid", row);

            //create a sqldatareader object that asks for dats from a table
            SqlDataReader rdr = myCommand.ExecuteReader();


            //when in read mode ask for data
            while (rdr.Read())
            {
                //put field data from 'birdname' into variable
                string email = rdr["emailAddress"].ToString();
                //put variable value into textbox birdsnametext
                emailEdit.Text = email;

                string username = rdr["username"].ToString();
                usernameEdit.Text = username;

                string password = rdr["password"].ToString();
                passwordEdit.Text = password;


                string userType = rdr["userType"].ToString();
                userTypeEdit.SelectedValue = userType;

            }
        }

    }
    protected void editUserInfoBtn_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        int row = int.Parse(Request.QueryString["userIdEdit"]);
        string email = emailEdit.Text;
        string password = passwordEdit.Text;
        string username = usernameEdit.Text;
        int userType = Convert.ToInt16(userTypeEdit.SelectedValue);


        string query = "UPDATE users SET emailAddress=@email,username=@username,password=@password,userType=@userType WHERE Id=@id ";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id",row);
        myCommand.Parameters.AddWithValue("@email", email);
        myCommand.Parameters.AddWithValue("@username", username);
        myCommand.Parameters.AddWithValue("@password", password);
        myCommand.Parameters.AddWithValue("@userType", userType);
        
        myCommand.ExecuteNonQuery();
        myConnection.Close();

        Response.Redirect("userInfo.aspx");

    }
    protected void deleteBtn_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();

        int row = int.Parse(Request.QueryString["userIdEdit"]);
        string query = "DELETE FROM users WHERE Id=@id";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id", row);
        myCommand.ExecuteNonQuery();
        myConnection.Close();

        Response.Redirect("userInfo.aspx");
    }
}