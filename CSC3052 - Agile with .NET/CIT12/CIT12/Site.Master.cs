using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                pnlNavbarLinks.Visible = false;
                btnLogout.Visible = false;
                btnLogin.Visible = true;
            }
            else
            {

                pnlNavbarLinks.Visible = true;
                btnLogin.Visible = false;
                btnLogout.Visible = true;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginRegister.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}