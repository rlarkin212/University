using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Student
{
    public partial class StudentYourRoomBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "10")
            {
                Response.Redirect("~/Default.aspx");
            }

            Session["s_date"] = Convert.ToDateTime(DateTime.Now.ToShortDateString());
        }

        protected void gvYourBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "cmdCancelBooking")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdDeleteBooking = new SqlCommand("DELETE FROM tbl_roomBooking WHERE Id = @id AND StudentId = @studentId", conn);
                    cmdDeleteBooking.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[0].Text));
                    cmdDeleteBooking.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                    try
                    {
                        cmdDeleteBooking.ExecuteNonQuery();
                    }
                    catch(Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        lblSuccess.Text = "Success, Your Booking Has Been Canceled";
                        gvYourBookings.DataBind();
                    }
                }
            }
        }
    }
}