using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CIT12.SeniorUniversityManager
{
    public partial class SUMHome : System.Web.UI.Page
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
            //number and name
            string number = Session["s_loggedNumber"].ToString();
            string name;

            //sql get name
            string sqlGetName = "SELECT CONCAT(Forename,' ',Surname) AS FullName From tbl_user WHERE Id=@id";
            using (var cnn = Connections.ApplicationConnection())
            {
                using (var cmdGetName = new SqlCommand(sqlGetName, cnn))
                {
                    cmdGetName.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_loggedUserId"]));
                    name = Convert.ToString(cmdGetName.ExecuteScalar());

                }
            }

            lblStaffNumber.Text = number + " - " + name;
        }
    }
}