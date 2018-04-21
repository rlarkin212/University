using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class AdminSetModuleBreakdown : System.Web.UI.Page
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
            pnlModules.Visible = false;
            pnlBreakDown.Visible = false;
            pnlAddComponent.Visible = false;
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

                //get module component types
                SqlCommand cmdGetComponentTypes = new SqlCommand("SELECT ComponentTypeCode, ComponentType FROM tbl_moduleComponentTypes", conn);
                SqlDataReader sqldrGetComponentTypes = cmdGetComponentTypes.ExecuteReader();
                try
                {
                    ddlComponentType.Items.Clear();
                    ddlComponentType.Items.Insert(0, new ListItem("-- Select Component Type --", "0"));
                    while (sqldrGetComponentTypes.Read())
                    {
                        ddlComponentType.Items.Add(new ListItem(sqldrGetComponentTypes[1].ToString(), sqldrGetComponentTypes[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetComponentTypes.Close();
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
                    conn.Close();
                    sqldrGetCourse.Close();
                }

            }
        }
        //course ddl change
        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["s_courseId"] = ddlCourse.SelectedValue;
        }

        //modules row command 
        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdViewBreakdown")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_moduleId"] = clickedRow.Cells[0].Text;
                Session["s_courseId"] = clickedRow.Cells[1].Text;
                lblModule.Text = clickedRow.Cells[3].Text;

                HideAllPanels();
                pnlBreakDown.Visible = true;

            }
        }

        //add component on click
        protected void btnAddComponent_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlAddComponent.Visible = true;
        }

        //breakdown data bound check the %  = 100 if not error label
        protected void gvBreakdown_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Int32 overallPercentage = 0;
            Int32 percentage = 0;

            foreach (GridViewRow row in gvBreakdown.Rows)
            {
                for (int i = 0; i < gvBreakdown.Columns.Count; i++)
                {
                    Int32.TryParse(row.Cells[2].Text, out percentage);
                }
                overallPercentage = overallPercentage + percentage;
            }

            if (overallPercentage != 100)
            {
                lblPercentageError.Text = "Module Breakdown Does Not Add Up To 100%";
            }
            else
            {
                lblPercentageError.Text = "";
            }
        }
        

        //breakdown row command
        protected void gvBreakdown_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdDeleteBreakdown")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdDeleteBreakdown = new SqlCommand("DELETE FROM tbl_moduleComponents WHERE Id = @id", conn);
                    cmdDeleteBreakdown.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[0].Text));

                    try
                    {
                        cmdDeleteBreakdown.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        gvBreakdown.DataBind();
                    }
                }
            }
        }

        //component type ddl chaneg
        protected void ddlComponentType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlComponentType.SelectedItem.Text == "Overall")
            {
                lblPercentage.Visible = false;
                txtPercentage.Visible = false;
            }
            else
            {
                lblPercentage.Visible = true;
                txtPercentage.Visible = true;
            }
        }

        protected void btnSubmitComponent_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {

                if (ddlComponentType.SelectedItem.Text != "-- Select Component Type --")
                {
                    //if overall
                    if (ddlComponentType.SelectedItem.Text == "Overall")
                    {
                        SqlCommand cmdInsertOverall = new SqlCommand("INSERT INTO tbl_moduleComponents (ModuleId, ComponentTypeCode, CourseId) Values(@moduleId, @componentTypeCode, @courseId)", conn);
                        cmdInsertOverall.Parameters.AddWithValue("@moduleId", Convert.ToInt32(Session["s_moduleId"]));
                        cmdInsertOverall.Parameters.AddWithValue("@componentTypeCode", Convert.ToInt32(ddlComponentType.SelectedValue));
                        cmdInsertOverall.Parameters.AddWithValue("@courseId", Convert.ToInt32(Session["s_courseId"]));

                        try
                        {
                            cmdInsertOverall.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                        finally
                        {
                            conn.Close();
                            ddlComponentType.ClearSelection();

                            gvBreakdown.DataBind();
                            HideAllPanels();
                            pnlBreakDown.Visible = true;
                        }

                    }
                    //rest of types
                    else
                    {
                        Int32 percentage = Convert.ToInt32(txtPercentage.Text);
                        if (percentage > 100)
                        {
                            lblError.Text = "Please Enter A Percentage Less Than 100%";
                        }
                        else
                        {
                            SqlCommand cmdInsertComponent = new SqlCommand("INSERT INTO tbl_moduleComponents (ModuleId, ComponentTypeCode, CourseId, Percentage) Values(@moduleId, @componentTypeCode, @courseId, @percentage)", conn);
                            cmdInsertComponent.Parameters.AddWithValue("@moduleId", Convert.ToInt32(Session["s_moduleId"]));
                            cmdInsertComponent.Parameters.AddWithValue("@componentTypeCode", Convert.ToInt32(ddlComponentType.SelectedValue));
                            cmdInsertComponent.Parameters.AddWithValue("@courseId", Convert.ToInt32(Session["s_courseId"]));
                            cmdInsertComponent.Parameters.AddWithValue("@percentage", Convert.ToInt32(percentage));

                            try
                            {
                                cmdInsertComponent.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                throw ex;
                            }
                            finally
                            {
                                conn.Close();
                                ddlComponentType.ClearSelection();
                                txtPercentage.Text = "";

                                gvBreakdown.DataBind();
                                HideAllPanels();
                                pnlBreakDown.Visible = true;
                            }
                        }
                    }
                }
                else
                {
                    lblError.Text = "Please Select A Valid Component Type";
                }


            }
        }

        
    }
}