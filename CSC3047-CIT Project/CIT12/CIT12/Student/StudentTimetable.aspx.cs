using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Student
{
    public partial class StudentTimetable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "10")
            {
                Response.Redirect("~/Default.aspx");
            }

            //number and name
            string number = Session["s_loggedNumber"].ToString();
            string name;

            //ssql get name
            string sqlGetName = "SELECT CONCAT(Forename,' ',Surname) AS FullName From tbl_user WHERE Id=@id";
            using (var cnn = Connections.ApplicationConnection())
            {
                using (var cmdGetName = new SqlCommand(sqlGetName, cnn))
                {
                    cmdGetName.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_loggedUserId"]));
                    name = Convert.ToString(cmdGetName.ExecuteScalar());

                }
            }

            lblStudentNumber.Text = number + " - " + name;

            calDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
            calDate.VisibleDate = Convert.ToDateTime(DateTime.Now.ToString());
        }

        protected void gvStudentTimetable_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
                gridView.HeaderRow.Cells[1].Visible = false;
                gridView.HeaderRow.Cells[2].Visible = false;
            }

            foreach (GridViewRow row in gvStudentTimetable.Rows)
            {
                row.Cells[0].Visible = false;
                row.Cells[1].Visible = false;
                row.Cells[2].Visible = false;
            }
        }

        // add event
        protected void btnAddAdditionalEvent_Click(object sender, EventArgs e)
        {
            pnlAdditionalEvents.Visible = false;
            pnlAddEvent.Visible = true;
        }
        //refresh Events
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            string currentDate = DateTime.Now.ToShortDateString();

            foreach (GridViewRow row in gvAdditionalEvents.Rows)
            {
                string date = row.Cells[2].Text.ToString();
                string id = row.Cells[5].Text.ToString();
                bool valid = IsDateBeforeOrToday(date);

                if(valid == false)
                {
                    using (SqlConnection conn = Connections.ApplicationConnection())
                    {
                        SqlCommand cmdDeleteOldEvents = new SqlCommand("DELETE FROM tbl_additionalEvents WHERE Id = @id",conn);
                        cmdDeleteOldEvents.Parameters.AddWithValue("@id", Convert.ToInt32(id));

                        try
                        {
                            cmdDeleteOldEvents.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                        finally
                        {
                            conn.Close();
                            gvAdditionalEvents.DataBind();
                        }
                    }
                }
                
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
                btnSubmitEvent.Enabled = false;
            }
            else
            {
                lblError.Text = "";
                btnSubmitEvent.Enabled = true;
            }
        }

        //add event 
        protected void btnSubmitEvent_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertEvent = new SqlCommand("INSERT INTO tbl_additionalEvents (Title,Description,Date,Time,UserId,Location) VALUES (@title,@description,@date,@time,@userId,@location)", conn);
                cmdInsertEvent.Parameters.AddWithValue("@title", txtTitle.Text);
                cmdInsertEvent.Parameters.AddWithValue("@description", txtDescription.Text);
                cmdInsertEvent.Parameters.AddWithValue("@date", Convert.ToDateTime(txtDate.Text));
                cmdInsertEvent.Parameters.AddWithValue("@time", txtTime.Text);
                cmdInsertEvent.Parameters.AddWithValue("@userId", Convert.ToInt32(Session["s_loggedUserId"]));
                cmdInsertEvent.Parameters.AddWithValue("@location", txtLocation.Text);

                try
                {
                    cmdInsertEvent.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    txtTitle.Text = "";
                    txtDescription.Text = "";
                    txtDate.Text = "";
                    txtTime.Text = "";
                    txtLocation.Text = "";

                    gvAdditionalEvents.DataBind();
                    pnlAddEvent.Visible = false;
                    pnlAdditionalEvents.Visible = true;

                    conn.Close();
                }
                
            }
        }

        
    }
}