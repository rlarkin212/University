using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Accounts_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../logIn.aspx");
        }
    }

    protected void logoutBtn_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("../Default.aspx");
    }
}