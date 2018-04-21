using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Academic
{
    public partial class AcademicChangeModuleDescription : System.Web.UI.Page
    {
        private void hideAllPanels()
        {
            pnlModules.Visible = false;
            pnlDescription.Visible = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                //!= to academic program manager
                if (Session["s_loggedUserRole"].ToString() == "40")
                {
                    
                }
                else if (Session["s_loggedUserRole"].ToString() == "30")
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

        protected void gvModules_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdEditDescription")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_moduleId"] = clickedRow.Cells[0].Text;
                txtDescription.Text = clickedRow.Cells[3].Text;

                hideAllPanels();
                pnlDescription.Visible = true;

            }
        }

        protected void btnUpdateDescription_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdUpdateDescription = new SqlCommand("INSERT INTO tbl_pendingModuleDescriptionChanges (ModuleId, AcademicId,PendingChanges) VALUES (@moduleId, @academicId, @pendingChanges)", conn);
                cmdUpdateDescription.Parameters.AddWithValue("@moduleId", Convert.ToInt32(Session["s_moduleId"]));
                cmdUpdateDescription.Parameters.AddWithValue("@academicId", Convert.ToInt32(Session["s_loggedUserId"]));
                cmdUpdateDescription.Parameters.AddWithValue("@pendingChanges", Convert.ToString(txtDescription.Text));

                try
                {
                    cmdUpdateDescription.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                    txtDescription.Text = "";
                    lblSuccessMessage.Text = "Your changes have been submitted to be reviewed by an academic program manager";
                    hideAllPanels();
                    pnlModules.Visible = true;
                }
            }
        }
    }
}