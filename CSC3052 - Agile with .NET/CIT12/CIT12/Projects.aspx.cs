using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CIT12
{
    public partial class Projects : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {

                Response.Redirect("Default.aspx");
            }           
        }

        protected void GridViewCurrentProjects_SelectedIndexChanged(object sender, EventArgs e)
        {
            string projectid = GridViewCurrentProjects.SelectedRow.Cells[0].Text;
            Session["projectId"] = projectid;
            Response.Redirect("~/ProjectManagerView.aspx?projectId=" + projectid);
        }
        protected void GridViewPreviousProjects_SelectedIndexChanged(object sender, EventArgs e)
        {
            string projectid = GridViewPreviousProjects.SelectedRow.Cells[0].Text;
            Session["projectId"] = projectid;
            Response.Redirect("~/ProjectManagerView.aspx?projectId=" + projectid);
        }
    }
}