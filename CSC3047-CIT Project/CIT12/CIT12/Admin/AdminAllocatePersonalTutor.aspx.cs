using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminAllocatePersonalTutor : System.Web.UI.Page
    {
        private void hideAllPanels()
        {
            pnlStudent.Visible = false;
            pnlAcademics.Visible = false;
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
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdAssignTutor")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_studentId"] = clickedRow.Cells[0].Text;
                

                hideAllPanels();
                pnlAcademics.Visible = true;
            }
        }

        protected void gvAcademic_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdAssignToStudent")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_academicId"] = clickedRow.Cells[0].Text;


                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdAssignPersonalTutor = new SqlCommand("INSERT INTO tbl_academicPersonalTutees (AcademicId, StudentId) VALUES (@academicId, @studentId)", conn);
                    cmdAssignPersonalTutor.Parameters.AddWithValue("@academicId", Convert.ToInt32(Session["s_academicId"]));
                    cmdAssignPersonalTutor.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));

                    try
                    {
                        cmdAssignPersonalTutor.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        hideAllPanels();
                        pnlStudent.Visible = true;

                        lblSuccess.Text = "Success You Have Assigned A Personal Tutor";
                    }
                }
            }
        }
    }
}