using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Academic
{
    public partial class StudentSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.Page.Form.DefaultButton = btnSearch.UniqueID;
            this.Page.Form.DefaultFocus = txtStudentNumber.ClientID;

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                if (Session["s_loggedUserRole"].ToString() == "40")
                {

                }
                else if (Session["s_loggedUserRole"].ToString() == "30")
                {

                }
                else if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }

            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Session["s_studentNumberSearch"] = txtStudentNumber.Text;
            gvStudents.DataBind();
        }
    }
}