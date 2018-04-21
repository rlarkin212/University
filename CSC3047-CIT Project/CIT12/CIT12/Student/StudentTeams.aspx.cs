using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Student
{
    public partial class StudentTeams : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "10")
            {
                Response.Redirect("~/Default.aspx");
            }

            if (!IsPostBack)
            {
                PopulateDropDowns();
            }


            calDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
            calDate.VisibleDate = Convert.ToDateTime(DateTime.Now.ToString());
        }

        private void HideAllPanels()
        {
            pnlTeams.Visible = false;
            pnlCreateTeam.Visible = false;
            pnlTeamMembers.Visible = false;
            pnlAddTeamMembers.Visible = false;
            pnlCreateEvent.Visible = false;
            pnlSendEmail.Visible = false;
        }

        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get modules
                SqlCommand cmdGetModules = new SqlCommand("SELECT DISTINCT tbl_modules.Id, tbl_modules.Title FROM tbl_studentModule INNER JOIN tbl_modules ON tbl_studentModule.ModuleId = tbl_modules.Id WHERE (tbl_studentModule.StudentId = @loggedUserId) AND (tbl_studentModule.Complete = 0)", conn);
                cmdGetModules.Parameters.AddWithValue("@loggedUserId", Convert.ToInt32(Session["s_loggedUserId"]));
                SqlDataReader sqldrGetModules = cmdGetModules.ExecuteReader();
                try
                {
                    ddlModules.Items.Clear();
                    ddlModules.Items.Insert(0, new ListItem("-- Select Module --", "0"));
                    while (sqldrGetModules.Read())
                    {
                        ddlModules.Items.Add(new ListItem(sqldrGetModules[1].ToString(), sqldrGetModules[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetModules.Close();
                    conn.Close();
                }
            }
        }

        //create team on click
        protected void btnCreateNewTeam_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlCreateTeam.Visible = true;
        }

        //groups row command
        protected void gvTeams_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdViewTeamMembers")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_teamId"] = clickedRow.Cells[0].Text;
                lblTeamName.Text = clickedRow.Cells[2].Text;

                HideAllPanels();
                pnlTeamMembers.Visible = true;
            }


            if (e.CommandName == "cmdLeaveTeam")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                int teamId = Convert.ToInt32(clickedRow.Cells[0].Text);


                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdLeaveTeam = new SqlCommand("DELETE FROM tbl_studentTeamMembers WHERE TeamId = @teamId AND MemberId = @memberId", conn);
                    cmdLeaveTeam.Parameters.AddWithValue("@teamId", Convert.ToInt32(teamId));
                    cmdLeaveTeam.Parameters.AddWithValue("@memberId", Convert.ToInt32(Session["s_loggedUserId"]));

                    try
                    {
                        cmdLeaveTeam.ExecuteNonQuery();
                    }
                    catch(Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        gvTeams.DataBind();
                    }
                }


            }
        }
        //--------------------Create a team------------------------------------------
        //create team row command
        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdCreateTeam")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;


                string moduleTitle = clickedRow.Cells[1].Text;
                TextBox txtTeamName = (TextBox)clickedRow.FindControl("txtTeamName");

                string teamName = moduleTitle + " - " + txtTeamName.Text;

                //insert into tbl_studentTeams
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdInsertTeam = new SqlCommand("INSERT INTO tbl_studentTeams (ModuleId, TeamName) VALUES (@moduleId, @teamName)", conn);
                    cmdInsertTeam.Parameters.AddWithValue("@moduleId", Convert.ToInt32(clickedRow.Cells[0].Text));
                    cmdInsertTeam.Parameters.AddWithValue("@teamName", Convert.ToString(teamName));
                    try
                    {
                        cmdInsertTeam.ExecuteNonQuery();
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

                //get the team id of the last created 
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdGetIdOfCreatedTeam = new SqlCommand("SELECT Id FROM tbl_studentTeams WHERE ModuleId = @moduleId AND TeamName = @teamName", conn);
                    cmdGetIdOfCreatedTeam.Parameters.AddWithValue("@moduleId", Convert.ToInt32(clickedRow.Cells[0].Text));
                    cmdGetIdOfCreatedTeam.Parameters.AddWithValue("@teamName", Convert.ToString(teamName));
                    try
                    {
                        Session["s_createdTeamId"] = Convert.ToString(cmdGetIdOfCreatedTeam.ExecuteScalar());
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

                //insert logged user as first team members
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdInsertTeamMember = new SqlCommand("INSERT INTO tbl_studentTeamMembers (TeamId, MemberId) VALUES (@teamId, @memberId)", conn);
                    cmdInsertTeamMember.Parameters.AddWithValue("@teamId", Convert.ToInt32(Session["s_createdTeamId"]));
                    cmdInsertTeamMember.Parameters.AddWithValue("@memberId", Convert.ToInt32(Session["s_loggedUserId"]));
                    try
                    {
                        cmdInsertTeamMember.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        txtTeamName.Text = "";
                        lblCreateTeamSuccess.Text = "Your Team Has Been Successfully Created !";
                    }
                }


            }
        }

        //----------------Add team members--------------------------------------
        protected void btnAddTeamMembers_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlAddTeamMembers.Visible = true;

            lblAddMembersTeamName.Text = lblTeamName.Text;
        }



        //add team members module selected change
        protected void ddlModules_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["s_ddlModuleId"] = ddlModules.SelectedValue;
            gvStudents.DataBind();
        }

        //gv students row command
        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var clickedButton = e.CommandSource as Button;
            var clickedRow = clickedButton.NamingContainer as GridViewRow;

            if (e.CommandName == "cmdAddToTeam")
            {
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdAddToTeam = new SqlCommand("INSERT INTO tbl_studentTeamMembers (TeamId, MemberId) Values(@teamId, @membersId)", conn);
                    cmdAddToTeam.Parameters.AddWithValue("@teamId", Convert.ToInt32(Session["s_teamId"]));
                    cmdAddToTeam.Parameters.AddWithValue("@membersId", Convert.ToInt32(clickedRow.Cells[0].Text));
                    try
                    {
                        cmdAddToTeam.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        string emailHeader = "Added To Team";
                        string emailSubject = "You Have Been Added To Team " + lblAddMembersTeamName.Text;
                        string emailBody = "You have been added as a team member to the team " + lblAddMembersTeamName.Text + ". You can now send group emails and ceate events.";
                        MailAddress mailAddress = new MailAddress(clickedRow.Cells[2].Text);
                        string emailFileName = "";
                        string emailFile = "";

                        //send email 
                        Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);


                        lblAddedToTeamSuccess.Text = " Success , Team Member Has Been Added ! ";
                        conn.Close();
                    }
                }
            }
        }

        //---------------create event---------------------------------

        protected void btnCreateEvent_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlCreateEvent.Visible = true;

            ArrayList eventListArray = new ArrayList();
            for (int i = 0; i < gvTeamMembers.Rows.Count; i++)
            {
                if (((CheckBox)gvTeamMembers.Rows[i].FindControl("cbInclude")).Checked)
                {
                    eventListArray.Add(gvTeamMembers.Rows[i].Cells[2].Text);

                }
            }

            Session["s_eventListArray"] = eventListArray;

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
        //submit event
        protected void btnSubmitEvent_Click(object sender, EventArgs e)
        {
            ArrayList eventStudentId = Session["s_eventListArray"] as ArrayList;

            //insert into tbl_additional events
            foreach (var id in eventStudentId)
            {
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdInsertEvent = new SqlCommand("INSERT INTO tbl_additionalEvents (Title, Description, Date, Time, UserId, Location) VALUES (@title, @description, @date, @time, @userId, @location)", conn);
                    cmdInsertEvent.Parameters.AddWithValue("@title", Convert.ToString(lblTeamName.Text + " - " + txtEventTitle.Text));
                    cmdInsertEvent.Parameters.AddWithValue("@description", Convert.ToString(txtDescription.Text));
                    cmdInsertEvent.Parameters.AddWithValue("@date", Convert.ToDateTime(txtDate.Text));
                    cmdInsertEvent.Parameters.AddWithValue("@time", Convert.ToString(txtTime.Text));
                    cmdInsertEvent.Parameters.AddWithValue("@userId", Convert.ToInt32(id));
                    cmdInsertEvent.Parameters.AddWithValue("@location", Convert.ToString(txtLocation.Text));

                    try
                    {
                        cmdInsertEvent.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {

                    }

                }
            }

            txtTitle.Text = "";
            txtDescription.Text = "";
            txtDate.Text = "";
            txtTime.Text = "";
            txtLocation.Text = "";

            HideAllPanels();
            pnlTeamMembers.Visible = true;

            lblTeamMembersSuccess.Text = "Success, Your Event Has Been Created !";
        }

        //---------------send email---------------------------------
        protected void btnEmail_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlSendEmail.Visible = true;

            ArrayList emailAddressList = new ArrayList();
            for (int i = 0; i < gvTeamMembers.Rows.Count; i++)
            {
                if (((CheckBox)gvTeamMembers.Rows[i].FindControl("cbInclude")).Checked)
                {
                    emailAddressList.Add(gvTeamMembers.Rows[i].Cells[1].Text);

                }
            }

            Session["s_emailAddressList"] = emailAddressList;

        }

        protected void btnSendEmail_Click(object sender, EventArgs e)
        {
            ArrayList emailAddress = Session["s_emailAddressList"] as ArrayList;

            foreach (var email in emailAddress)
            {
                string emailHeader = txtTitle.Text;
                string emailSubject = txtSubject.Text;
                string emailBody = txtBody.Text;
                MailAddress mailAddress = new MailAddress(email.ToString());
                string emailFileName = "";
                string emailFile = "";

                //send email 
                Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);
            }

            txtTitle.Text = "";
            txtSubject.Text = "";
            txtBody.Text = "";

            lblTeamMembersSuccess.Text = "Success, Your Emal Has Been Sent !";

            HideAllPanels();
            pnlTeamMembers.Visible = true;
        }


    }
}