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
    public partial class AdminAddModule : System.Web.UI.Page
    {

        private void hideAllPanels()
        {
            pnlAddModule.Visible = false;
            pnlAddClassTime.Visible = false;
        }

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

        //------------------new module submit----------------------
        protected void btnAddModule_Click(object sender, EventArgs e)
        {

            Session["s_courseId"] = ddlCourse.SelectedValue;
            string moduleTitle = txtModuleTitle.Text;
            string moduleCode = txtModuleCode.Text;
            int level = Convert.ToInt32(ddlLevel.SelectedValue);
            int semesterId = Convert.ToInt32(ddlSemester.SelectedValue);
            int catPoints = Convert.ToInt32(txtCatPoints.Text);
            string preReqModules = txtPreReq.Text;

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdSubmitModule = new SqlCommand("INSERT INTO tbl_modules (CourseId, Title, Code, Level, SemesterId, CatPoints, PreReqModules) VALUES (@courseId, @title, @code, @level, @semesterId, @catPoints, @preReqModules)", conn);
                cmdSubmitModule.Parameters.AddWithValue("@courseId", Convert.ToInt32(Session["s_courseId"]));
                cmdSubmitModule.Parameters.AddWithValue("@title", moduleTitle);
                cmdSubmitModule.Parameters.AddWithValue("@code", moduleCode);
                cmdSubmitModule.Parameters.AddWithValue("@level", Convert.ToInt32(level));
                cmdSubmitModule.Parameters.AddWithValue("@semesterId", semesterId);
                cmdSubmitModule.Parameters.AddWithValue("@catPoints", catPoints);
                cmdSubmitModule.Parameters.AddWithValue("@preReqModules", preReqModules);

                try
                {
                    cmdSubmitModule.ExecuteNonQuery();
                    
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("EXCEPTION : " + ex);
                }

                //get module for just created module
                SqlCommand cmdGetModuleId = new SqlCommand("SELECT Id from tbl_modules WHERE Code = @code", conn);
                cmdGetModuleId.Parameters.AddWithValue("@code", moduleCode);

                Session["s_moduleId"] = Convert.ToInt32(cmdGetModuleId.ExecuteScalar());

                Debug.WriteLine("COURSE ID : " + Session["s_courseId"]);
                Debug.WriteLine("MODULE ID : " + Session["s_moduleId"]);

                conn.Close();

                ddlCourse.ClearSelection();
                txtModuleTitle.Text = "";
                txtModuleCode.Text = "";
                ddlLevel.ClearSelection();
                ddlSemester.ClearSelection();
                txtCatPoints.Text = "";
                txtPreReq.Text = "";

                hideAllPanels();
                pnlAddClassTime.Visible = true;
            }

        }


        //---------Adds class times to created module--------------------
        protected void btnSubmitClassTimes_Click(object sender, EventArgs e)
        {

            int courseId = Convert.ToInt32(Session["s_courseId"]);
            int moduleId = Convert.ToInt32(Session["s_moduleId"]);
            int classTypeId = Convert.ToInt32(ddlClassType.SelectedValue);
            string time = txtStartTime.Text + " - " + txtEndTime.Text;
            int dayId = Convert.ToInt32(ddlDay.SelectedValue);
            string location = txtLocation.Text;

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdSubmitClassTimes = new SqlCommand("INSERT INTO tbl_timeTable (CourseId, ModuleId, ClassTypeId, Time, DayId, Location) VALUES (@courseId, @moduleId, @classTypeId, @time, @dayId, @location)",conn);
                cmdSubmitClassTimes.Parameters.AddWithValue("@courseId", courseId);
                cmdSubmitClassTimes.Parameters.AddWithValue("@moduleId", moduleId);
                cmdSubmitClassTimes.Parameters.AddWithValue("@classTypeId", classTypeId);
                cmdSubmitClassTimes.Parameters.AddWithValue("@time", time);
                cmdSubmitClassTimes.Parameters.AddWithValue("@dayId", dayId);
                cmdSubmitClassTimes.Parameters.AddWithValue("@location", location);

                try
                {
                    cmdSubmitClassTimes.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();

                    lblClassError.CssClass = "text-success";
                    lblClassError.Text = "Success Your Class Has Been Added";


                    ddlClassType.ClearSelection();
                    ddlDay.ClearSelection();
                    txtStartTime.Text = "";
                    txtEndTime.Text = "";
                    txtLocation.Text = "";
                }

            }
        }


        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //----------------load ddl values---------------

                //get courses
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_course", conn);
                SqlDataReader sqldrGetCourse = cmdGetCourse.ExecuteReader();
                try
                {
                    ddlCourse.Items.Clear();
                    while (sqldrGetCourse.Read())
                    {
                        ddlCourse.Items.Add(new ListItem(sqldrGetCourse[1].ToString(), sqldrGetCourse[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex);
                }
                finally
                {
                    sqldrGetCourse.Close();
                }
                //levels
                ddlLevel.Items.Add(new ListItem("Level 1", "1"));
                ddlLevel.Items.Add(new ListItem("Level 2", "2"));
                ddlLevel.Items.Add(new ListItem("Level 3", "3"));
                ddlLevel.Items.Add(new ListItem("Level 4", "4"));

                //get semesters 
                SqlCommand cmdGetSemester = new SqlCommand("SELECT Id, Semester FROM tbl_semester", conn);
                SqlDataReader sqldrGetSemester = cmdGetSemester.ExecuteReader();
                try
                {
                    ddlSemester.Items.Clear();
                    while (sqldrGetSemester.Read())
                    {
                        ddlSemester.Items.Add(new ListItem(sqldrGetSemester[1].ToString(), sqldrGetSemester[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex);
                }
                finally
                {
                    sqldrGetSemester.Close();
                }

                //get days
                SqlCommand cmdGetDays = new SqlCommand("SELECT Id, Day FROM tbl_days", conn);
                SqlDataReader sqldrGetDays = cmdGetDays.ExecuteReader();
                try
                {
                    ddlDay.Items.Clear();
                    while (sqldrGetDays.Read())
                    {
                        ddlDay.Items.Add(new ListItem(sqldrGetDays[1].ToString(), sqldrGetDays[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex);
                }
                finally
                {
                    sqldrGetDays.Close();
                }

                //class type ddl
                SqlCommand cmdGetClassType = new SqlCommand("SELECT Id, Type FROM tbl_classType", conn);
                SqlDataReader sqldrGetClassType = cmdGetClassType.ExecuteReader();
                try
                {
                    while (sqldrGetClassType.Read())
                    {
                        ddlClassType.Items.Add(new ListItem(sqldrGetClassType[1].ToString(), sqldrGetClassType[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex);
                }
                finally
                {
                    sqldrGetClassType.Close();
                    conn.Close();
                }

            }
        }





    }
}