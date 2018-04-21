using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class _404 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("~/Default.aspx");

            }

            if (Session["s_loggedUserRole"].ToString() == "10")
            {
                Response.Redirect("~/Student/StudentHome.aspx");
            }
            else if (Session["s_loggedUserRole"].ToString() == "20")
            {
                Response.Redirect("~/Academic/AcademicHome.aspx");
            }
            else if (Session["s_loggedUserRole"].ToString() == "30")
            {
                Response.Redirect("~/Admin/AdminHome.aspx");
            }
            else if (Session["s_loggedUserRole"].ToString() == "40")
            {
                Response.Redirect("~/Academic/AcademicHome.aspx");
            }
            else if (Session["s_loggedUserRole"].ToString() == "50")
            {
                Response.Redirect("~/SeniorUniversityManager/SUMHome.aspx");
            }
            else if (Session["s_loggedUserRole"].ToString() == "60")
            {
                Response.Redirect("~/SuperUser/SuperUserHome.aspx");
            }
        }
    }
}