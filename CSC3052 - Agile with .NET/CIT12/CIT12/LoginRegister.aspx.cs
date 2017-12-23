using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using System.Data.SqlClient;
using System.Collections;
using System.IO;

namespace CIT12
{
    public partial class LoginRegister : System.Web.UI.Page
    {
        //Session["s_registeredUserId"] if created in the  register onclick after the sql statement cmdInsertUser is execuated
        //Session["s_loggedUserId"] stores the id of the logged in user,  created in the login onclick after the data reader is execuated



        //sets panel visibility to false
        protected void hidePanels()
        {
            pnlLogin.Visible = false;
            pnlRegister.Visible = false;
            pnlRegisterUserDetails.Visible = false;
            pnlRegisterUserRoles.Visible = false;
            pnlSuccessAlert.Visible = false;
            pnlUserRolesSuccessAlert.Visible = false;

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //hides all panels on load and shows the login panel 
            hidePanels();
            pnlLogin.Visible = true;
            SetFocus(txtLoginEmailUsername);

        }

        //takes in plain text password as param and encrypts using md5 hash
        public string Encryption(String password)
        {
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] encrypt;
            UTF8Encoding encode = new UTF8Encoding();
            //encrypt the given password string into Encrypted data  
            encrypt = md5.ComputeHash(encode.GetBytes(password));
            StringBuilder encryptdata = new StringBuilder();
            //create a new string by using the encrypted data  
            for (int i = 0; i < encrypt.Length; i++)
            {
                encryptdata.Append(encrypt[i].ToString());
            }
            return encryptdata.ToString();
        }


        //hides the log in panel and brings up the register panel 
        protected void btnDontHaveAnAccount_Click(object sender, EventArgs e)
        {
            hidePanels();
            pnlRegister.Visible = true;
            pnlRegisterUserDetails.Visible = true;
        }


        //login button calls encryption() on typed password and checks email and password against the database entry, then redriects to default.aspx 
        protected void btnLogin_Click(object sender, EventArgs e)
        {

            string loginEmailUsername = Convert.ToString(txtLoginEmailUsername.Text);
            string loginPlainPassword = Convert.ToString(txtLoginPassword.Text);

            //passes loginPlainPassword to Encryption to allow it to be compoared to the db value 
            string loginEncryptedPassword = Encryption(loginPlainPassword);


            string sqlSelectCompareDetails = "SELECT Email, Password FROM tbl_User WHERE (Email = '" + loginEmailUsername + "') AND (Password = '" + loginEncryptedPassword + "')";
            SqlCommand cmdCompareDetails = new SqlCommand(sqlSelectCompareDetails, Connections.ApplicationConnection());
            SqlDataReader sqldr = cmdCompareDetails.ExecuteReader();

            if (sqldr.Read())
            {
                //gets the id of the user being logged in and stores it in Session["s_loggedUserId"] so that it can be checked in the master page 
                String sqlGetUserId = "SELECT Id FROM tbl_User WHERE (Email = '" + loginEmailUsername + "')";

                using (var cnn = Connections.ApplicationConnection())
                {
                    using (var cmdGetId = new SqlCommand(sqlGetUserId, cnn))
                    {
                        Session["s_loggedUserId"] = Convert.ToInt32(cmdGetId.ExecuteScalar());
                        Debug.WriteLine("USER ID : " + Session["s_loggedUserId"]);
                    }
                }

                //if details are correct, redirect to Home page 
                Response.Redirect("Home.aspx");


            }
            else
            {
                lblLoginErrorText.Text = "The Email / Username Or Password You Have Entered Is Incorrect !";
            }

        }


        //register btn on click method calls encryption method on enterred password, verifys password and posts to tbl_User
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string registerForename = Convert.ToString(txtRegisterForename.Text);
            string registerSurname = Convert.ToString(txtRegisterSurname.Text);
            string registerEmailUsername = Convert.ToString(txtRegisterEmailUsername.Text);
            string registerPlainPassword = Convert.ToString(txtRegisterPassword.Text);

            //encrypt the plain password
            string encryptedPassword = Encryption(registerPlainPassword);
            Debug.WriteLine("Plain Text Password : " + txtRegisterPassword.Text + " Encrypted Password : " + encryptedPassword);
            //check if username and password is empty
            if (registerEmailUsername.Length > 0 && registerPlainPassword.Length > 0)
            {
                //check if username already exists
                String sqlUsernameSearch = "SELECT * FROM tbl_User WHERE (Email = '" + registerEmailUsername + "')";
                SqlCommand cmd = new SqlCommand(sqlUsernameSearch, Connections.ApplicationConnection());
                SqlDataReader sqldr = cmd.ExecuteReader();

                if (sqldr.Read())
                {
                    String passed = (string)sqldr["Password"];
                    lblRegisterErrorText.Text = "Email / Username Is Already in Use";
                }
                else
                {
                    // if the Username not found create the new user account  
                    try
                    {
                        //verifys password
                        if (txtRegisterPassword.Text.Equals(txtRegisterVerifyPassword.Text))
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
                                int imgSize = fuProfilePic.PostedFile.ContentLength;
                                string imgName = fuProfilePic.FileName;
                                string imgPath = "~/files/" + rInt + imgName;

                                if (fuProfilePic.PostedFile.ContentLength > 1500000)
                                {
                                    Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big.')", true);
                                }
                                else
                                {
                                    //then save it to the Folder
                                    fuProfilePic.SaveAs(Server.MapPath(imgPath));
                                    
                                }


                            }

                            // inserts record into tbl_user
                            string sqlInsertUser = "INSERT INTO tbl_user (Forename, Surname, Email, Password, ProfilePic) VALUES (@forename, @surname, @email, @password, @profilePic)";
                            SqlCommand cmdInsertUser = new SqlCommand(sqlInsertUser, Connections.ApplicationConnection());

                            cmdInsertUser.Parameters.AddWithValue("@forename", registerForename);
                            cmdInsertUser.Parameters.AddWithValue("@surname", registerSurname);
                            cmdInsertUser.Parameters.AddWithValue("@email", registerEmailUsername);
                            cmdInsertUser.Parameters.AddWithValue("@password", encryptedPassword);
                            cmdInsertUser.Parameters.AddWithValue("@profilePic", rInt + fuProfilePic.FileName);

                            cmdInsertUser.ExecuteNonQuery();


                            pnlSuccessAlert.Visible = true;


                            //grabs id of registered user for user role method and stores in a session 
                            String sqlGetUserId = "SELECT Id FROM tbl_User WHERE (Email = '" + registerEmailUsername + "')";
                            using (var cnn = Connections.ApplicationConnection())
                            {
                                using (var cmdGetId = new SqlCommand(sqlGetUserId, cnn))
                                {
                                    Session["s_registeredUserId"] = Convert.ToInt32(cmdGetId.ExecuteScalar());
                                    Debug.WriteLine("USER ID : " + Session["s_registeredUserId"]);
                                }
                            }


                            txtRegisterForename.Text = "";
                            txtRegisterSurname.Text = "";
                            txtRegisterEmailUsername.Text = "";
                            txtRegisterPassword.Text = "";
                            txtRegisterVerifyPassword.Text = "";

                            lblRegisterErrorText.Text = "";

                            //hide panels and then opens the register user details one 
                            hidePanels();
                            pnlRegister.Visible = true;
                            pnlRegisterUserRoles.Visible = true;
                        }
                        else
                        {
                            lblRegisterErrorText.Text = "Passwords Do Not Match";
                        }


                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.ToString());
                    }
                }
            }
        }

        //takes in the id of the previously registered user and adds role to an array list , which is then insterted into tbl_UserRoles
        protected void btnRegisterUserRoles_Click(object sender, EventArgs e)
        {

            ArrayList userRoleCodes = new ArrayList();
            userRoleCodes.Add(10);

            if (cbProductOwner.Checked == true)
            {
                userRoleCodes.Add(20);
            }

            if (cbScrumMaster.Checked == true)
            {
                userRoleCodes.Add(30);
            }

            if (cbDeveloper.Checked == true)
            {
                userRoleCodes.Add(40);
            }

            foreach (var roleCode in userRoleCodes)
            {

                Debug.WriteLine("USER ID  : " + Session["s_registeredUserId"]);
                Debug.WriteLine("ROLE CODE : " + roleCode);


                string sqlInsertUserRoles = "INSERT INTO tbl_UserRoles (UserId, UserRoleCode) VALUES (@userId, @userRoleCode)";
                SqlCommand cmdInsertUser = new SqlCommand(sqlInsertUserRoles, Connections.ApplicationConnection());

                cmdInsertUser.Parameters.AddWithValue("@userId", Session["s_registeredUserId"]);
                cmdInsertUser.Parameters.AddWithValue("@userRoleCode", roleCode);

                cmdInsertUser.ExecuteNonQuery();
                pnlUserRolesSuccessAlert.Visible = true;

                cbProductOwner.Checked = false;
                cbScrumMaster.Checked = false;
                cbDeveloper.Checked = false;


                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Account Successfully Created And Roles Added')", true);


                //reloads page to access the login panel 
                hidePanels();
                pnlLogin.Visible = true;

            }

            //inserts description into tbl_user
            String sqlInsertDescription = "UPDATE tbl_User SET Description = @description WHERE Id = @id";
            SqlCommand cmdInsertDescription = new SqlCommand(sqlInsertDescription, Connections.ApplicationConnection());

            cmdInsertDescription.Parameters.AddWithValue("@description", txtDescription.Text);
            cmdInsertDescription.Parameters.AddWithValue("@id", Session["s_registeredUserId"]);
            cmdInsertDescription.ExecuteNonQuery();


        }


    }
}