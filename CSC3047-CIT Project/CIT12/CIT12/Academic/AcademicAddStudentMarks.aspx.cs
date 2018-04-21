using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data.SqlClient;

namespace CIT12.Academic
{
    public partial class AcademicAddStudentMarks : System.Web.UI.Page
    {
        private void hideAllPanels()
        {

            pnlModuleList.Visible = false;
            pnlClassList.Visible = false;
            pnlSetMarks.Visible = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                if (Session["s_loggedUserRole"].ToString() == "40")
                {

                }else if (Session["s_loggedUserRole"].ToString() == "30")
                {

                }else if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }

            }

        }



        //-------------------module list commands-----------------

        //row data bount to check that date is valid for entry
        protected void gvModuleList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            bool validDate = true;

            foreach (GridViewRow row in gvModuleList.Rows)
            {
               
                for (int i = 0; i < gvModuleList.Columns.Count; i++)
                {
                    //DateTime endDate = Convert.ToDateTime(gvModuleList.Rows[i].Cells[4].Text);
                    DateTime endDate = Convert.ToDateTime(row.Cells[4].Text);
                    DateTime currentDate = DateTime.Now;

                    if (currentDate > endDate)
                    {
                        validDate = false;
                    }
                    else
                    {
                        validDate = true;
                    }
                }

                if (validDate == false)
                {
                    Button btnClassList = (Button)row.FindControl("btnClassList");
                    Label lblModuleListError = (Label)row.FindControl("lblModuleListError");

                    btnClassList.Enabled = false;
                    lblModuleListError.Text = "You Cannot Enter Marks At This Time";
                }

            }



        }
        //row command to show class list
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
                        Debug.WriteLine("YEAR ID: " + Session["s_yearId"]);
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
                lblModule.Text = clickedRow.Cells[1].Text;

                hideAllPanels();
                pnlClassList.Visible = true;

            }

        }

        //-------------------class list commands-----------------

        //row data command to show mark entry
        protected void gvClassList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdSetMarks")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_studentId"] = clickedRow.Cells[0].Text;
                lblStudent.Text = clickedRow.Cells[2].Text;

                hideAllPanels();
                pnlSetMarks.Visible = true;
            }
        }

        //-------------------marks commands-----------------

        //update marks
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
                        hideAllPanels();
                        pnlClassList.Visible = true;
                    }

                }

            }
        }
    }
}