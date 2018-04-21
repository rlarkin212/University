using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminCourseClassList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "30")
            {
                if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }

            if (!IsPostBack)
            {
                PopulateDropDowns();
            }
        }
        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get courses
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_course", conn);
                SqlDataReader sqldrGetCourse = cmdGetCourse.ExecuteReader();
                try
                {
                    ddlCourse.Items.Clear();
                    ddlCourse.Items.Insert(0, new ListItem("-- Select Course --", "0"));
                    while (sqldrGetCourse.Read())
                    {
                        ddlCourse.Items.Add(new ListItem(sqldrGetCourse[1].ToString(), sqldrGetCourse[0].ToString()));
                    }

                    ddlLevel.Items.Clear();
                    ddlLevel.Items.Insert(0, new ListItem("-- Select Level --", "0"));
                    ddlLevel.Items.Insert(1, new ListItem("Level 1", "1"));
                    ddlLevel.Items.Insert(2, new ListItem("Level 2", "2"));
                    ddlLevel.Items.Insert(3, new ListItem("Level 3", "3"));
                    ddlLevel.Items.Insert(4, new ListItem("Level 4", "4"));

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetCourse.Close();
                    conn.Close();
                }
            }
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["s_courseId"] = ddlCourse.SelectedValue;
        }

        //databound
        protected void gvCourseClassList_DataBound(object sender, EventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
            }

            foreach (GridViewRow row in gvCourseClassList.Rows)
            {
                row.Cells[0].Visible = false;
            }
        }

        //sendEmail
        protected void btnSendEmail_Click(object sender, EventArgs e)
        {
            ArrayList emailAddressList = new ArrayList();
            for (int i = 0; i < gvCourseClassList.Rows.Count; i++)
            {
                if (((CheckBox)gvCourseClassList.Rows[i].FindControl("cbEmail")).Checked)
                {
                    emailAddressList.Add(gvCourseClassList.Rows[i].Cells[2].Text);

                }
            }
            Session["s_emailAddressToSendList"] = emailAddressList;

            Response.Redirect("AdminSendEmail.aspx");
        }

        
    }
}