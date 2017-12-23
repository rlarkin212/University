using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Net.Mail;

namespace CIT12
{
    public partial class ProjectManagerView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            String sqlCheckUser = "SELECT * FROM [tbl_Projects] WHERE ([ProjectManagerId] = @ProjectManagerId)";
            SqlCommand cmdCheckUser = new SqlCommand(sqlCheckUser, Connections.ApplicationConnection());
            cmdCheckUser.Parameters.AddWithValue("@ProjectManagerId", Session["s_loggedUserId"]);

            int rows = Convert.ToInt32(cmdCheckUser.ExecuteScalar());

            if (rows == 0)
            {
                pnlPMView.Visible = false;
                pnlNotPM.Visible = true;
            }
        }
        protected void GridViewTeamOwner_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //need to check which command has been selected if we need to add extra buttons
            var clickedButton = e.CommandSource as Button;
            var clickedRow = clickedButton.NamingContainer as GridViewRow;

            HiddenField userId = clickedRow.FindControl("HiddenFieldId") as HiddenField;

            string sqlDeletePreviousOwner = "DELETE FROM tbl_ProjectPersonnel WHERE (Project_ID = @Pro_ID) AND (User_RoleCode = 20)";
            SqlCommand cmdDeletePreviousOwner = new SqlCommand(sqlDeletePreviousOwner, Connections.ApplicationConnection());
            cmdDeletePreviousOwner.Parameters.AddWithValue("@Pro_ID", Session["projectId"]);
            cmdDeletePreviousOwner.ExecuteNonQuery();

            string sqlInsertOwner = "INSERT INTO tbl_ProjectPersonnel (User_ID, Project_ID, User_RoleCode) VALUES (@userid,@projectid,@userrolecode)";
            SqlCommand cmdInsertOwner = new SqlCommand(sqlInsertOwner, Connections.ApplicationConnection());
            cmdInsertOwner.Parameters.AddWithValue("@userid", userId.Value);
            cmdInsertOwner.Parameters.AddWithValue("@projectid", Session["projectId"]);
            cmdInsertOwner.Parameters.AddWithValue("@userrolecode", 20);
            cmdInsertOwner.ExecuteNonQuery();

            successAlertMessagePM.Visible = true;
            //get project title 

            String sqlProjectTitle = "SELECT Title FROM [tbl_Projects] WHERE ([Id] = @projectid)";
            SqlCommand cmdProTitle = new SqlCommand(sqlProjectTitle, Connections.ApplicationConnection());
            cmdProTitle.Parameters.AddWithValue("@projectid", Session["projectId"]);
            string projectTitle = (string)cmdProTitle.ExecuteScalar();

            //send email


            string name = clickedRow.Cells[0].Text + " " + clickedRow.Cells[1].Text;

            string emailHeader = "New Project Manager";
            string emailSubject = "You Have Been Made The Project Manager For - " + projectTitle;
            MailAddress emailAddress = new MailAddress(clickedRow.Cells[2].Text);
            string emailBody = "Dear " + name + " you have been selected as the project manager for the project - " + projectTitle;

            Email.SendEmail(emailAddress, emailHeader, emailSubject, emailBody);
        
        }

        protected void GridViewTeamScrum_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //need to check which command has been selected if we need to add extra buttons
            var clickedButton = e.CommandSource as Button;
            var clickedRow = clickedButton.NamingContainer as GridViewRow;

            HiddenField userId = clickedRow.FindControl("HiddenFieldId") as HiddenField;

            string sqlInsertScrumMaster = "INSERT INTO tbl_ProjectPersonnel (User_ID, Project_ID, User_RoleCode) VALUES (@userid,@projectid,@userrolecode)";
            SqlCommand cmdInsertScrumMaster = new SqlCommand(sqlInsertScrumMaster, Connections.ApplicationConnection());
            cmdInsertScrumMaster.Parameters.AddWithValue("@userid", userId.Value);
            cmdInsertScrumMaster.Parameters.AddWithValue("@projectid", Session["projectId"]);
            cmdInsertScrumMaster.Parameters.AddWithValue("@userrolecode", 30);
            cmdInsertScrumMaster.ExecuteNonQuery();

            successAlertMessagePM.Visible = true;
            //get project title 

            String sqlProjectTitle = "SELECT Title FROM [tbl_Projects] WHERE ([Id] = @projectid)";
            SqlCommand cmdProTitle = new SqlCommand(sqlProjectTitle, Connections.ApplicationConnection());
            cmdProTitle.Parameters.AddWithValue("@projectid", Session["projectId"]);
            string projectTitle = (string)cmdProTitle.ExecuteScalar();

            //send email

            string name = clickedRow.Cells[0].Text + " " + clickedRow.Cells[1].Text;

            string emailHeader = "New Project Manager";
            string emailSubject = "You Have Been Made The Project Manager For - " + projectTitle;
            
            MailAddress emailAddress = new MailAddress(clickedRow.Cells[2].Text);
            string emailBody = "Dear " + name + " you have been made a scrum master for the project - " + projectTitle;

            Email.SendEmail(emailAddress, emailHeader, emailSubject, emailBody);
        }
    }
}