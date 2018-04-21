using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Diagnostics;

namespace CIT12.SuperUser
{
    public partial class SuperUserRemoveUsers : System.Web.UI.Page
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

            this.Page.Form.DefaultButton = btnSearch.UniqueID;
            this.Page.Form.DefaultFocus = txtUserNumber.ClientID;

        }

        private void HideAllPanels()
        {
            pnlRemoveUser.Visible = false;
            pnlAddUser.Visible = false;
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

        //user row command
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdRemoveUser")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdRemoveUser = new SqlCommand("DELETE FROM tbl_user WHERE Id = @id", conn);
                    cmdRemoveUser.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[0].Text));

                    SqlCommand cmdRemoveStudentUser = new SqlCommand("DELETE FROM tbl_studentUser WHERE StudentId = @studentId", conn);
                    cmdRemoveStudentUser.Parameters.AddWithValue("@studentId", Convert.ToInt32(clickedRow.Cells[0].Text));

                    SqlCommand cmdRemoveStaffUser = new SqlCommand("DELETE FROM tbl_staffUser WHERE StaffId = @staffId");
                    cmdRemoveStaffUser.Parameters.AddWithValue("@staffId", Convert.ToInt32(clickedRow.Cells[0].Text));

                    try
                    {
                        cmdRemoveUser.ExecuteNonQuery();

                        if (clickedRow.Cells[4].Text == "Student")
                        {
                            cmdRemoveStudentUser.ExecuteNonQuery();
                        }
                        else
                        {
                            cmdRemoveStudentUser.ExecuteNonQuery();
                        }

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        txtUserNumber.Text = "";
                        lblSuccess.Text = "Success The User Has Been Removed";
                        gvUsers.DataBind();
                    }

                }
            }
        }

        // ---------------------add user ----------------------
        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            //get last number from table
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetLastNumber = new SqlCommand("SELECT TOP 1 NUMBER FROM tbl_user ORDER BY Id Desc", conn);
                try
                {
                    int lastNumber = Convert.ToInt32(cmdGetLastNumber.ExecuteScalar());
                    int newNumber = lastNumber + 1;
                    txtNumber.Text = newNumber.ToString();
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
            HideAllPanels();
            pnlAddUser.Visible = true;
        }

        //submit user
        protected void btnSubmitUser_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertUser = new SqlCommand("INSERT INTO tbl_user (Forename, Surname, Role, Number, Password, EmailAddress) VALUES(@forename, @surname, @role, @number, @password, @emailAddress) ", conn);
                cmdInsertUser.Parameters.AddWithValue("@forename", Convert.ToString(txtForename.Text));
                cmdInsertUser.Parameters.AddWithValue("@surname", Convert.ToString(txtSurname.Text));
                cmdInsertUser.Parameters.AddWithValue("@role", Convert.ToInt32(ddlRole.SelectedValue));
                cmdInsertUser.Parameters.AddWithValue("@number", Convert.ToInt32(txtNumber.Text));
                cmdInsertUser.Parameters.AddWithValue("@password", Convert.ToString(Encrypt.Encryption(txtPassword.Text)));
                cmdInsertUser.Parameters.AddWithValue("@emailAddress", Convert.ToString(txtEmail.Text));

                try
                {
                    cmdInsertUser.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                    gvUsers.DataBind();

                    InsertNumberAdditionDetails();

                    
                    lblSuccess.Text = "Success, The User Has Been Added";
                    HideAllPanels();
                    pnlRemoveUser.Visible = true;

                }


            }
        }

        //inserts created user id into tbl_studentUser or tbl_staffUser for Additional Details
        private void InsertNumberAdditionDetails()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                

                SqlCommand cmdGetLastId = new SqlCommand("SELECT Id FROM tbl_user WHERE Forename = @forename AND Surname = @surname AND Number = @number", conn);
                cmdGetLastId.Parameters.AddWithValue("@forename", Convert.ToString(txtForename.Text));
                cmdGetLastId.Parameters.AddWithValue("@surname", Convert.ToString(txtSurname.Text));
                cmdGetLastId.Parameters.AddWithValue("@number", Convert.ToInt32(txtNumber.Text));

                

                try
                {
                    int id = Convert.ToInt32(cmdGetLastId.ExecuteScalar());

                    SqlCommand cmdInsertIdStudent = new SqlCommand("INSERT INTO tbl_studentUser (StudentId) VALUES (@studentId)", conn);
                    cmdInsertIdStudent.Parameters.AddWithValue("@studentId", Convert.ToInt32(id));

                    SqlCommand cmdInsertIdStaff = new SqlCommand("INSERT INTO tbl_staffUser (staffId) VALUES (@staffId)", conn);
                    cmdInsertIdStudent.Parameters.AddWithValue("@staffId", Convert.ToInt32(id));

                    if (ddlRole.SelectedItem.Text == "Student")
                    {
                        cmdInsertIdStudent.ExecuteNonQuery();
                    }
                    else
                    {
                        cmdInsertIdStaff.ExecuteNonQuery();
                    }

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();

                    txtForename.Text = "";
                    txtSurname.Text = "";
                    txtEmail.Text = "";
                    txtPassword.Text = "";
                    ddlRole.ClearSelection();
                }


            }
        }
    }
}