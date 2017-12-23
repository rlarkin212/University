using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class AddAcceptance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }

        }


        protected void btnAddAcceptanceTest_Click(object sender, EventArgs e)
        {
            Int32 backlogId = Convert.ToInt32(Session["s_BacklogId"]);
            Int32 projectid = Convert.ToInt32(Session["s_projectId"]);
            String Test = txtTest.Text;
            Int32 complete = Convert.ToInt32(0);


            String sqlInsertAcceptanceTest = "INSERT INTO tbl_AcceptanceTest(ProjectId,BacklogId,Test,Passes) VALUES (@projectId, @backlogId, @test, @passes)";
            SqlCommand cmdInsertAcceptanceTest = new SqlCommand(sqlInsertAcceptanceTest, Connections.ApplicationConnection());

            cmdInsertAcceptanceTest.Parameters.AddWithValue("@projectId", projectid);
            cmdInsertAcceptanceTest.Parameters.AddWithValue("@backlogId", backlogId);
            cmdInsertAcceptanceTest.Parameters.AddWithValue("@test", Test);
            cmdInsertAcceptanceTest.Parameters.AddWithValue("@passes", complete);

            cmdInsertAcceptanceTest.ExecuteNonQuery();
            txtTest.Text = "";
            gvAcceptanceTests.DataBind();

        }

        protected void gvAcceptanceTests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell passsesCell = e.Row.Cells[4];
                if (passsesCell.Text == "0")
                {
                    passsesCell.Text = "Did Not Pass";
                }
                else
                {
                    passsesCell.Text = "Pass";
                }
            }
        }

        protected void gvAcceptanceTests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Passed")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;


                String sqlUpdatePassed = "UPDATE tbl_AcceptanceTest SET Passes = @passes WHERE Id = @id";
                SqlCommand cmdUpdatePassed = new SqlCommand(sqlUpdatePassed, Connections.ApplicationConnection());

                cmdUpdatePassed.Parameters.AddWithValue("@passes", 1);
                cmdUpdatePassed.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[0].Text));

                cmdUpdatePassed.ExecuteNonQuery();
                gvAcceptanceTests.DataBind();
                
            }
        }



    }
}
