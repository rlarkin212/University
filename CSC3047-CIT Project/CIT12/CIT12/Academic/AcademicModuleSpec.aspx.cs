using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Academic
{
    public partial class AcademicModuleSpec : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                if (Session["s_loggedUserRole"].ToString() == "40")
                {

                }
                else if (Session["s_loggedUserRole"].ToString() == "30")
                {

                }
                else if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }

            }

            

            this.Page.Form.DefaultButton = btnSearchModule.UniqueID;
            this.Page.Form.DefaultFocus = txtModuleCode.ClientID;

        }

        protected void btnSearchModule_Click(object sender, EventArgs e)
        {
            Session["s_moduleCode"] = txtModuleCode.Text.ToString();
            gvModuleSpec.DataBind();
        }

        protected void gvModuleSpec_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
            }

            foreach (GridViewRow row in gvModuleSpec.Rows)
            {
                row.Cells[0].Visible = false;
            }
        }
    }
}