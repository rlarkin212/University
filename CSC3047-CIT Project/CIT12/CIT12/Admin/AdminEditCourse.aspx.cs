using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminEditCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            int courseId = Convert.ToInt32(Session["s_CourseId"]);
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
        //        int active;
                SqlCommand cmdCourseDetails = new SqlCommand("SELECT * FROM tbl_course WHERE Id = @id", conn);
                cmdCourseDetails.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_CourseId"]));

                using (SqlDataReader rdrCourseDetails = cmdCourseDetails.ExecuteReader())
                {
                    while (rdrCourseDetails.Read())
                    {
                        if (!IsPostBack)
                        {
                            txtTitle.Text = rdrCourseDetails["Name"].ToString();
                            txtCode.Text = rdrCourseDetails["Code"].ToString();

                            if (rdrCourseDetails["Active"].ToString() == "1")
                            {
                                cbActive.Checked = true;                               
                            }
                            else
                            {
                                cbActive.Checked = false;                           
                            }
                        }
                    }
                }
                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string title;
            string code;
            int active;

            if (cbActive.Checked == true)
            {
                active = 1;
                Debug.WriteLine("Active : 1");
            }
            else
            {
                active = 0;
                Debug.WriteLine("Active : 0");
            }
            using (SqlConnection conn = Connections.ApplicationConnection())
            {

                int courseId = Convert.ToInt32(Session["s_CourseId"]);
                title = txtTitle.Text;
                code = txtCode.Text;


                SqlCommand cmdEditCourse = new SqlCommand("UPDATE tbl_course SET Name = @title, Code = @code, Active = @active WHERE Id = @id", conn);
                cmdEditCourse.Parameters.AddWithValue("@title", title);
                cmdEditCourse.Parameters.AddWithValue("@code", code);   
                cmdEditCourse.Parameters.AddWithValue("@active", active);

                cmdEditCourse.Parameters.AddWithValue("@id", courseId);

                cmdEditCourse.ExecuteNonQuery();

            }

            Response.Redirect(Request.RawUrl);
        }
    }
    }
