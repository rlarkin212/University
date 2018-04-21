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
    public partial class SuperUserSetStartOfYear : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {




            calDeadlineDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
            calDeadlineDate.VisibleDate = Convert.ToDateTime(DateTime.Now.ToString());
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
        protected void calDeadlineDate_SelectionChanged(object sender, EventArgs e)
        {
            txtStartDate.Text = calDeadlineDate.SelectedDate.ToShortDateString();
            string selectedDate = txtStartDate.Text;

            bool validDate = IsDateBeforeOrToday(selectedDate);

            if (validDate == false)
            {
                lblError.Text = "Please Enter A Date Greater Than The Current Date";
                btnSubmitDate.Enabled = false;
            }
            else
            {
                lblError.Text = "";
                btnSubmitDate.Enabled = true;
            }

        }

        protected void btnSubmitDate_Click(object sender, EventArgs e)
        {

            using (SqlConnection conn  = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertStartDate = new SqlCommand("INSERT INTO tbl_academicYearStart (StartDate) VALUES (@startDate)", conn);
                cmdInsertStartDate.Parameters.AddWithValue("@startDate", Convert.ToDateTime(txtStartDate.Text));

                try
                {
                    cmdInsertStartDate.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                    txtStartDate.Text = "";
                    lblError.CssClass = "text-success";
                    lblError.Text = "Success The Start Date Has Been Set";
                }
            }



        }
    }
}