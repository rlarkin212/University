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
    public partial class CreateASpriint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CalendarStart.Visible = false;
            CalendarEnd.Visible = false;

            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void CalendarStart_SelectionChanged(object sender, EventArgs e)
        {
            string day = CalendarStart.SelectedDate.Day.ToString() ;
            string month = CalendarStart.SelectedDate.Month.ToString();
            string year = CalendarStart.SelectedDate.Year.ToString();
            lblSDate.Text = day +"/" +month +"/" +year;
            CalendarStart.Visible = false;
        }
        protected void CalendarStart_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date < DateTime.Today)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = Color.Gray;
            }
        }

        protected void btnStart_Click(object sender, EventArgs e)
        {
            CalendarStart.Visible = true;
        }

        protected void CalendarEnd_SelectionChanged(object sender, EventArgs e)
        {
            string day = CalendarEnd.SelectedDate.Day.ToString();
            string month = CalendarEnd.SelectedDate.Month.ToString();
            string year = CalendarEnd.SelectedDate.Year.ToString();
            lblEDate.Text = day + "/" + month + "/" + year;
            CalendarEnd.Visible = false;
        }

        protected void btnEnd_Click(object sender, EventArgs e)
        {
            CalendarEnd.Visible = true;
        }
        protected void CalendarEnd_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date < CalendarStart.SelectedDate)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = Color.Gray;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Int32 proId = Convert.ToInt32(Session["s_projectId"]);
            DateTime startDate = DateTime.Parse(lblSDate.Text);
            DateTime endDate = DateTime.Parse(lblEDate.Text);

            string sqlInsertSprint = "INSERT INTO tbl_Sprints ([Project_Id], [Sprint_Name], [Start],[End]) VALUES (@proid, @sprintName, @start, @end)";
            SqlCommand cmdInsertSprint = new SqlCommand(sqlInsertSprint, Connections.ApplicationConnection());

            cmdInsertSprint.Parameters.AddWithValue("@proid", proId);
            cmdInsertSprint.Parameters.AddWithValue("@sprintName", txtSprintName.Text);
            cmdInsertSprint.Parameters.AddWithValue("@start", startDate);
            cmdInsertSprint.Parameters.AddWithValue("@end", endDate);

            cmdInsertSprint.ExecuteNonQuery();

            txtSprintName.Text = "";
            lblEDate.Text = "";
            lblSDate.Text = "";

            Response.Redirect("Sprints.aspx");
        }
    }
}