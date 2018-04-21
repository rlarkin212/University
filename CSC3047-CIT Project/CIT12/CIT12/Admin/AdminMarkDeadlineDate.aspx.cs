using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Globalization;
using System.Diagnostics;

namespace CIT12.Admin
{
    public partial class AdminMarkDeadlineDate : System.Web.UI.Page
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

            calDeadlineDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
            calDeadlineDate.VisibleDate = Convert.ToDateTime(DateTime.Now.ToString());

            if (!IsPostBack)
            {
                PopulateDropDowns();

            }

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
                    conn.Close();
                    sqldrGetSchool.Close();
                }

            }
        }

        private void HideAllPanels()
        {
            pnlModules.Visible = false;
            pnlSetDate.Visible = false;
        }

        //school ddl change - populate 
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

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["s_courseId"] = ddlCourse.SelectedValue;
        }

        //modules gv row command
        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdSetDate")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_moduleId"] = clickedRow.Cells[0].Text;
                lblModuleName.Text = clickedRow.Cells[3].Text;

                HideAllPanels();
                pnlSetDate.Visible = true;

                //get module date if it exists
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    string presentDate = "";
                    SqlCommand cmdGetPresentDate = new SqlCommand("SELECT Date FROM tbl_moduleMarksEndDate WHERE ModuleId = @moduleId", conn);
                    cmdGetPresentDate.Parameters.AddWithValue("@moduleId", Session["s_moduleId"].ToString());
                    SqlDataReader sqldrGetPresentDate = cmdGetPresentDate.ExecuteReader();
                    while (sqldrGetPresentDate.Read())
                    {
                        presentDate = sqldrGetPresentDate["Date"].ToString();
                    }
                    lblCurrentDeadlineDate.Text = presentDate;
                    conn.Close();
                    sqldrGetPresentDate.Close();
                }



            }
        }
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
        protected void calDeadlineDate_SelectionChanged(object sender, EventArgs e)
        {
            txtDeadlineDate.Text = calDeadlineDate.SelectedDate.ToShortDateString();
            string selectedDate = txtDeadlineDate.Text;

            bool validDate = IsDateBeforeOrToday(selectedDate);

            if (validDate == false)
            {
                lblError.Text = "Please Enter A Date Greater Than The Current Date";
                btnSubmitDate.Enabled = false;
            }
            else
            {
                lblError.Text = "";
                btnSubmitDate.Enabled = true;
            }

        }

        //submit date
        protected void btnSubmitDate_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {


                if (lblCurrentDeadlineDate.Text == "")
                {
                    //insert into tbl
                    if (txtDeadlineDate.Text != "")
                    {
                        //has date
                        SqlCommand cmdInsertDeadlineDate = new SqlCommand("INSERT INTO tbl_moduleMarksEndDate (ModuleId,Date) VALUES (@moduleId,@date)", conn);
                        cmdInsertDeadlineDate.Parameters.AddWithValue("@moduleId", Convert.ToInt32(Session["s_moduleId"]));
                        cmdInsertDeadlineDate.Parameters.AddWithValue("@date", Convert.ToDateTime(txtDeadlineDate.Text));

                        cmdInsertDeadlineDate.ExecuteNonQuery();

                        conn.Close();

                        txtDeadlineDate.Text = "";
                        lblSuccess.Text = "Succes The Deadline Date Has Been Set";
                        HideAllPanels();
                        pnlModules.Visible = true;
                    }
                    else
                    {
                        //no date
                        lblError.Text = "Please Enter A Deadline Date";

                    }
                }
                else
                {
                    //update tbl
                    if (txtDeadlineDate.Text != "")
                    {
                        //has date
                        SqlCommand cmdUpdateDeadlineDate = new SqlCommand("UPDATE tbl_moduleMarksendDate SET Date = @date WHERE ModuleId = @moduleId", conn);
                        cmdUpdateDeadlineDate.Parameters.AddWithValue("@moduleId", Convert.ToInt32(Session["s_moduleId"]));
                        cmdUpdateDeadlineDate.Parameters.AddWithValue("@date", Convert.ToDateTime(txtDeadlineDate.Text));

                        cmdUpdateDeadlineDate.ExecuteNonQuery();

                        conn.Close();

                        txtDeadlineDate.Text = "";
                        lblSuccess.Text = "Succes The Deadline Date Has Been Set";
                        HideAllPanels();
                        pnlModules.Visible = true;
                    }
                    else
                    {
                        //no date
                        lblError.Text = "Please Enter A Deadline Date update";
                    }
                }

            }
        }

       
    }
}