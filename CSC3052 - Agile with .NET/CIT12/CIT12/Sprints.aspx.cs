using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class Sprints : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }

        }

        protected void btnAddSprint_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateASprint.aspx");
        }

        protected void gvSprints_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewSprintBacklog")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_sprintId"] = clickedRow.Cells[0].Text;
                Response.Redirect("SprintBacklog.aspx");
                Debug.WriteLine("SPRINT ID : " + Session["s_sprintId"]);
            }

            if (e.CommandName == "AvailableDevelopers")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_sprintId"] = clickedRow.Cells[0].Text;
                Response.Redirect("SelectDevelopers.aspx");
            }
        }
    }
}