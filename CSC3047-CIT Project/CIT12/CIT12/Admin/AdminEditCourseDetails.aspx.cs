using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Diagnostics;

namespace CIT12.Admin
{
    public partial class AdminEditCourseDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int courseId = Convert.ToInt32(Session["s_CourseId"]);
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Name FROM tbl_course WHERE Id = @id", conn);
                cmdGetCourse.Parameters.AddWithValue("@id", courseId);

                SqlCommand cmdGetCode = new SqlCommand("SELECT Code FROM tbl_course WHERE Id = @id", conn);
                cmdGetCode.Parameters.AddWithValue("@id", courseId);

                SqlCommand cmdGetActive = new SqlCommand("SELECT Active FROM tbl_course WHERE Id = @id", conn);
                cmdGetActive.Parameters.AddWithValue("@id", courseId);

                txtName.Text = Convert.ToString(cmdGetCourse.ExecuteScalar());               
                txtCode.Text = Convert.ToString(cmdGetCode.ExecuteScalar());

               // string active = Convert.ToString(cmdGetActive.ExecuteScalar());

                if (Convert.ToInt32(cmdGetActive.ExecuteScalar()) == 1)
                {
                    cbActive.Checked = true;
                }
                else
                {
                    cbActive.Checked = false;
                }
                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int active;
            if (cbActive.Checked == true)
            {
                active = 1;
            }
            else
            {
                active = 0;
            }

            int courseId = Convert.ToInt32(Session["s_CourseId"]);
            Debug.WriteLine("COURSE ID : " + courseId);

            using (SqlConnection conn = Connections.ApplicationConnection())
            {

                SqlCommand cmdUpdateCourse = new SqlCommand("UPDATE tbl_course SET Name = @name, Code = @code, Active = @active WHERE Id = @id", conn);

                cmdUpdateCourse.Parameters.AddWithValue("@id", Convert.ToInt32(courseId));
                cmdUpdateCourse.Parameters.AddWithValue("@name", txtName.Text.ToString());
                cmdUpdateCourse.Parameters.AddWithValue("@code", txtCode.Text.ToString());
                cmdUpdateCourse.Parameters.AddWithValue("@active", Convert.ToInt32(active));

                cmdUpdateCourse.ExecuteNonQuery();

              //  Debug.WriteLine("1: " + txtName.Text + "- 2 :" + txtCode.Text);
              //  Response.Redirect("~/Admin/AdminEditCourseDetails.aspx?courseId=" + Session["s_CourseId"]);
            }           
        }
    }
}