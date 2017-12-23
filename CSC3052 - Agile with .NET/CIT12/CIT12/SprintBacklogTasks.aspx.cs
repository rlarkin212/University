using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class SprintBacklogTasks : System.Web.UI.Page
    {

        protected void hideAllPanels()
        {
            pnlTasks.Visible = false;
            pnlUpdateHours.Visible = false;

            txtTaskName.Text = "";
            txtInitialHours.Text = "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }

           
            
        }

        protected void gvSprintBacklogTasks_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell completeCell = e.Row.Cells[5];
                if(completeCell.Text == "0")
                {
                    completeCell.Text = "Incomplete";
                }
                else
                {
                    completeCell.Text = "Complete";
                }
            }
        }

        protected void btnAddTask_Click(object sender, EventArgs e)
        {
            if (txtTaskName.Text == "" || txtInitialHours.Text == "")
            {
                lblError.Visible = true;
            }
            else
            {
                string sqlInsertTask = "INSERT INTO tbl_SprintBacklogTasks (SprintBacklogId,TaskName, InitialHours, HoursLeft, Complete) VALUES (@sprintBacklogId, @taskName, @initialHours, @hoursLeft, @complete)";
                SqlCommand cmdInsertTask = new SqlCommand(sqlInsertTask, Connections.ApplicationConnection());

                cmdInsertTask.Parameters.AddWithValue("@sprintBacklogId", Convert.ToInt32(Session["s_sprintBacklogId"]));
                cmdInsertTask.Parameters.AddWithValue("@taskName", txtTaskName.Text);
                cmdInsertTask.Parameters.AddWithValue("@initialHours", Convert.ToInt32(txtInitialHours.Text));
                cmdInsertTask.Parameters.AddWithValue("@hoursLeft", Convert.ToInt32(txtInitialHours.Text));
                cmdInsertTask.Parameters.AddWithValue("@complete", Convert.ToInt32(0));

                cmdInsertTask.ExecuteNonQuery();
                gvSprintBacklogTasks.DataBind();
                txtTaskName.Text = "";
                txtInitialHours.Text = "";
            }
        }

        protected void gvSprintBacklogTasks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "UpdateTasks")
            {


                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                string taskId = clickedRow.Cells[0].Text;
                string task = clickedRow.Cells[2].Text;
                string initialHours = clickedRow.Cells[3].Text;

                lblId.Text = taskId;
                lblTask.Text = task;
                lblInitialHours.Text = initialHours;

                hideAllPanels();
                pnlUpdateHours.Visible = true;


            }


            
            
        }

        protected void btnUpdateHours_Click(object sender, EventArgs e)
        {
            int taskId = Convert.ToInt32(lblId.Text);
            int hoursLeft = Convert.ToInt32(txtHoursLeft.Text);
            int complete = 0;

            if(hoursLeft == 0)
            {
                complete = 1;
            }

            string sqlUpdateHours = "UPDATE tbl_SprintBacklogTasks SET HoursLeft = @hoursLeft, Complete = @complete WHERE Id = @id";
            SqlCommand cmdUpdateHours = new SqlCommand(sqlUpdateHours, Connections.ApplicationConnection());

            cmdUpdateHours.Parameters.AddWithValue("@hoursLeft", hoursLeft);
            cmdUpdateHours.Parameters.AddWithValue("@complete", complete);
            cmdUpdateHours.Parameters.AddWithValue("@id", taskId);

            cmdUpdateHours.ExecuteNonQuery();
            txtHoursLeft.Text = "";

            Response.Redirect("SprintBacklogTasks.aspx");

        }
    }
}