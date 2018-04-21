using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMStudentSearch : System.Web.UI.Page
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

            this.Page.Form.DefaultButton = btnSearch.UniqueID;
            this.Page.Form.DefaultFocus = txtStudentNumber.ClientID;
        }

        //hides panels
        private void hideAllPanels()
        {
            pnlStudent.Visible = false;
            pnlStudentDetails.Visible = false;
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdViewDetails")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_studentId"] = clickedRow.Cells[0].Text;

                hideAllPanels();
                pnlStudentDetails.Visible = true;

            }
        }

        protected void gvStudentAcademicRecord_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
            }

            foreach (GridViewRow row in gvStudentAcademicRecord.Rows)
            {
                row.Cells[0].Visible = false;
            }
        }
    }
}