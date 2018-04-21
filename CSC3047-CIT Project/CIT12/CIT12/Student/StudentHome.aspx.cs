using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CIT12.Student
{
    public partial class StudentHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() !="10")
            {
                Response.Redirect("~/Default.aspx");
            }
            //number and name
            string number = Session["s_loggedNumber"].ToString();
            string name;
            DateTime startOfyear;

   

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetName = new SqlCommand("SELECT CONCAT(Forename,' ',Surname) AS FullName From tbl_user WHERE Id=@id", conn);
                cmdGetName.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_loggedUserId"]));

                SqlCommand cmdGetStartDate = new SqlCommand("SELECT TOP 1 StartDate FROM tbl_academicYearStart ORDER BY Id DESC", conn);


                try
                {
                    name = Convert.ToString(cmdGetName.ExecuteScalar());
                    startOfyear = Convert.ToDateTime(cmdGetStartDate.ExecuteScalar());
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }

            }

           //set label text
            lblStudent_Number.Text = number + " - " + name;

            DateTime currentDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            DateTime topDate = Convert.ToDateTime(startOfyear.AddDays(14).ToShortDateString());
            DateTime bottomDate = Convert.ToDateTime(startOfyear.AddDays(-14).ToShortDateString());

            Debug.WriteLine("CURRENT DATE : " + currentDate);
            Debug.WriteLine("STAT DATE : " + startOfyear);
            Debug.WriteLine("TOP DATE : " + topDate);
            Debug.WriteLine("BOTTOM DATE : " + bottomDate);


            if (currentDate > bottomDate && currentDate < topDate)
            {
                pnlEnrolement.Visible = true;
            }
            else
            {
                pnlEnrolement.Visible = false;
            }



        }
    }
}