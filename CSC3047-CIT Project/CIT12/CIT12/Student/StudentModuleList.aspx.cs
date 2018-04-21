using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data.SqlClient;

namespace CIT12.Student
{
    public partial class StudentModuleList : System.Web.UI.Page
    {
        protected void hideAllPanels()
        {
            pnlModuleList.Visible = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "10")
            {
                Response.Redirect("~/Default.aspx");
            }

            //get course title
            string courseTitle;
            string sqlGetTitle = "SELECT tbl_course.Name FROM tbl_course INNER JOIN tbl_studentCourse ON tbl_course.Id = tbl_studentCourse.CourseId WHERE tbl_studentCourse.StudentId = @studentId";
            using (var cnn = Connections.ApplicationConnection())
            {
                using (var cmdGetTitle = new SqlCommand(sqlGetTitle, cnn))
                {
                    cmdGetTitle.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                    courseTitle = Convert.ToString(cmdGetTitle.ExecuteScalar());

                }
            }
            //set course title
            lblCourse.Text = courseTitle;

        }
        //hides in in gv and print function
        protected void gvModuleList_DataBound(object sender, EventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
                gridView.HeaderRow.Cells[1].Visible = false;
                gridView.HeaderRow.Cells[5].Visible = false;
            }

            foreach (GridViewRow row in gvModuleList.Rows)
            {
                row.Cells[0].Visible = false;
                row.Cells[1].Visible = false;
                row.Cells[5].Visible = false;
            }
        }

        // shows module spec
        protected void gvModuleList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewModuleSpec")
            {
                hideAllPanels();
                pnlModuleSpec.Visible = true;

                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_moduleId"] = Convert.ToInt32(clickedRow.Cells[0].Text);

                Debug.WriteLine("MODULE ID : " + Session["s_moduleId"].ToString());

                string moduleTitle = clickedRow.Cells[2].Text;
                lblModuleSpecName.Text = moduleTitle;

            }
        }


    }
}