using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMStaffNumbersReport : System.Web.UI.Page
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

            GetStaffStats();
            if (!IsPostBack)
            {
                lblChartType.Text = "bar";
            }
        }

        private void GetStaffStats()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGet20 = new SqlCommand("SELECT COUNT(Role) FROM tbl_user WHERE Role = 20", conn);
                SqlCommand cmdGet30 = new SqlCommand("SELECT COUNT(Role) FROM tbl_user WHERE Role = 30", conn);
                SqlCommand cmdGet40 = new SqlCommand("SELECT COUNT(Role) FROM tbl_user WHERE Role = 40", conn);
                SqlCommand cmdGet50 = new SqlCommand("SELECT COUNT(Role) FROM tbl_user WHERE Role = 50", conn);
                SqlCommand cmdGet60 = new SqlCommand("SELECT COUNT(Role) FROM tbl_user WHERE Role = 60", conn);

                lblTwenty.Text = Convert.ToString(cmdGet20.ExecuteScalar());
                lblThirty.Text = Convert.ToString(cmdGet30.ExecuteScalar());
                lblFourty.Text = Convert.ToString(cmdGet40.ExecuteScalar());
                lblFifty.Text = Convert.ToString(cmdGet50.ExecuteScalar());
                lblSixty.Text = Convert.ToString(cmdGet60.ExecuteScalar());



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
