using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMLevelAmount : System.Web.UI.Page
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

            GetLevelStats();
            if (!IsPostBack)
            {
                lblChartType.Text = "bar";
            }
        }

        private void GetLevelStats()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetLevel0 = new SqlCommand("SELECT COUNT(StudentLevel) FROM tbl_studentUser WHERE StudentLevel = 0", conn);
                SqlCommand cmdGetLevel1 = new SqlCommand("SELECT COUNT(StudentLevel) FROM tbl_studentUser WHERE StudentLevel = 1", conn);
                SqlCommand cmdGetLevel2 = new SqlCommand("SELECT COUNT(StudentLevel) FROM tbl_studentUser WHERE StudentLevel = 2", conn);
                SqlCommand cmdGetLevel3 = new SqlCommand("SELECT COUNT(StudentLevel) FROM tbl_studentUser WHERE StudentLevel = 3", conn);
                SqlCommand cmdGetLevel4 = new SqlCommand("SELECT COUNT(StudentLevel) FROM tbl_studentUser WHERE StudentLevel = 4", conn);

                lblLevel0.Text = Convert.ToString(cmdGetLevel0.ExecuteScalar());
                lblLevel1.Text = Convert.ToString(cmdGetLevel1.ExecuteScalar());
                lblLevel2.Text = Convert.ToString(cmdGetLevel2.ExecuteScalar());
                lblLevel3.Text = Convert.ToString(cmdGetLevel3.ExecuteScalar());
                lblLevel4.Text = Convert.ToString(cmdGetLevel4.ExecuteScalar());



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

        protected void btnLine_Click(object sender, EventArgs e)
        {
            lblChartType.Text = "line";
        }
    }
}