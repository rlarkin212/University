using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Net.Mail;
using System.IO;

namespace CIT12.Academic
{
    public partial class AcademicEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                if (Session["s_loggedUserRole"].ToString() == "40")
                {

                }
                else if (Session["s_loggedUserRole"].ToString() == "30")
                {

                }
                else if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }

            }

            if (Session["s_emailAddressToSendList"] == null)
            {
                lblErrorMessage.Text = "You Have Not Included Any Recipents !";
                btnSendEmail.Visible = false;
            }

            this.Page.Form.DefaultButton = btnSendEmail.UniqueID;
            this.Page.Form.DefaultFocus = txtHeader.ClientID;

        }

        protected void btnSendEmail_Click(object sender, EventArgs e)
        {
            ArrayList emailAddressList = Session["s_emailAddressToSendList"] as ArrayList;

            if (emailAddressList != null)
            {

                foreach (var address in emailAddressList)
                {

                    string emailHeader = txtHeader.Text;
                    string emailSubject = txtSubject.Text;
                    string emailBody = txtBody.Text;
                    MailAddress mailAddress = new MailAddress(address.ToString());
                    string emailFileName = "";
                    string emailFile = "";

                    if (fuAttachment.HasFile)
                    {
                        //emailFileName = fuAttachment.PostedFile.FileName.ToString();
                        emailFile = fuAttachment.FileContent.ToString();
                    }

                    //send email 
                    Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);

                    lblErrorMessage.CssClass = "text-success";
                    lblErrorMessage.Text = "Success Your Email Has Been Sent ! ";

                    txtSubject.Text = "";

                    txtSubject.Text = "";
                    txtHeader.Text = "";
                    txtBody.Text = "";

                }
            }
            else
            {
                lblErrorMessage.Text = "You Have Not Included Any Recipents !";
            }

        }
    }
}