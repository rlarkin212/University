using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class SelectDevelopers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (Session["s_sprintId"] == null)
            {
                Response.Redirect("~/Sprints.aspx");
            }

        }

        protected void GridViewDevelopers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField id = clickedRow.FindControl("HiddenFieldId") as HiddenField;

                string sqlAppointDev = "INSERT INTO tbl_SprintStaff (Sprint_Id, Dev_Id) VALUES (@sprint, @dev)";
                SqlCommand cmdAppointDev = new SqlCommand(sqlAppointDev, Connections.ApplicationConnection());
                cmdAppointDev.Parameters.AddWithValue("@sprint", Session["s_sprintId"]);
                cmdAppointDev.Parameters.AddWithValue("@dev", id.Value);
                cmdAppointDev.ExecuteNonQuery();

                successAlertMessage.Visible = true;


                string email = clickedRow.Cells[3].Text;
                string projectTitle = Session["s_projectTitle"].ToString();
                string name = clickedRow.Cells[1].Text + " " + clickedRow.Cells[2].Text;
                string emailHeader = "Added As Developer";
                string emailSubject = "You Have Been Addded As A Developer";
                MailAddress emailAddress = new MailAddress(email);
                string emailBody = "Dear " + name + " you have been added as developer for a sprint in the project - " + projectTitle;

                Email.SendEmail(emailAddress, emailHeader, emailSubject, emailBody);




            }
        }
    }
}