using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Academic
{
    public partial class AcademicProgramManagerStudentEnrolement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDowns();
            }

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                if (Session["s_loggedUserRole"].ToString() == "40")
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




            this.Page.Form.DefaultButton = btnStudentSearch.UniqueID;
            this.Page.Form.DefaultFocus = txtStudentNumber.ClientID;
        }

        private void HideAllPanels()
        {
            pnlEnrolement.Visible = false;
            pnlStudents.Visible = false;
            pnlSuccess.Visible = false;
        }

        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get school
                SqlCommand cmdGetSchool = new SqlCommand("SELECT Id, Name FROM tbl_school", conn);
                SqlDataReader sqldrGetSchool = cmdGetSchool.ExecuteReader();
                try
                {
                    ddlSchool.Items.Clear();
                    ddlSchool.Items.Insert(0, new ListItem("-- Select School --", "0"));
                    while (sqldrGetSchool.Read())
                    {
                        ddlSchool.Items.Add(new ListItem(sqldrGetSchool[1].ToString(), sqldrGetSchool[0].ToString()));
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
                    sqldrGetSchool.Close();
                    conn.Close();
                }

                //levels
            }
        }

        //stuend gv row command
        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdEnroll")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                lblStudent.Text = clickedRow.Cells[1].Text + " - " + clickedRow.Cells[2].Text;
                lblCurrentLevel.Text = "Current Level : " + clickedRow.Cells[4].Text;


                if (clickedRow.Cells[4].Text != "4")
                {
                    int levelToEnroll = Convert.ToInt32(clickedRow.Cells[4].Text) + 1;
                    ddlLevel.ClearSelection();
                    ddlLevel.Items.FindByValue(levelToEnroll.ToString()).Selected = true;


                }

                Session["s_studentToEnrollId"] = clickedRow.Cells[0].Text;


                HideAllPanels();
                pnlEnrolement.Visible = true;
            }


        }
        //school selecte index changed
        protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
        {

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get course
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_course WHERE SchoolId = @schoolId", conn);
                cmdGetCourse.Parameters.AddWithValue("@schoolId", Convert.ToInt32(ddlSchool.SelectedValue));
                SqlDataReader sqldrGetCourse = cmdGetCourse.ExecuteReader();
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
        //course selected index change
        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        //module gv row command
        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //class times command
            if (e.CommandName == "cmdViewClassTimes")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                lblModalTitle.Text = "Class Times - " + clickedRow.Cells[1].Text;
                Session["s_moduleIdForTimetable"] = clickedRow.Cells[0].Text;

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);

            }


        }

        protected void btnSubmitEnrolement_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvModules.Rows)
            {
                if (((CheckBox)row.FindControl("cbEnroll")).Checked)
                {
                    using (SqlConnection conn = Connections.ApplicationConnection())
                    {

                        //enroll in modules
                        SqlCommand cmdSubmitEnrolement = new SqlCommand("INSERT INTO tbl_studentModule (StudentId, ModuleId, YearId, Complete) VALUES (@studentId, @moduleId, @yearId, @complete) ", conn);
                        cmdSubmitEnrolement.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentToEnrollId"]));
                        cmdSubmitEnrolement.Parameters.AddWithValue("@moduleId", Convert.ToInt32(row.Cells[0].Text));
                        cmdSubmitEnrolement.Parameters.AddWithValue("@yearId", Convert.ToInt32(11));
                        cmdSubmitEnrolement.Parameters.AddWithValue("@complete", Convert.ToInt32(0));
                        try
                        {

                            //cmdSubmitEnrolement.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                        finally
                        {
                            conn.Close();

                        }
                    }
                }
            }
            //updte studebt level
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //update student level
                SqlCommand cmdUpdateLevel = new SqlCommand("UPDATE tbl_studentUser SET StudentLevel = @studentLevel WHERE StudentId = @studentId", conn);
                cmdUpdateLevel.Parameters.AddWithValue("@studentLevel", Convert.ToInt32(ddlLevel.SelectedValue));
                cmdUpdateLevel.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentToEnrollId"]));

                try
                {
                    cmdUpdateLevel.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                    HideAllPanels();
                    pnlSuccess.Visible = true;
                }
            }



        }
    }
}