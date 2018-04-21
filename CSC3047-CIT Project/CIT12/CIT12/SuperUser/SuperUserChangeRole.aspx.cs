using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.SuperUser
{
    public partial class SuperUserChangeRole : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "60")
            {
                Response.Redirect("~/Default.aspx");
            }


            if (!IsPostBack)
            {
                PopulateDropDowns();
            }

            calDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
            calDate.VisibleDate = Convert.ToDateTime(DateTime.Now.ToString());

            this.Page.Form.DefaultButton = btnSearch.UniqueID;
            this.Page.Form.DefaultFocus = txtNumberSearch.ClientID;
        }

        private void HideAllPanels()
        {
            pnlUsers.Visible = false;
            pnlChangeRole.Visible = false;
            pnlRevertRoleChange.Visible = false;
        }

        private void PopulateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get roles
                SqlCommand cmdGetRoles = new SqlCommand("SELECT RoleCode, Role FROM tbl_role", conn);
                SqlDataReader sqldrGetRole = cmdGetRoles.ExecuteReader();
                try
                {
                    ddlRole.Items.Clear();
                    while (sqldrGetRole.Read())
                    {
                        ddlRole.Items.Add(new ListItem(sqldrGetRole[1].ToString(), sqldrGetRole[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetRole.Close();
                    conn.Close();
                }
            }
        }
    

        //chaneg role on click
        protected void btnChangeRole_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlUsers.Visible = true;
        }
        //view changed roles on click
        protected void btnViewChangedUserRole_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlRevertRoleChange.Visible = true;
        }

        //--------------------------change users role------------------------------
        //users gv role command
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdChangeRole")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_userId"] = clickedRow.Cells[0].Text;
                Session["s_previousRoleCode"] = clickedRow.Cells[1].Text;
                Session["s_previousRole"] = clickedRow.Cells[4].Text;
                lblUserName.Text = "User - " + clickedRow.Cells[3].Text;

                ddlRole.ClearSelection();
                ddlRole.Items.FindByValue(clickedRow.Cells[1].Text).Selected = true;


                HideAllPanels();
                pnlChangeRole.Visible = true;
               

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
        protected void calDate_SelectionChanged(object sender, EventArgs e)
        {
            txtDate.Text = calDate.SelectedDate.ToShortDateString();
            string selectedDate = txtDate.Text;

            bool validDate = IsDateBeforeOrToday(selectedDate);

            if (validDate == false)
            {
                lblError.Text = "Please Enter A Date Greater Than The Current Date";
                btnSubmitRoleChange.Enabled = false;
            }
            else
            {
                lblError.Text = "";
                btnSubmitRoleChange.Enabled = true;
            }
        }

        //submit role change 
        protected void btnSubmitRoleChange_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //inserts the change into a temp table so can be reverted
                SqlCommand cmdInsertTempStatus = new SqlCommand("INSERT INTO tbl_roleChangeTemp (UserId, PreviousRoleCode, NewRoleCode, DeadlineDate, PreviousRole, NewRole) VALUES (@userId, @previousRoleCode, @newRoleCode, @deadlineDate, @previousRole, @newRole)", conn);
                cmdInsertTempStatus.Parameters.AddWithValue("@userId", Convert.ToInt32(Session["s_userId"]));
                cmdInsertTempStatus.Parameters.AddWithValue("@previousRoleCode", Convert.ToInt32(Session["s_previousRoleCode"]));
                cmdInsertTempStatus.Parameters.AddWithValue("@newRoleCode", Convert.ToInt32(ddlRole.SelectedValue));
                cmdInsertTempStatus.Parameters.AddWithValue("@deadlineDate", Convert.ToDateTime(txtDate.Text));
                cmdInsertTempStatus.Parameters.AddWithValue("@previousRole", Convert.ToString(Session["s_previousRole"]));
                cmdInsertTempStatus.Parameters.AddWithValue("@newRole", Convert.ToString(ddlRole.SelectedItem.Text));


                //changes role code in tbl_user
                SqlCommand cmdUpdateRole = new SqlCommand("UPDATE tbl_user SET Role = @role WHERE Id = @id", conn);
                cmdUpdateRole.Parameters.AddWithValue("@role", Convert.ToInt32(ddlRole.SelectedValue));
                cmdUpdateRole.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_userId"]));

                try
                {
                    cmdInsertTempStatus.ExecuteNonQuery();
                    cmdUpdateRole.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();

                    ddlRole.ClearSelection();
                    txtDate.Text = "";
                    lblMessage.Text = "Success, The Users Role Has Been Changed";

                    gvUsers.DataBind();
                    gvRevertRoleChange.DataBind();
                    HideAllPanels();
                    pnlUsers.Visible = true;
                  

                }


            }

        }

        //----------------- revert role change --------------------------------------

            //on row data bound set overdue chage deadlines to red
        protected void gvRevertRoleChange_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            bool validDate = false;

            foreach (GridViewRow row in gvRevertRoleChange.Rows)
            {

                for (int i = 0; i < gvRevertRoleChange.Columns.Count; i++)
                {
                    
                    DateTime endDate = Convert.ToDateTime(row.Cells[6].Text);
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
                    row.Cells[6].CssClass = "text-danger";
                }

            }
        }

        //refresh role changes
        protected void btnRefreshRole_Click(object sender, EventArgs e)
        {
            string currentDate = DateTime.Now.ToShortDateString();

            foreach (GridViewRow row in gvRevertRoleChange.Rows)
            {
                string date = row.Cells[6].Text.ToString();
                string id = row.Cells[0].Text.ToString();
                bool valid = IsDateBeforeOrToday(date);

                if (valid == false)
                {
                    using (SqlConnection conn = Connections.ApplicationConnection())
                    {
                        SqlCommand cmdRevertRoleChange = new SqlCommand("UPDATE tbl_user SET Role = @role Where Id = @id",conn);
                        cmdRevertRoleChange.Parameters.AddWithValue("@role", Convert.ToInt32(row.Cells[1].Text));
                        cmdRevertRoleChange.Parameters.AddWithValue("@id", Convert.ToInt32(row.Cells[0].Text));

                        SqlCommand cmdDeleteChangeRecord = new SqlCommand("DELETE FROM tbl_roleChangeTemp WHERE Id = @id",conn);
                        cmdDeleteChangeRecord.Parameters.AddWithValue("@id", Convert.ToInt32(row.Cells[7].Text));

                        try
                        {
                            cmdRevertRoleChange.ExecuteNonQuery();
                            cmdDeleteChangeRecord.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                        finally
                        {
                            
                            lblRevertSuccess.Text = "Success, Roles Changes Has Been Reverted";
                            gvRevertRoleChange.DataBind();
                            gvUsers.DataBind();
                        }
                        
                    }
                    
                }

            }
        }

        //revert single deadline
        protected void gvRevertRoleChange_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdRevertChanges")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdRevertRoleChange = new SqlCommand("UPDATE tbl_user SET Role = @role Where Id = @id", conn);
                    cmdRevertRoleChange.Parameters.AddWithValue("@role", Convert.ToInt32(clickedRow.Cells[1].Text));
                    cmdRevertRoleChange.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[0].Text));

                    SqlCommand cmdDeleteChangeRecord = new SqlCommand("DELETE FROM tbl_roleChangeTemp WHERE Id = @id", conn);
                    cmdDeleteChangeRecord.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[7].Text));

                    try
                    {
                        cmdRevertRoleChange.ExecuteNonQuery();
                        cmdDeleteChangeRecord.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        lblRevertSuccess.Text = "Success, Role Change Has Been Reverted";
                        gvRevertRoleChange.DataBind();
                        gvUsers.DataBind();
                    }

                }


            }
        }

        
    }
}