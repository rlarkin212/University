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


public partial class logIn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void signUpButton_Click(object sender, EventArgs e)
    {
        string UpPath = Server.MapPath("~/files");

        Random r = new Random();
        int rInt = r.Next(0, 10000);

        if (!Directory.Exists(UpPath))
        {
            Directory.CreateDirectory(UpPath);
            myinfo.Text = UpPath + " folder files does not exist";
        }
        else
        {
            int imgSize = profileImage.PostedFile.ContentLength;
            string imgName = profileImage.FileName;
            string imgPath = "~/files/" + rInt + imgName;

            if (profileImage.PostedFile.ContentLength > 1500000)
            {
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big.')", true);
            }
            else
            {
                //then save it to the Folder
                profileImage.SaveAs(Server.MapPath(imgPath));
                // myinfo.Text = "file " + imgPath + " uploaded";
            }

            myinfo.Text = "file " + imgPath + " uploaded";
        }

        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        string emailSignUp = signUpEmail.Text;
        string passwordSignUp = signUpPassword.Text;
        string usernameSignUp = signUpUsername.Text;
        string imageProfile = rInt + profileImage.FileName;
        string addressSignUp = signUpAddress.Text;
        string postcodeSignUp = signUpPostcode.Text;
        string phoneNumberSignUp = signUpPhoneNumber.Text;
        int userTypeSignUp = Convert.ToInt16(signUpUserType.SelectedValue);
        int uni = Convert.ToInt16(uniList.SelectedValue);

        string query = "INSERT INTO users (emailAddress,username,password,address,postcode,userType,phoneNumber,profilePic,uniId) VALUES (@email,@username,@password,@address,@postcode,@userType,@phoneNumber,@profilePic,@uniId)";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        

        myCommand.Parameters.AddWithValue("@email",emailSignUp);
        myCommand.Parameters.AddWithValue("@username", usernameSignUp);
        myCommand.Parameters.AddWithValue("@password", passwordSignUp);
        myCommand.Parameters.AddWithValue("@address", addressSignUp);
        myCommand.Parameters.AddWithValue("@postcode", postcodeSignUp);
        myCommand.Parameters.AddWithValue("@userType",userTypeSignUp);
        myCommand.Parameters.AddWithValue("@phoneNumber", phoneNumberSignUp);
        myCommand.Parameters.AddWithValue("@profilePic", imageProfile);
        myCommand.Parameters.AddWithValue("@uniId",uni);

        myCommand.ExecuteNonQuery();
        myinfo.Text = "Account Successfully Created";

        myConnection.Close();

        signUpEmail.Text = "";
        signUpPassword.Text = "";
        signUpUsername.Text = "";
        signUpAddress.Text = "";
        signUpPostcode.Text = "";
        signUpPhoneNumber.Text = "";


    }


    protected void signInBtn_Click(object sender, EventArgs e)
    {
        string user = signInEmail.Text;
        string password = signInPassword.Text;

        string connectionString = WebConfigurationManager.ConnectionStrings["elmTreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        string query = "SELECT  * FROM users WHERE emailAddress=@theuser AND password=@thepassword";
        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@theuser", user);
        myCommand.Parameters.AddWithValue("@thePassword", password);

        SqlDataReader rdr = myCommand.ExecuteReader();

        if (rdr.HasRows)
        {
            while (rdr.Read())
            {
                string myName = rdr["Id"].ToString();

                Session["user"] = myName;
                Response.Redirect("Accounts/Default.aspx");
            }
        }

        
        
    }
}