using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace CIT12.SuperUser
{
    public partial class SuperUserResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "60")
            {
                Response.Redirect("~/Default.aspx");
            }


            this.Page.Form.DefaultButton = btnSubmitPassword.UniqueID;
            this.Page.Form.DefaultFocus = txtNumber.ClientID;
        }

       
        protected void btnSubmitPassword_Click(object sender, EventArgs e)
        {
            string studentStaffNumber = txtNumber.Text;
            string fullemail = "";
            string newPassword = "";

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                if (studentStaffNumber.Length > 0)
                {
                    SqlCommand cmdGetEmail = new SqlCommand("SELECT EmailAddress FROM tbl_user WHERE Number = @number", conn);
                    cmdGetEmail.Parameters.AddWithValue("@number", studentStaffNumber);
                    fullemail = Convert.ToString(cmdGetEmail.ExecuteScalar());
                    Debug.WriteLine("EMAIL : " + fullemail);
                    //split email into parts & encrypt
                    newPassword = Encrypt.Encryption(fullemail.ToString().Split('@').ElementAt(0));

                    if(fullemail == "")
                    {
                        lblErrorText.Text = "Please Enter A Valid Student/ Staff Number";
                    }
                   
                }
                else
                {
                    lblErrorText.Text = "Please Enter A Student / Staff Number";
                }

                //update password
                if (fullemail != "")
                {
                    SqlCommand cmdUpdatePasssword = new SqlCommand("UPDATE tbl_user SET Password = @password WHERE Number = @number", conn);
                    cmdUpdatePasssword.Parameters.AddWithValue("@password", newPassword);
                    cmdUpdatePasssword.Parameters.AddWithValue("@number", studentStaffNumber);
                    cmdUpdatePasssword.ExecuteNonQuery();

                    lblErrorText.CssClass = "text-success";
                    lblErrorText.Text = "Password Has Been Successfully Changed";
                }
                else
                {
                    lblErrorText.Text = "Please Enter A Student / Staff Number";
                }


            }



        }
    }
}