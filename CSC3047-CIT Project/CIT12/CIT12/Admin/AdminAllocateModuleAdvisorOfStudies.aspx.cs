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
    public partial class AdminAllocateModuleAdvisorOfStudies : System.Web.UI.Page
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
            pnlAcacdemic.Visible = false;
            pnlSelectModule.Visible = false;
        }
        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get courses
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_course", conn);
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
                }
            }
        }

        protected void gvAcacemic_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdAssignToModule")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_academicId"] = clickedRow.Cells[0].Text;

                HideAllPanels();
                pnlSelectModule.Visible = true;
            }
        }

        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnAssignToModule")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    int academicId = Convert.ToInt32(Session["s_academicId"]);
                    int moduleId = Convert.ToInt32(clickedRow.Cells[0].Text);
                    string note = "";

                    //gets note
                    TextBox txtNote = (TextBox)clickedRow.FindControl("txtNote");
                    note = txtNote.Text;

                    //insert into table 
                    SqlCommand cmdInsertProgramManager = new SqlCommand("Insert INTO tbl_academicProgramManagerModule (AcademicProgramManagerId, ModuleId, Note) Values (@programManagerId, @moduleId, @note)", conn);
                    cmdInsertProgramManager.Parameters.AddWithValue("@programManagerId", academicId);
                    cmdInsertProgramManager.Parameters.AddWithValue("@moduleId", moduleId);
                    cmdInsertProgramManager.Parameters.AddWithValue("@note", note);

                    try
                    {
                        cmdInsertProgramManager.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        lblSuccessMessage.Text = "Success - You Have Assigned An Academic Program Manager To This Module !";
                        txtNote.Text = "";
                    }



                }




            }
        }


    }
}