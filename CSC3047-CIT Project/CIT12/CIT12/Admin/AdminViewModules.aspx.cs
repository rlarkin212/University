using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CIT12.Admin
{
    public partial class AdminViewModules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void gvActive_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //opens class list for selected module
            if (e.CommandName == "EditModule")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField moduleid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                Session["s_ModuleId"] = moduleid.Value;
                HiddenField schoolid = clickedRow.FindControl("HiddenFieldSchId") as HiddenField;
                Session["s_SchoolId"] = schoolid.Value;

                Response.Redirect("~/Admin/AdminEditModule.aspx?moduleId=" + Session["s_ModuleId"]);
            }

            if (e.CommandName == "DeleteModule")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField moduleid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                Session["s_ModuleId"] = moduleid.Value;
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    string sqlDelete = "DELETE FROM tbl_modules WHERE Id = @moduleId";
                    SqlCommand cmdDelete = new SqlCommand(sqlDelete, conn);
                    cmdDelete.Parameters.AddWithValue("@moduleId", Session["s_ModuleId"]);
                    cmdDelete.ExecuteNonQuery();

                    conn.Close();
                }
                Response.Redirect("~/Admin/AdminViewModules.aspx?courseId=" + Session["s_CourseId"]);
            }
        }

        protected void gvInactive_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditModule")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField moduleid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                Session["s_ModuleId"] = moduleid.Value;
                HiddenField schoolid = clickedRow.FindControl("HiddenFieldSchId") as HiddenField;
                Session["s_SchoolId"] = schoolid.Value;

                Response.Redirect("~/Admin/AdminEditModule.aspx?moduleId=" + Session["s_ModuleId"]);
            }

            if (e.CommandName == "DeleteModule")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField moduleid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                Session["s_ModuleId"] = moduleid.Value;
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    string sqlDelete = "DELETE FROM tbl_modules WHERE Id = @moduleId";
                    SqlCommand cmdDelete = new SqlCommand(sqlDelete, conn);
                    cmdDelete.Parameters.AddWithValue("@moduleId", Session["s_ModuleId"]);
                    cmdDelete.ExecuteNonQuery();

                    conn.Close();
                }
                Response.Redirect("~/Admin/AdminViewModules.aspx?courseId=" + Session["s_CourseId"]);
            }

        }
    }
}