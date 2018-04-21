using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class Login : System.Web.UI.Page
    {
        //Session["s_loggedNumber"] stores number for logged user 
        //Session["s_loggedUserId"] stores the id of the logged in user
        //Session["s_loggedUserRole"] stores the role of the logged in user


        protected void Page_Load(object sender, EventArgs e)
        {
            this.Page.Form.DefaultButton = btnLogin.UniqueID;
            this.Page.Form.DefaultFocus = txtLoginNumber.ClientID;

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            Int32 loginNumber = Convert.ToInt32(txtLoginNumber.Text);
            string loginPlainPassword = Convert.ToString(txtLoginPassword.Text);
            //passes loginPlainPassword to Encryption to allow it to be compoared to the db value 
            string loginEncryptedPassword = Encrypt.Encryption(loginPlainPassword);

            //store student number in session 
            Session["s_loggedNumber"] = Convert.ToString(loginNumber);

            string sqlSelectCompareDetails = "SELECT Number, Password FROM tbl_user WHERE (Number = '" + loginNumber + "') AND (Password = '" + loginEncryptedPassword + "')";
            SqlCommand cmdCompareDetails = new SqlCommand(sqlSelectCompareDetails, Connections.ApplicationConnection());
            SqlDataReader sqldr = cmdCompareDetails.ExecuteReader();

            if (sqldr.HasRows)
            {
                //gets the id of the user being logged in and stores it in Session["s_loggedUserId"]
                String sqlGetUserId = "SELECT Id FROM tbl_user WHERE (Number = '" + loginNumber + "')";

                using (var cnn = Connections.ApplicationConnection())
                {
                    using (var cmdGetId = new SqlCommand(sqlGetUserId, cnn))
                    {
                        Session["s_loggedUserId"] = Convert.ToInt32(cmdGetId.ExecuteScalar());
                        cnn.Close();
                    }
                }

                //gets the role of the user being logged in and stores it in Session["s_loggedUserId"]
                String sqlGetUserRole = "SELECT Role FROM tbl_user WHERE Number = @number";


                using (var cnn = Connections.ApplicationConnection())
                {
                    using (var cmdGetRole = new SqlCommand(sqlGetUserRole, cnn))
                    {
                        cmdGetRole.Parameters.AddWithValue("@number", loginNumber);
                        Session["s_loggedUserRole"] = Convert.ToInt32(cmdGetRole.ExecuteScalar());
                        cnn.Close();
                    }

                }
                //directs to page based on role code 
                if (Convert.ToInt32(Session["s_loggedUserRole"].ToString()) == 10)
                {
                    //student
                    Response.Redirect("Student/StudentHome.aspx");
                }
                else if(Convert.ToInt32(Session["s_loggedUserRole"].ToString()) == 20)
                {
                    //academic
                    Response.Redirect("Academic/AcademicHome.aspx");
                }
                else if (Convert.ToInt32(Session["s_loggedUserRole"].ToString()) == 30)
                {
                    //admin
                    Response.Redirect("Admin/AdminHome.aspx");
                }
                else if (Convert.ToInt32(Session["s_loggedUserRole"].ToString()) == 40)
                {
                    //academic program manager
                    Response.Redirect("Academic/AcademicHome.aspx");
                }
                else if (Convert.ToInt32(Session["s_loggedUserRole"].ToString()) == 50)
                {
                    //senior university manager
                    Response.Redirect("SeniorUniversityManager/SUMHome.aspx");
                }
                else if (Convert.ToInt32(Session["s_loggedUserRole"].ToString()) == 60)
                {
                    //super user
                    Response.Redirect("SuperUser/SuperUserHome.aspx");
                }


            }
            //doesnt exist
            else
            {
                lblLoginErrorText.Text = "The Number Or Password Combination You Have Entered Is Incorrect !";
            }


        }

        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPassword.aspx");
        }
    }
}