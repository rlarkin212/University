using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMStudentStatusStats : System.Web.UI.Page
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
                SqlCommand cmdNormal = new SqlCommand("SELECT COUNT(StatusId) FROM tbl_studentUser WHERE StatusId = 1", conn);
                SqlCommand cmdWithdrawn = new SqlCommand("SELECT COUNT(StatusId) FROM tbl_studentUser WHERE StatusId = 2", conn);
                SqlCommand cmdTempWithdrawn = new SqlCommand("SELECT COUNT(StatusId) FROM tbl_studentUser WHERE StatusId = 3", conn);
                SqlCommand cmdSuspended = new SqlCommand("SELECT COUNT(StatusId) FROM tbl_studentUser WHERE StatusId = 4", conn);

                lblNormal.Text = Convert.ToString(cmdNormal.ExecuteScalar());
                lblWithdrwn.Text = Convert.ToString(cmdWithdrawn.ExecuteScalar());
                lblTemporallyWithdrawn.Text = Convert.ToString(cmdTempWithdrawn.ExecuteScalar());
                lblSuspended.Text = Convert.ToString(cmdSuspended.ExecuteScalar());

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