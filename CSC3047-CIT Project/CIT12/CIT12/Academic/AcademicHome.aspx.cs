using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace CIT12.Academic
{
    public partial class AcademicHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "20")
            {
                //!= to academic program manager
                if (Session["s_loggedUserRole"].ToString() == "40")
                {
                    pnlAcademicProgramManager.Visible = true;
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

            


            //number and name
            string number = Session["s_loggedNumber"].ToString();
            string name;

            //ssql get name
            string sqlGetName = "SELECT CONCAT(Forename,' ',Surname) AS FullName From tbl_user WHERE Id=@id";
            using (var cnn = Connections.ApplicationConnection())
            {
                using (var cmdGetName = new SqlCommand(sqlGetName, cnn))
                {
                    cmdGetName.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_loggedUserId"]));
                    name = Convert.ToString(cmdGetName.ExecuteScalar());

                }
            }

            lblAcademicNumber.Text = number + " - " + name;
        }
    }
}