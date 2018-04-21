using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminModuleClassList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "30")
            {
                if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }

        private void HideAllPanels()
        {
            pnlModuleList.Visible = false;
            pnlClassList.Visible = false;
        }

        //mdoule list -  view class list for module 
        protected void gvModuleList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdGetClassList")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_mouduleId"] = clickedRow.Cells[0].Text;
                lblModuleTitle.Text = clickedRow.Cells[1].Text;

                HideAllPanels();
                pnlClassList.Visible = true;

            }
        }
        //class list row databound
        protected void gvModuleClassList_DataBound(object sender, EventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
            }

            foreach (GridViewRow row in gvModuleClassList.Rows)
            {
                row.Cells[0].Visible = false;
            }
        }

        //sends email to people in list selected
        protected void btnSendEmail_Click(object sender, EventArgs e)
        {
            ArrayList emailAddressList = new ArrayList();
            for (int i = 0; i < gvModuleClassList.Rows.Count; i++)
            {
                if (((CheckBox)gvModuleClassList.Rows[i].FindControl("cbEmail")).Checked)
                {
                    emailAddressList.Add(gvModuleClassList.Rows[i].Cells[2].Text);
                    
                }
            }
            Session["s_emailAddressToSendList"] = emailAddressList;

            Response.Redirect("AdminSendEmail.aspx");
        }
    }
}