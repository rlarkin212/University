using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;

namespace CIT12
{

    //Session["s_lastCreatedProjectId"] stores the id of the just created project
    //Session["s_searchEmail"] id used for the search function
    public partial class CreateProject : System.Web.UI.Page
    {
        public void hideAllPanels()
        {
            pnlEnterProjectDetails.Visible = false;
            pnlProjectPersonnel.Visible = false;

        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            Session["s_searchEmail"] = txtUserEmail.Text;

            
            

        }

        protected void btnCreateProject_Click(object sender, EventArgs e)
        {
            int projectManagerId = Convert.ToInt32(Session["s_loggedUserId"]);

            string sqlInsertProject = "INSERT INTO tbl_Projects (Title,Details,ProjectManagerId) Values (@title, @details, @projectManagerId)";
            SqlCommand cmdInsertProject = new SqlCommand(sqlInsertProject, Connections.ApplicationConnection());

            cmdInsertProject.Parameters.AddWithValue("@title", txtProjectTitle.Text);
            cmdInsertProject.Parameters.AddWithValue("@details", txtProjectDetails.Text);
            cmdInsertProject.Parameters.AddWithValue("@projectManagerId", projectManagerId);

            cmdInsertProject.ExecuteNonQuery();

            successAlertMessage.Visible = true;

            //gets the id of th last created project
            string sqlGetLastProjectId = "SELECT Id FROM tbl_Projects WHERE Title = @title AND Details = @details AND ProjectManagerId = @projectManagerId ORDER BY Id DESC";
            Session["s_lastCreatedProjectId"] = "";

            using (var cnn = Connections.ApplicationConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sqlGetLastProjectId, cnn))
                {
                    cmd.Parameters.AddWithValue("@title", txtProjectTitle.Text);
                    cmd.Parameters.AddWithValue("@details", txtProjectDetails.Text);
                    cmd.Parameters.AddWithValue("@projectManagerId", Convert.ToInt32(projectManagerId));

                    Session["s_lastCreatedProjectId"] = Convert.ToInt32(cmd.ExecuteScalar());
                    Debug.WriteLine("LAST PROJECT ID : " + Session["s_lastCreatedProjectId"]);
                }
            }

            Session["s_projectTitle"] = txtProjectTitle.Text;

            txtProjectDetails.Text = "";
            txtProjectTitle.Text = "";

            hideAllPanels();
            pnlProjectPersonnel.Visible = true;
        }
        //used to just postback for filter paramaters
        protected void btnFilterUser_Click(object sender, EventArgs e)
        {
            
            Session["s_searchEmail"] = txtUserEmail.Text;
            hideAllPanels();
            pnlProjectPersonnel.Visible = true;
  
        }

        //row command takes the value of the row the button was clicked on 
        protected void gvPersonnel_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "Add")
            {

                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;


                int projectId = Convert.ToInt32(Session["s_lastCreatedProjectId"]);
                int userId = Convert.ToInt32(clickedRow.Cells[0].Text);
                int initialRoleCode = 50;

                Debug.WriteLine("PROJECT ID: " + projectId + " USER ID: " + userId);

                //insert into db
                string sqlInsertProjectPersonnel = "INSERT INTO tbl_ProjectPersonnel (Project_Id,User_Id,User_RoleCode) VALUES (@projectId, @userId, @roleCode)";
                SqlCommand cmdInsertPersonnel = new SqlCommand(sqlInsertProjectPersonnel, Connections.ApplicationConnection());
                cmdInsertPersonnel.Parameters.AddWithValue("@projectId", projectId);
                cmdInsertPersonnel.Parameters.AddWithValue("@userId", userId);
                cmdInsertPersonnel.Parameters.AddWithValue("@roleCode", initialRoleCode);

                cmdInsertPersonnel.ExecuteNonQuery();


                //send email

                string projectTitle = Session["s_projectTitle"].ToString();
                string name = clickedRow.Cells[2].Text + " " + clickedRow.Cells[3].Text;

                string emailHeader = "Added To Project";
                string emailSubject = "You Have Been Added To The Project - " + projectTitle;
                MailAddress emailAddress = new MailAddress(clickedRow.Cells[1].Text);
                string emailBody = "Dear " + name + " you have been added as personnel for the project - " + projectTitle;

                Debug.WriteLine("EMAIL ADDRESS : " + emailAddress);

                Email.SendEmail(emailAddress, emailHeader, emailSubject ,emailBody);


                

                hideAllPanels();
                pnlProjectPersonnel.Visible = true;
                msgAddedUserSuccess.Visible = true;



            }
        }
    }
}