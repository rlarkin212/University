using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminEditEvents : System.Web.UI.Page
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
            pnlEvents.Visible = false;
            pnlEditEvents.Visible = false;
        }

        //sets drop values from db
        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                try
                {
                    //get school
                    SqlCommand cmdGetSchol = new SqlCommand("SELECT Id, Name FROM tbl_school", conn);
                    SqlDataReader sqldrGetSchool = cmdGetSchol.ExecuteReader();
                    ddlSchool.Items.Insert(0, new ListItem("-- Select A School --", "0"));
                    while (sqldrGetSchool.Read())
                    {
                        ddlSchool.Items.Add(new ListItem(sqldrGetSchool[1].ToString(), sqldrGetSchool[0].ToString()));
                    }
                    sqldrGetSchool.Close();

                    //get classTypes
                    SqlCommand cmdGetClassTypes = new SqlCommand("SELECT Id, Type FROM tbl_classType",conn);
                    SqlDataReader sqldrGetClassTypes = cmdGetClassTypes.ExecuteReader();
                    while (sqldrGetClassTypes.Read())
                    {
                        ddlEventType.Items.Add(new ListItem(sqldrGetClassTypes[1].ToString(), sqldrGetClassTypes[0].ToString()));
                    }
                    sqldrGetClassTypes.Close();

                    //get days
                    SqlCommand cmdGetDays = new SqlCommand("SELECT Id, Day FROM tbl_days", conn);
                    SqlDataReader sqldrGetDays = cmdGetDays.ExecuteReader();
                    while (sqldrGetDays.Read())
                    {
                        ddlDay.Items.Add(new ListItem(sqldrGetDays[1].ToString(), sqldrGetDays[0].ToString()));
                    }
                    sqldrGetClassTypes.Close();

                    ddlCourse.Items.Insert(0, new ListItem("-- Please Select A School --", "0"));
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }

                
            }
        }

        //ddl school change populates course on chaneg
        protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get school
                SqlCommand cmdGetCourse = new SqlCommand("SELECT Id, Name FROM tbl_course WHERE SchoolId = @schoolId", conn);
                cmdGetCourse.Parameters.AddWithValue("@schoolId", Convert.ToInt32(ddlSchool.SelectedValue));
                SqlDataReader sqldrGetCourse = cmdGetCourse.ExecuteReader();
                while (sqldrGetCourse.Read())
                {
                    ddlCourse.Items.Add(new ListItem(sqldrGetCourse[1].ToString(), sqldrGetCourse[0].ToString()));
                }
                sqldrGetCourse.Close();
                conn.Close();
            }
            
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["s_courseId"] = ddlCourse.SelectedValue;
        }

        //modules row command
        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "cmdViewEvents")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;


                lblModuleName.Text = clickedRow.Cells[3].Text;
                Session["s_moduleId"] = clickedRow.Cells[0].Text;

                gvEvents.DataBind();

                HideAllPanels();
                pnlEvents.Visible = true;

            }
        }

        //events row command    
        protected void gvEvents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "cmdEditEvent")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_eventId"] = clickedRow.Cells[0].Text;

                string eventTypeId = clickedRow.Cells[5].Text;
                string dayId = clickedRow.Cells[6].Text;

                txtTime.Text = clickedRow.Cells[3].Text;
                txtLocation.Text = clickedRow.Cells[4].Text;

                ddlEventType.ClearSelection();
                ddlEventType.Items.FindByValue(eventTypeId).Selected = true;

                ddlDay.ClearSelection();
                ddlDay.Items.FindByValue(dayId).Selected = true;

                HideAllPanels();
                pnlEditEvents.Visible = true;

            }

            if(e.CommandName == "cmdDeleteEvent")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                int eventId = Convert.ToInt32(clickedRow.Cells[0].Text);


                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdDeleteEvent = new SqlCommand("DELETE FROM tbl_timeTable WHERE Id = @id", conn);
                    cmdDeleteEvent.Parameters.AddWithValue("@id", eventId);
                    try
                    {
                        cmdDeleteEvent.ExecuteNonQuery();
                    }
                    catch(Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        gvEvents.DataBind();
                        lblSuccess.Text = "Event Has Been Deleted";
                    }
                }


            }
        }

        //update event
        protected void btnUpdateEvent_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdUpdateEvent = new SqlCommand("UPDATE tbl_timeTable SET ClassTypeId = @classTypeId, Time = @time, DayId = @dayId, Location = @location WHERE Id = @eventId", conn);
                cmdUpdateEvent.Parameters.AddWithValue("@classTypeId", Convert.ToInt32(ddlEventType.SelectedValue));
                cmdUpdateEvent.Parameters.AddWithValue("@time", txtTime.Text);
                cmdUpdateEvent.Parameters.AddWithValue("@dayId",Convert.ToInt32(ddlDay.SelectedValue));
                cmdUpdateEvent.Parameters.AddWithValue("@location", txtLocation.Text);

                cmdUpdateEvent.Parameters.AddWithValue("@eventId", Convert.ToInt32(Session["s_eventId"]));

                cmdUpdateEvent.ExecuteNonQuery();

                

                gvEvents.DataBind();

                HideAllPanels();
                lblSuccess.Text = "Success The Event Has Been Updates";
                pnlEvents.Visible = true;
            }
            
        }

        
    }
}