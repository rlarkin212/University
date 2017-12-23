using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace CIT12
{
    public partial class SprintBacklog : System.Web.UI.Page
    {
        ArrayList sprintBacklog = new ArrayList();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }

        }

        //on rown command for gvProduct backlog
        protected void gvProductBacklog_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Add")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Int32 sprintId = Convert.ToInt32(Session["s_sprintId"]);
                Int32 productBacklogid = Convert.ToInt32(clickedRow.Cells[0].Text);

                string sqlInsertUserStory = "INSERT INTO tbl_SprintBacklog ([SprintId],[BacklogId]) VALUES (@sprintId, @backlogId)";
                SqlCommand cmdInsertUserStory = new SqlCommand(sqlInsertUserStory, Connections.ApplicationConnection());

                cmdInsertUserStory.Parameters.AddWithValue("@sprintId", sprintId);
                cmdInsertUserStory.Parameters.AddWithValue("@backlogId", productBacklogid);

                cmdInsertUserStory.ExecuteNonQuery();

                gvSprintBacklog.DataBind();
                gvProductBacklog.DataBind();
            }



        }

        protected void gvSprintBacklog_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "AddTask")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_sprintBacklogId"] = clickedRow.Cells[0].Text;

                Response.Redirect("SprintBacklogTasks");
            }
        }
    }
}



