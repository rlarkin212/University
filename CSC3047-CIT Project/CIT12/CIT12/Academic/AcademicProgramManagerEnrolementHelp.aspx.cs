using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Academic
{
    public partial class AcademicProgramManagerEnrolementHelp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                if (Session["s_loggedUserRole"].ToString() == "40")
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


            calDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
            calDate.VisibleDate = Convert.ToDateTime(DateTime.Now.ToString());
        }

        private void HideAllPanels()
        {
            pnlRequsts.Visible = false;
            pnlResponse.Visible = false;
        }

        protected void gvHelpRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdRespond")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_helpRequestId"] = clickedRow.Cells[0].Text;
                Session["s_stundetToSendId"] = clickedRow.Cells[4].Text;
                txtEmailAddressToSend.Text = clickedRow.Cells[3].Text;

                HideAllPanels();
                pnlResponse.Visible = true;

            }
        }

        //check date is not before durretn date
        public static bool IsDateBeforeOrToday(string input)
        {
            DateTime pDate;
            if (!DateTime.TryParseExact(input, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out pDate))
            {
                //Invalid date
                //log , show error
                return false;
            }
            return DateTime.Today <= pDate;
        }

        //date change
        protected void calDate_SelectionChanged(object sender, EventArgs e)
        {
            txtDate.Text = calDate.SelectedDate.ToShortDateString();
            string selectedDate = txtDate.Text;

            bool validDate = IsDateBeforeOrToday(selectedDate);

            if (validDate == false)
            {
                lblError.Text = "Please Enter A Date Greater Than The Current Date";
                btnSubmitEvent.Enabled = false;
            }
            else
            {
                lblError.Text = "";
                btnSubmitEvent.Enabled = true;
            }
        }

        //send email meting ruquest to student 
        private void SendEmailMeetingRequest()
        {
            string emailHeader = txtTitle.Text;
            string emailSubject = txtDescription.Text;
            string emailBody = "A meeting has been arranged on the " + txtDate.Text + " at " + txtTime.Text + " at the lcation of " + txtLocation.Text + " to discuss your needed help with the enrolement process. The meeting has been added to you additional events calendar. Please contact your advisor of studies if this time does nto suit.";
            MailAddress mailAddress = new MailAddress(txtEmailAddressToSend.Text);
            string emailFileName = "";
            string emailFile = "";

            //send email 
            Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);
        }

        // delete request from helpo table
        private void DeleteFromHelpTable()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdDeleteHelpRequest = new SqlCommand("DELETE FROM tbl_advisorEnrolementHelp WHERE Id = @id", conn);
                cmdDeleteHelpRequest.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_helpRequestId"]));
                try
                {
                    cmdDeleteHelpRequest.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        private void InserEventAdvisor()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //advisor event
                SqlCommand cmdInsertEventAdvisor = new SqlCommand("INSERT INTO tbl_additionalEvents (Title,Description,Date,Time,UserId,Location) VALUES (@title,@description,@date,@time,@userId,@location)", conn);
                cmdInsertEventAdvisor.Parameters.AddWithValue("@title", txtTitle.Text);
                cmdInsertEventAdvisor.Parameters.AddWithValue("@description", txtDescription.Text);
                cmdInsertEventAdvisor.Parameters.AddWithValue("@date", Convert.ToDateTime(txtDate.Text));
                cmdInsertEventAdvisor.Parameters.AddWithValue("@time", txtTime.Text);
                cmdInsertEventAdvisor.Parameters.AddWithValue("@userId", Convert.ToInt32(Session["s_loggedUserId"]));
                cmdInsertEventAdvisor.Parameters.AddWithValue("@location", txtLocation.Text);
                try
                {
                    cmdInsertEventAdvisor.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        private void InsertEventStudent()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //studentEvent
                SqlCommand cmdInsertEventStudent = new SqlCommand("INSERT INTO tbl_additionalEvents (Title,Description,Date,Time,UserId,Location) VALUES (@stitle,@sdescription,@sdate,@stime,@suserId,@slocation)", conn);
                cmdInsertEventStudent.Parameters.AddWithValue("@stitle", txtTitle.Text);
                cmdInsertEventStudent.Parameters.AddWithValue("@sdescription", txtDescription.Text);
                cmdInsertEventStudent.Parameters.AddWithValue("@sdate", Convert.ToDateTime(txtDate.Text));
                cmdInsertEventStudent.Parameters.AddWithValue("@stime", txtTime.Text);
                cmdInsertEventStudent.Parameters.AddWithValue("@suserId", Convert.ToInt32(Session["s_stundetToSendId"]));
                cmdInsertEventStudent.Parameters.AddWithValue("@slocation", txtLocation.Text);
                try
                {
                    cmdInsertEventStudent.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }

            }
        }

        //add event button click
        protected void btnSubmitEvent_Click(object sender, EventArgs e)
        {
            try
            {
                //insert intio additional event table
                InserEventAdvisor();
                InsertEventStudent();
                //send email
                SendEmailMeetingRequest();
                //delete from help table
                DeleteFromHelpTable();
            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {
                txtEmailAddressToSend.Text = "";
                txtTitle.Text = "";
                txtDescription.Text = "";
                txtDate.Text = "";
                txtTime.Text = "";
                txtLocation.Text = "";

                gvHelpRequests.DataBind();
                HideAllPanels();
                pnlRequsts.Visible = true;
            }
        }
    }
}
