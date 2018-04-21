using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace CIT12.Admin
{
    public partial class AdminAddCourseaspx : System.Web.UI.Page
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

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    //get schools
                    SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_school", conn);
                    SqlDataReader sqldrGetSchool = cmdGetCourse.ExecuteReader();
                    try
                    {
                        ddlSchool.Items.Clear();
                        ddlSchool.Items.Insert(0, new ListItem("-- Select School --", "0"));
                        while (sqldrGetSchool.Read())
                        {
                            ddlSchool.Items.Add(new ListItem(sqldrGetSchool[1].ToString(), sqldrGetSchool[0].ToString()));
                        }
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        sqldrGetSchool.Close();
                        conn.Close();
                    }
                }
            }

        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
              
                SqlCommand cmdInsertCourse = new SqlCommand("INSERT INTO tbl_course (SchoolId, Name, Code) VALUES (@schoolId, @name, @code ) ", conn);
                cmdInsertCourse.Parameters.AddWithValue("@schoolId", Convert.ToInt32(ddlSchool.SelectedValue));
                cmdInsertCourse.Parameters.AddWithValue("@name", txtName.Text.ToString());
                cmdInsertCourse.Parameters.AddWithValue("@code", txtCode.Text.ToString());

                try
                {
                    if (ddlSchool.SelectedValue == "-- Select School --")
                    {
                        lblError.Text = "Please Slect A School";

                    }
                    else
                    {
                        cmdInsertCourse.ExecuteNonQuery();

                        lblError.CssClass = "text-success";
                        lblError.Text = "Success Your Course Has Been Added";

                    }
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                    ddlSchool.SelectedIndex = 0;
                    txtName.Text = "";
                    txtCode.Text = "";
                }
            }
        }



    }
}

