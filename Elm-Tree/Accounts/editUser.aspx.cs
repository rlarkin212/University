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

public partial class Accounts_editUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../logIn.aspx");
        }

        // populate text boxes

        if (!IsPostBack)
        {
            int row = Convert.ToInt16(Session["user"]);
            string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;

            SqlConnection myConnection = new SqlConnection(connectionString);
            myConnection.Open();

            
            string query = "SELECT * FROM users WHERE Id=@rowid";
            SqlCommand myCommand = new SqlCommand(query, myConnection);
            
            myCommand.Parameters.AddWithValue("@rowid", row);

            
            SqlDataReader rdr = myCommand.ExecuteReader();

            while (rdr.Read())
            {
                string email = rdr["emailAddress"].ToString();
                emailEdit.Text = email;

                string username = rdr["username"].ToString();
                usernameEdit.Text = username;

                string password = rdr["password"].ToString();
                passwordEdit.Text = password;

                string address = rdr["address"].ToString();
                addressEdit.Text = address;

                string postcode = rdr["postcode"].ToString();
                postcodeEdit.Text = postcode;

                string phoneNumber = rdr["phoneNumber"].ToString();
                phoneEdit.Text = phoneNumber;

                string userType = rdr["usertype"].ToString();
                userTypeEdit.Text = userType;

                string uni = rdr["uniId"].ToString();
                uniEdit.Text = uni;

            }
        } 

    }

    protected void editUserInfoBtn_Click(object sender, EventArgs e)
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
            int imgSize = profileImageEdit.PostedFile.ContentLength;
            string imgName = profileImageEdit.FileName;
            string imgPath = "~/files/" + rInt + imgName;

            if (profileImageEdit.PostedFile.ContentLength > 1500000)
            {
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big.')", true);
            }
            else
            {
                //then save it to the Folder
                profileImageEdit.SaveAs(Server.MapPath(imgPath));
                
            }
        }





        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        int row = Convert.ToInt16(Session["user"]);
        string emailAddress = emailEdit.Text;
        string username = usernameEdit.Text;
        string password = passwordEdit.Text;
        string address = addressEdit.Text;
        string profilePic = rInt + profileImageEdit.FileName;
        string postcode = postcodeEdit.Text;
        string phoneNumber = phoneEdit.Text;
        int userType = Convert.ToInt16(userTypeEdit.SelectedValue);
        int uni = Convert.ToInt16(uniEdit.SelectedValue);

        if (profileImageEdit.HasFile)
        {
            string query = "Update users SET emailAddress=@emailAddress, username=@username, password=@password,address=@address,postcode=@postcode,userType=@usertype,phoneNumber=@phoneNumber,profilePic=@profilepic,uniId=@uni WHERE Id=@id";

            SqlCommand myCommand = new SqlCommand(query, myConnection);

            myCommand.Parameters.AddWithValue("@id", row);
            myCommand.Parameters.AddWithValue("@emailAddress", emailAddress);
            myCommand.Parameters.AddWithValue("@username", username);
            myCommand.Parameters.AddWithValue("@password", password);
            myCommand.Parameters.AddWithValue("@address",address);
            myCommand.Parameters.AddWithValue("@postcode", postcode);
            myCommand.Parameters.AddWithValue("@userType", userType);
            myCommand.Parameters.AddWithValue("@phoneNumber",phoneNumber);
            myCommand.Parameters.AddWithValue("@profilePic", profilePic);
            myCommand.Parameters.AddWithValue("@uni", uni);
           

            myCommand.ExecuteNonQuery();
            myConnection.Close();
            Response.Redirect("Default.aspx");

        }
        else
        {
            string queryNP = "Update users SET emailAddress=@emailAddress, username=@username, password=@password,address=@address,postcode=@postcode,userType=@usertype,phoneNumber=@phoneNumber,uniId=@uni WHERE Id=@id";

            SqlCommand myCommandNP = new SqlCommand(queryNP, myConnection);

            myCommandNP.Parameters.AddWithValue("@id", row);
            myCommandNP.Parameters.AddWithValue("@emailAddress", emailAddress);
            myCommandNP.Parameters.AddWithValue("@username", username);
            myCommandNP.Parameters.AddWithValue("@password", password);
            myCommandNP.Parameters.AddWithValue("@address", address);
            myCommandNP.Parameters.AddWithValue("@postcode", postcode);
            myCommandNP.Parameters.AddWithValue("@userType", userType);
            myCommandNP.Parameters.AddWithValue("@phoneNumber", phoneNumber);
            myCommandNP.Parameters.AddWithValue("@profilePic", profilePic);
            myCommandNP.Parameters.AddWithValue("@uni", uni);


            myCommandNP.ExecuteNonQuery();
            myConnection.Close();
            Response.Redirect("Default.aspx");

        }



}

    protected void deleteuserBtn_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();

        int row = Convert.ToInt16(Session["user"]);
        string query = "DELETE FROM users WHERE Id=@id";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id", row);
        myCommand.ExecuteNonQuery();
        myConnection.Close();

        Response.Redirect("../Default.aspx");
    }
}