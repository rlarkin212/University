using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class searchItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        searchText.Text = Request.QueryString["searchQuery"];
    }
    protected void itemSearchButton_Click(object sender, EventArgs e)
    {

        string searchText = itemSearchBox.Text;
        Response.Redirect("searchItem.aspx?searchQuery=" + searchText);
    }
    
}