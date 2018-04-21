using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminAddEvent : System.Web.UI.Page
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

            calDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
        }

        private void HideAllPanels()
        {
            pnlModules.Visible = false;
            pnlAddEvent.Visible = false;
            pnlOneOffEvent.Visible = false;
        }

        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get school
                SqlCommand cmdGetSchol = new SqlCommand("SELECT Id, Name FROM tbl_school", conn);
                SqlDataReader sqldrGetSchool = cmdGetSchol.ExecuteReader();

                try
                {
                    ddlSchool.Items.Clear();
                    ddlSchool.Items.Insert(0, new ListItem("-- Select School --", "0"));
                    while (sqldrGetSchool.Read())
                    {
                        ddlSchool.Items.Add(new ListItem(sqldrGetSchool[1].ToString(), sqldrGetSchool[0].ToString()));
                    }
                    ddlCourse.Items.Insert(0, new ListItem("-- Please Select A School --", "0"));

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetSchool.Close();
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
                    throw ex;
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
                    ddlClassType.Items.Clear();
                    ddlClassType.Items.Insert(0, new ListItem("-- Select An Event Type --", "0"));
                    while (sqldrGetClassType.Read())
                    {
                        ddlClassType.Items.Add(new ListItem(sqldrGetClassType[1].ToString(), sqldrGetClassType[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetClassType.Close();
                    conn.Close();
                }
            }
        }
        //school ddl change
        protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int32 schoolId = Convert.ToInt32(ddlSchool.SelectedIndex);

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_course WHERE SchoolId = @schoolId", conn);
                cmdGetCourse.Parameters.AddWithValue("@schoolId", Convert.ToInt32(schoolId));
                SqlDataReader sqldrGetCourse = cmdGetCourse.ExecuteReader();

                //get course
                try
                {
                    ddlCourse.Items.Clear();
                    ddlCourse.Items.Insert(0, new ListItem("-- Select Course --", "0"));
                    while (sqldrGetCourse.Read())
                    {
                        ddlCourse.Items.Add(new ListItem(sqldrGetCourse[1].ToString(), sqldrGetCourse[0].ToString()));
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
        //course ddl change
        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["s_courseId"] = ddlCourse.SelectedValue;
        }

        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdAddEvent")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_moduleId"] = clickedRow.Cells[0].Text;
                Session["s_courseId"] = clickedRow.Cells[1].Text;

                HideAllPanels();
                pnlAddEvent.Visible = true;
            }

            //add one off event

            if (e.CommandName == "cmdAddOneOffEvent")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_moudleId"] = clickedRow.Cells[0].Text;
                
                txtTitle.Text = clickedRow.Cells[3].Text + " - ";

                HideAllPanels();
                pnlOneOffEvent.Visible = true;

            }




        }

        //add event on click
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
                SqlCommand cmdSubmitClassTimes = new SqlCommand("INSERT INTO tbl_timeTable (CourseId, ModuleId, ClassTypeId, Time, DayId, Location) VALUES (@courseId, @moduleId, @classTypeId, @time, @dayId, @location)", conn);
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
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();

                    ddlClassType.ClearSelection();
                    ddlDay.ClearSelection();
                    txtStartTime.Text = "";
                    txtEndTime.Text = "";
                    txtLocation.Text = "";

                    HideAllPanels();
                    pnlModules.Visible = true;

                    lblSuccess.Text = "Success Your Event Has Been Added";



                }

            }
        }



        //------------One off events--------------------------
        //check date is not before durretn date
        public static bool IsDateBeforeOrToday(string input)
        {
            DateTime pDate;
            if (!DateTime.TryParseExact(input, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out pDate))
            {
                //Invalid date
                //log , show error
                return false;
            }
            return DateTime.Today <= pDate;
        }

        //date change
        protected void calDate_SelectionChanged(object sender, EventArgs e)
        {
            txtDate.Text = calDate.SelectedDate.ToShortDateString();
            string selectedDate = txtDate.Text;

            bool validDate = IsDateBeforeOrToday(selectedDate);

            if (validDate == false)
            {
                lblError.Text = "Please Enter A Date Greater Than The Current Date";
                btnSubmitEvent.Enabled = false;
            }
            else
            {
                lblError.Text = "";
                btnSubmitEvent.Enabled = true;
            }
        }

        //add event 
        protected void btnSubmitEvent_Click(object sender, EventArgs e)
        {
            //get students in modules
            ArrayList studentIdArray = new ArrayList();
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetStudents = new SqlCommand("SELECT DISTINCT StudentId FROM tbl_studentModule WHERE ModuleId = @moduleId AND Complete = @complete", conn);
                cmdGetStudents.Parameters.AddWithValue("@moduleId", Convert.ToInt32(Session["s_moudleId"]));
                cmdGetStudents.Parameters.AddWithValue("@complete", Convert.ToInt32(0));

                SqlDataReader sqldrGetStudents = cmdGetStudents.ExecuteReader();
                try
                {
                    while (sqldrGetStudents.Read())
                    {
                        studentIdArray.Add(sqldrGetStudents["StudentId"]);
                    }
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetStudents.Close();
                    conn.Close();

                    HideAllPanels();
                    pnlModules.Visible = true;

                }

            }

            //add event
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertAdditionalEvent = new SqlCommand("INSERT INTO tbl_additionalEvents (Title, Description, Date, Time, UserId, Location) VALUES (@oneofftitle, @oneoffdescription, @oneoffdate, @oneofftime, @oneoffuserId, @oneofflocation)", conn);
                

                foreach (var userId in studentIdArray)
                {
                    cmdInsertAdditionalEvent.Parameters.Clear();

                    cmdInsertAdditionalEvent.Parameters.AddWithValue("@oneofftitle", Convert.ToString(txtTitle.Text));
                    cmdInsertAdditionalEvent.Parameters.AddWithValue("@oneoffdescription", Convert.ToString(txtDescription.Text));
                    cmdInsertAdditionalEvent.Parameters.AddWithValue("@oneoffdate", Convert.ToDateTime(txtDate.Text));
                    cmdInsertAdditionalEvent.Parameters.AddWithValue("@oneoffTime", Convert.ToString(txtTime.Text));
                    cmdInsertAdditionalEvent.Parameters.AddWithValue("@oneoffuserId", Convert.ToInt32(userId));
                    cmdInsertAdditionalEvent.Parameters.AddWithValue("@oneofflocation", Convert.ToString(txtEventLocation.Text));

                    cmdInsertAdditionalEvent.ExecuteNonQuery();
                }

                conn.Close();
                lblSuccess.Text = "Success, Your Event Has Been Created";
                HideAllPanels();
                pnlModules.Visible = true;

            }



        }
    }






}
