using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace CIT12
{
    public partial class ProductBacklog : System.Web.UI.Page
    {

        protected void hideAllPanels()
        {
            pnlBacklog.Visible = false;
            pnlAddUserStory.Visible = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }


            string projectTitle = "";
            string sqlSelectProjectTitle = "SELECT Title FROM tbl_Projects WHERE Id = @id";

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmd = new SqlCommand(sqlSelectProjectTitle, conn);
                cmd.Parameters.AddWithValue("@id", Session["s_projectId"]);

                try
                {
                    conn.Open();
                    projectTitle = (String)cmd.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                }


            }


        }


        protected void btnAddStory_Click(object sender, EventArgs e)
        {
            hideAllPanels();
            pnlAddUserStory.Visible = true;
        }


        protected void btnInsertUserStory_Click(object sender, EventArgs e)
        {

            hideAllPanels();
            pnlAddUserStory.Visible = true;

            int projectId = Convert.ToInt32(Session["s_ProjectId"]);

            string sqlInsertUserStory = "INSERT INTO tbl_ProductBacklog (ProjectId,UserStory,Value) VALUES(@projectId,@userStory,@value)";
            SqlCommand cmdInsertUserStory = new SqlCommand(sqlInsertUserStory, Connections.ApplicationConnection());

            cmdInsertUserStory.Parameters.AddWithValue("@projectId", projectId);
            cmdInsertUserStory.Parameters.AddWithValue("@userStory", txtUserStory.Text.ToString());
            cmdInsertUserStory.Parameters.AddWithValue("@value", Convert.ToInt32(txtMarketValue.Text));

            cmdInsertUserStory.ExecuteNonQuery();

            txtUserStory.Text = "";
            txtMarketValue.Text = "";

            hideAllPanels();
            pnlBacklog.Visible = true;

            gvProductBacklog.DataBind();

        }

        protected void gvProductBacklog_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddAcceptanceTest")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_BacklogId"] = clickedRow.Cells[0].Text;

                Response.Redirect("AddAcceptance.aspx");
            }
        }

    }
}