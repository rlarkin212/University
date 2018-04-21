using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMMarkDistributionReportaspx : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "50")
            {
                if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }

            GetMarkStats();
            if (!IsPostBack)
            {
                lblChartType.Text = "bar";
            }
        }

        protected void btnBar_Click(object sender, EventArgs e)
        {
            lblChartType.Text = "bar";
        }

        protected void btnPie_Click(object sender, EventArgs e)
        {
            lblChartType.Text = "doughnut";
        }

        private void GetMarkStats()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetFail = new SqlCommand("SELECT COUNT(Classification) FROM tbl_academicRecord WHERE Classification = @fail", conn);
                cmdGetFail.Parameters.AddWithValue("@fail", "Fail".ToString());
                SqlCommand cmdGet3rd = new SqlCommand("SELECT COUNT(Classification) FROM tbl_academicRecord WHERE Classification = @3", conn);
                cmdGet3rd.Parameters.AddWithValue("@3", "3rd".ToString());
                SqlCommand cmdGet22 = new SqlCommand("SELECT COUNT(Classification) FROM tbl_academicRecord WHERE Classification = @22", conn);
                cmdGet22.Parameters.AddWithValue("@22", "2:2".ToString());
                SqlCommand cmdGet21 = new SqlCommand("SELECT COUNT(Classification) FROM tbl_academicRecord WHERE Classification = @21", conn);
                cmdGet21.Parameters.AddWithValue("@21", "2:1".ToString());
                SqlCommand cmdGet1st = new SqlCommand("SELECT COUNT(Classification) FROM tbl_academicRecord WHERE Classification = @1", conn);
                cmdGet1st.Parameters.AddWithValue("@1", "1st".ToString());

                //lblFail.Text = Convert.ToString(cmdGetFail.ExecuteScalar());
                lbl3rd.Text = Convert.ToString(cmdGet3rd.ExecuteScalar());
                lbl2_2.Text = Convert.ToString(cmdGet22.ExecuteScalar());
                lbl2_1.Text = Convert.ToString(cmdGet21.ExecuteScalar());
                lbl1st.Text = Convert.ToString(cmdGet1st.ExecuteScalar());


                conn.Close();
            }
        }
    }
}