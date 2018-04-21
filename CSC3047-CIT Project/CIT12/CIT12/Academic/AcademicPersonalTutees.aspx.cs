using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Collections;

namespace CIT12.Academic
{
    public partial class AcademicPersonalTutees : System.Web.UI.Page
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

            this.Page.Form.DefaultButton = btnFilterStudents.UniqueID;
            this.Page.Form.DefaultFocus = txtStudentNumber.ClientID;
        }

        //hides id in gv and printing function
        protected void gvAcademicPersonalTutees_DataBound(object sender, EventArgs e)
        {
            GridView gridView = (GridView)sender;

            if (gridView.HeaderRow != null && gridView.HeaderRow.Cells.Count > 0)
            {
                gridView.HeaderRow.Cells[0].Visible = false;
            }

            foreach (GridViewRow row in gvAcademicPersonalTutees.Rows)
            {
                row.Cells[0].Visible = false;
            }
        }

        //adds checked rows emails to array to be posted to email page 
        protected void btnEmailToArray_Click(object sender, EventArgs e)
        {
            ArrayList emailAddressList = new ArrayList();
            for (int i = 0; i < gvAcademicPersonalTutees.Rows.Count; i++)
            {
                if (((CheckBox)gvAcademicPersonalTutees.Rows[i].FindControl("cbEmail")).Checked)
                {
                    emailAddressList.Add(gvAcademicPersonalTutees.Rows[i].Cells[2].Text);
                   
                }
            }

            foreach (var val in emailAddressList)
            {
                Debug.WriteLine("ON CLICK EMAIL : " + val);
            }

            Session["s_emailAddressToSendList"] = emailAddressList;

            Response.Redirect("AcademicEmail.aspx");

        }






    }
}