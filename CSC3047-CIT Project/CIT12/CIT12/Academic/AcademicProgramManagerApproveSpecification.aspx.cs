using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Net.Mail;

namespace CIT12.Academic
{
    public partial class AcademicProgramManagerApproveSpecification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                if (Session["s_loggedUserRole"].ToString() == "40")
                {

                }
                else if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }

            }
        }

        protected void gvSpecChanges_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var clickedButton = e.CommandSource as Button;
            var clickedRow = clickedButton.NamingContainer as GridViewRow;

            int moduleId = Convert.ToInt32(clickedRow.Cells[0].Text);
            int changerId = Convert.ToInt32(clickedRow.Cells[3].Text);
            int changeId = Convert.ToInt32(clickedRow.Cells[5].Text);
            string changes = clickedRow.Cells[6].Text;
            
            string moduleName = clickedRow.Cells[1].Text;

            //approve changes
            if (e.CommandName == "cmdApproveChanges")
            {
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    //update module description
                    SqlCommand cmdUpdateDescription = new SqlCommand("UPDATE tbl_modules SET ModuleDescription = @description WHERE Id = @id", conn);
                    cmdUpdateDescription.Parameters.AddWithValue("@id", moduleId);
                    cmdUpdateDescription.Parameters.AddWithValue("@description", changes);

                    //delete from pendig changes table
                    SqlCommand cmdDeleteChanges = new SqlCommand("DELETE FROM tbl_pendingModuleDescriptionChanges WHERE Id = @id ", conn);
                    cmdDeleteChanges.Parameters.AddWithValue("@id", changeId);

                    try
                    {
                        cmdUpdateDescription.ExecuteNonQuery();
                        cmdDeleteChanges.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        gvSpecChanges.DataBind();

                        lblError_Success.CssClass = "text-success";
                        lblError_Success.Text = "Description CHanges Have Been Successfully Approved And Updated";
                    }
                }
            }

            //deny changes
            if (e.CommandName == "cmdDenyChanges")
            {
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdDeleteChanges = new SqlCommand("DELETE FROM tbl_pendingModuleDescriptionChanges WHERE Id = @id ", conn);
                    cmdDeleteChanges.Parameters.AddWithValue("@id", changeId);

                    string address = "";
                    SqlCommand cmdGetEmailAddress = new SqlCommand("SELECT EmailAddress FROM tbl_user WHERE Id = @id", conn);
                    cmdGetEmailAddress.Parameters.AddWithValue("@id", changerId);
                    address = Convert.ToString(cmdGetEmailAddress.ExecuteScalar());

                    try
                    {
                        cmdDeleteChanges.ExecuteNonQuery();

                        //send email to requester with denial
                        string emailHeader = "Description Changes Denied";
                        string emailSubject = "Description Changes Denied For Module: " + moduleName;
                        string emailBody = "Your module description change of : " + changes + " has been denied by the module academic program manager.";
                        MailAddress mailAddress = new MailAddress(address.ToString());
                        string emailFileName = "";
                        string emailFile = "";
                        //send email 
                        Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);
                    }
                    catch(Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        gvSpecChanges.DataBind();

                        lblError_Success.CssClass = "text-danger";
                        lblError_Success.Text = "Description Changes Have Been Successfully Denied And Have Not Been Updated";

                    }
                }



            }
        }
    }
}