using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminUpdateStudentmarks : System.Web.UI.Page
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
                Session["s_courseId"] = Convert.ToInt32("0");

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
        }

        private void HideAllPanels()
        {
            pnlModuleList.Visible = false;
            pnlClassList.Visible = false;
            pnlSetMarks.Visible = false;
        }

        //modulelist row command
        protected void gvModuleList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //opens class list for selected module
            if (e.CommandName == "cmdViewClassList")
            {
                //getYearId
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdGetYearId = new SqlCommand("SELECT TOP 1 Id FROM tbl_years ORDER BY Id DESC", conn);
                    try
                    {
                        Session["s_yearId"] = Convert.ToSByte(cmdGetYearId.ExecuteScalar());
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

                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_mouduleId"] = clickedRow.Cells[0].Text;
                lblModule.Text = clickedRow.Cells[3].Text;

                HideAllPanels();
                pnlClassList.Visible = true;
            }

        }
        //class list row command
        protected void gvClassList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdSetMarks")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_studentId"] = clickedRow.Cells[0].Text;
                lblStudent.Text = clickedRow.Cells[2].Text;

                HideAllPanels();
                pnlSetMarks.Visible = true;
            }
        }

        //submit marks
        protected void btnSubmitMarks_Click(object sender, EventArgs e)
        {
            foreach (ListViewItem item in lvMarks.Items)
            {

                Label academicRecordId = (Label)item.FindControl("lblAcademicRecordId");
                TextBox txtMark = (TextBox)item.FindControl("txtMark");
                TextBox txtClassification = (TextBox)item.FindControl("txtClassification");

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdUpdateMarks = new SqlCommand("UPDATE tbl_AcademicRecord SET Mark = @mark, Classification = @classification WHERE Id = @id", conn);
                    cmdUpdateMarks.Parameters.AddWithValue("@id", Convert.ToInt32(academicRecordId.Text));
                    cmdUpdateMarks.Parameters.AddWithValue("@mark", Convert.ToInt32(txtMark.Text));
                    cmdUpdateMarks.Parameters.AddWithValue("@classification", Convert.ToString(txtClassification.Text));

                    try
                    {
                        cmdUpdateMarks.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();

                        lblMarksSuccess.Text = "Success The Marks Have Been Submitted";
                        HideAllPanels();
                        pnlClassList.Visible = true;
                    }

                }

            }
        }
    }
}