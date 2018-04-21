using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminSetStudentStatus : System.Web.UI.Page
    {
        public void hideAllPanels()
        {
            pnlStudentSearch.Visible = false;
            pnlStatus.Visible = false;
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
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    //get status
                    SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Status FROM tbl_status", conn);
                    SqlDataReader sqldrGetStatus = cmdGetCourse.ExecuteReader();
                    try
                    {
                        ddlStatus.Items.Clear();
                        ddlStatus.Items.Insert(0, new ListItem("-- Select Status --", ""));
                        while (sqldrGetStatus.Read())
                        {
                            ddlStatus.Items.Add(new ListItem(sqldrGetStatus[1].ToString(), sqldrGetStatus[0].ToString()));
                        }
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        sqldrGetStatus.Close();
                        conn.Close();
                    }
                }
            }

        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdChangeStatus")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_studentId"] = clickedRow.Cells[0].Text;
                lblStudent.Text = clickedRow.Cells[2].Text;

                hideAllPanels();
                pnlStatus.Visible = true;
            }
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            if (ddlStatus.SelectedItem.Text != "-- Select Status --")
            {
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdUpdateStatus = new SqlCommand("UPDATE tbl_studentUser SET StatusId = @statusId WHERE StudentId = @studentId", conn);
                    cmdUpdateStatus.Parameters.AddWithValue("@statusId", Convert.ToInt32(ddlStatus.SelectedValue));
                    cmdUpdateStatus.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));

                    try
                    {
                        cmdUpdateStatus.ExecuteNonQuery();

                        lblError.CssClass = "text-success";
                        lblError.Text = "Success The Students Status Has Been Updated";

                        gvStudents.DataBind();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();

                        hideAllPanels();
                        pnlStudentSearch.Visible = true;
                    }
                }
            }
            else
            {
                lblError.Text = "Please Select A Status";
            }
        }
    }
}