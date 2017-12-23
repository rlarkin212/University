using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class SelectScrum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void GridViewScrum_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                HiddenField id = clickedRow.FindControl("HiddenFieldId") as HiddenField;
                HiddenField proId = clickedRow.FindControl("HiddenFieldProId") as HiddenField;
                Session["sprintId"] = id.Value;
                Session["projectId"] = proId.Value;
                Response.Redirect("~/SelectDevelopers.aspx");
            }

            

          
            
        }
    }
}