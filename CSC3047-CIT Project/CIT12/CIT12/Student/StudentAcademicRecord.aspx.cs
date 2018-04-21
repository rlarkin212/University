using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Student
{
    public partial class StudentAcademicRecord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "10")
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void gvAcademicRecord_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
                gridView.HeaderRow.Cells[1].Visible = false;
                gridView.HeaderRow.Cells[3].Visible = false;
            }

            foreach (GridViewRow row in gvAcademicRecord.Rows)
            {
                row.Cells[0].Visible = false;
                row.Cells[1].Visible = false;
                row.Cells[2].Visible = false;
            }
        }
    }
}