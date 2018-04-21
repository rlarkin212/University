using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMModuleStructure : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "50")
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

        protected void PopulateDropDowns()
        {

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get courses
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_course", conn);
                SqlDataReader sqldrGetCourse = cmdGetCourse.ExecuteReader();
                try
                {
                    ddlCourseList.Items.Clear();
                    ddlCourseList.Items.Insert(0, new ListItem("-- Select Course --", "0"));
                    while (sqldrGetCourse.Read())
                    {
                        ddlCourseList.Items.Add(new ListItem(sqldrGetCourse[1].ToString(), sqldrGetCourse[0].ToString()));
                    }

                    ddlLevels.Items.Clear();
                    ddlLevels.Items.Insert(0, new ListItem("-- Select Level --", "0"));
                    for(int i = 1; i <= 4; i++)
                    {
                        string level = "Level " + i;
                        ddlLevels.Items.Add(new ListItem(level.ToString(),i.ToString()));
                    }

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

        protected void ddlCourseList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["s_courseId"] = Convert.ToInt32(ddlCourseList.SelectedValue);
            
        }

        protected void gvCourseModuleStructure_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
            }

            foreach (GridViewRow row in gvCourseModuleStructure.Rows)
            {
                row.Cells[0].Visible = false;
            }
        }
    }
}