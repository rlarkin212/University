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
    public partial class AdminViewCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void gvActive_RowCommand(object sender, GridViewCommandEventArgs e)
        {
    
            if (e.CommandName == "EditCourse")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField courseid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                HiddenField schoolId = clickedRow.FindControl("HiddenFieldSchoolId") as HiddenField;
                Session["s_CourseId"] = courseid.Value;
                Session["s_SchoolId"] = schoolId.Value;

                Debug.WriteLine("Course ID: " + Session["s_CourseId"] + "School ID: " + Session["s_SchoolId"]);
                Response.Redirect("~/Admin/AdminEditCourse.aspx?courseId=" + Session["s_CourseId"]);
            }

            if (e.CommandName == "ViewModules")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField courseid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                Session["s_CourseId"] = courseid.Value;
                Response.Redirect("~/Admin/AdminViewModules.aspx?courseId=" + Session["s_CourseId"]);
            }
        }

        protected void gvInactive_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditCourse")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField courseid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                HiddenField schoolId = clickedRow.FindControl("HiddenFieldSchoolId") as HiddenField;
                Session["s_CourseId"] = courseid.Value;
                Session["s_SchoolId"] = schoolId.Value;

                Debug.WriteLine("Course ID: " + Session["s_CourseId"] + "School ID: " + Session["s_SchoolId"]);
                Response.Redirect("~/Admin/AdminEditCourse.aspx?courseId=" + Session["s_CourseId"]);
            }

            if (e.CommandName == "ViewModules")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField courseid = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                Session["s_CourseId"] = courseid.Value;
                Response.Redirect("~/Admin/AdminViewModules.aspx?courseId=" + Session["s_CourseId"]);
            }

        }

 
    }
}