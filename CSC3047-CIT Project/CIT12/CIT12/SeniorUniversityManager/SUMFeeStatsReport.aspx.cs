using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMFeeStatsReport : System.Web.UI.Page
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

            GetFeeStats();
            if (!IsPostBack)
            {
                lblChartType.Text = "bar";
            }
        }

        private void GetFeeStats()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetPaid = new SqlCommand("SELECT COUNT(FeesPaid) FROM tbl_studentUser WHERE FeesPaid = 1", conn);
                SqlCommand cmdGetPartiallyPaid = new SqlCommand("SELECT COUNT(FeesPaid) FROM tbl_studentUser WHERE FeesPaid = 2", conn);
                SqlCommand cmdGetNotPaid = new SqlCommand("SELECT COUNT(FeesPaid) FROM tbl_studentUser WHERE FeesPaid = 0", conn);

                lblFullyPaid.Text = Convert.ToString(cmdGetPaid.ExecuteScalar());
                lblPartiallyPaid.Text = Convert.ToString(cmdGetPartiallyPaid.ExecuteScalar());
                lblNotPaid.Text = Convert.ToString(cmdGetNotPaid.ExecuteScalar());


                conn.Close();
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
    }
}