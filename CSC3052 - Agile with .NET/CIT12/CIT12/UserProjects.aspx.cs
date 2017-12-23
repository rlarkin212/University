using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class UserProjects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {

                Response.Redirect("Default.aspx");
            }
        }


        protected void gvUserProjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewBacklog")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_projectId"] = clickedRow.Cells[1].Text;
                Response.Redirect("ProductBacklog.aspx");
               

            }

            if(e.CommandName == "ViewSprints")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_projectId"] = clickedRow.Cells[1].Text;
                Session["s_projectTitle"] = clickedRow.Cells[2].Text;
                Response.Redirect("Sprints.aspx");
            }

        }
    }
}
