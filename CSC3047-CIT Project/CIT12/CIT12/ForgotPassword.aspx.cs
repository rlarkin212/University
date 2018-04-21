using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Text;
using System.Data.SqlClient;
using System.Net.Mail;

namespace CIT12
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Page.Form.DefaultButton = btnSubmitPassword.UniqueID;
            this.Page.Form.DefaultFocus = txtNumberCheck.ClientID;
        }

        protected void hideAllPanels()
        {
            pnlCheckUser.Visible = false;
            pnlUpdatePassword.Visible = false;
        }

        //method generates key for password reset
        Random rand = new Random();
        public const string Alphabet =
        "abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        public string KeyGen(int size)
        {
            char[] chars = new char[size];
            for (int i = 0; i < size; i++)
            {
                chars[i] = Alphabet[rand.Next(Alphabet.Length)];
            }
            return new string(chars);
        }

        //------------------check for valid user and sends key-------------------------
        protected void btnCheck_Send_Click(object sender, EventArgs e)
        {
            string studentStaffNumber = txtNumberCheck.Text;
            string emailAddress = "";
            Debug.WriteLine("EMAIL ADDRESS : " + emailAddress);

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //if field has a value
                if (studentStaffNumber.Length > 0)
                {
                    SqlCommand cmdGetEmail = new SqlCommand("SELECT EmailAddress FROM tbl_user WHERE Number = @number", conn);
                    cmdGetEmail.Parameters.AddWithValue("@number", studentStaffNumber);
                    emailAddress = Convert.ToString(cmdGetEmail.ExecuteScalar());
                    Debug.WriteLine("EMAIL : " + emailAddress);

                    // if it brings back a valid email
                    if (emailAddress != "")
                    {
                        string keyToSend = KeyGen(10);
                        string emailHeader = "QSIS - Password Change Request";
                        string emailSubject = "You Have Requested A Request For A Password Change On Your QSIS Account";
                        string emailBody = "Your key reset you password is : " + keyToSend;
                        MailAddress mailAddress = new MailAddress(emailAddress);
                        string emailFileName = "";
                        string emailFile = "";

                      
                        //send email 
                        Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);

                        //write to db to verify user
                        SqlCommand cmdInsertForgetPasswordKey = new SqlCommand("INSERT INTO tbl_changePassword (Number, EmailKey) VALUES (@number, @emailKey)", conn);
                        cmdInsertForgetPasswordKey.Parameters.AddWithValue("@number", studentStaffNumber);
                        cmdInsertForgetPasswordKey.Parameters.AddWithValue("@emailKey", keyToSend);
                        cmdInsertForgetPasswordKey.ExecuteNonQuery();

                        txtNumberCheck.Text = "";
                        hideAllPanels();
                        pnlUpdatePassword.Visible = true;

                    }
                    else
                    {
                        lblCheckErrorMessage.Text = "Please Enter A Valid Student/ Staff Number";
                    }

                }
                else
                {
                    lblCheckErrorMessage.Text = "Please Enter A Student / Staff Number";
                }


            }

        }
        //updates password
        protected void btnSubmitPassword_Click(object sender, EventArgs e)
        {
            bool validUser = false;
            string enteredNumber = txtConfirmNumber.Text;
            string enteredKey = txtKey.Text;

            //db values
            string dbNumber = "";
            string dbKey = "";
            //gets values from db
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //check against db
                SqlCommand cmdCheckDetails = new SqlCommand("SELECT TOP 1 Number,EmailKey FROM tbl_changePassword WHERE Number = @number ORDER BY Id Desc", conn);
                cmdCheckDetails.Parameters.AddWithValue("@number", enteredNumber);
                SqlDataReader sqldrCheckDetails = cmdCheckDetails.ExecuteReader();
                while (sqldrCheckDetails.Read())
                {

                    dbNumber = sqldrCheckDetails["Number"].ToString();
                    dbKey = sqldrCheckDetails["EmailKey"].ToString();

                    if (enteredNumber.Equals(dbNumber) && enteredKey.Equals(dbKey))
                    {
                        validUser = true;
                    }
                    else
                    {
                        lblErrorText.Text = "The Number / Key Combination You Have Entered Is Incorrect";
                    }
                }
                sqldrCheckDetails.Close();

                //update password is if bool valid user is true
                if (validUser == true)
                {

                    //check passwords match
                    if (txtPassword.Text.Equals(txtConfirmPassword.Text))
                    {
                        string numberToUpdate = enteredNumber;
                        string encPassword = Encrypt.Encryption(txtPassword.Text);

                        //update table
                        SqlCommand cmdUpdatePassword = new SqlCommand("UPDATE tbl_user SET Password = @password WHERE Number = @number", conn);
                        cmdUpdatePassword.Parameters.AddWithValue("@password", encPassword);
                        cmdUpdatePassword.Parameters.AddWithValue("@number", numberToUpdate);
                        cmdUpdatePassword.ExecuteNonQuery();

                        txtConfirmNumber.Text = "";
                        txtKey.Text = "";

                        //delete records from tbl_change password
                        SqlCommand cmdDeleteKeys = new SqlCommand("DELETE FROM tbl_changePassword WHERE Number = @number", conn);
                        cmdDeleteKeys.Parameters.AddWithValue("@number", numberToUpdate);
                        cmdDeleteKeys.ExecuteNonQuery();

                        lblErrorText.CssClass = "text-success";
                        lblErrorText.Text = "Your Password Has Successfully Been Changed You Can Now <a href='Login.aspx'>Login</a>";

                    }
                    else
                    {
                        lblErrorText.Text = "Passwords Entered Do Not Match";
                    }

                }
                conn.Close();
                //end connection   
            }
        }






    }
}