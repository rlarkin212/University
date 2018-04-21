using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminAllocateAcademicProgramManager : System.Web.UI.Page
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

        private void HideAllPanels()
        {
            pnlProgramManager.Visible = false;
            pnlCourse.Visible = false;
        }

        private void PopulateDropDowns()
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

        //students row command
        protected void gvProgramManagers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdAssignProgramManager")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_programManagerId"] = clickedRow.Cells[0].Text;

                HideAllPanels();
                pnlCourse.Visible = true;

            }
        }

        

        //courses row command
        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdAssign")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdAssignProgramManager = new SqlCommand("INSERT INTO tbl_courseAcademicProgramManager (ProgramMangerId, CourseId) VALUES (@programMangerId, @courseId)", conn);
                    cmdAssignProgramManager.Parameters.AddWithValue("@programMangerId", Convert.ToInt32(Session["s_programManagerId"]));
                    cmdAssignProgramManager.Parameters.AddWithValue("@courseId", Convert.ToInt32(clickedRow.Cells[0].Text));

                    try
                    {
                        cmdAssignProgramManager.ExecuteNonQuery();
                    }
                    catch(Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        lblSuccessMessage.Text = "Success You Have Assigned An Academic Program Manager !";
                        conn.Close();
                    }
                }




            }
        }
    }
}