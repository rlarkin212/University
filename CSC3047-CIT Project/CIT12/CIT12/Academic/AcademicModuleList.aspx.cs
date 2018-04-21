using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Academic
{
    public partial class AcadmicModuleList : System.Web.UI.Page
    {

        protected void hideAllPanels()
        {
            pnlModuleList.Visible = false;
            pnlModuleClassList.Visible = false;

        }


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

          

            //populat date drop down 
            if (!IsPostBack)
            {
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdGetYears = new SqlCommand("SELECT Id, Year FROM tbl_years ORDER BY Year DESC", conn);
                    SqlDataReader sqldrGetYears = cmdGetYears.ExecuteReader();
                    try
                    {
                        ddlYear.Items.Clear();
                        while (sqldrGetYears.Read())
                        {
                            ddlYear.Items.Add(new ListItem(sqldrGetYears[1].ToString(), sqldrGetYears[0].ToString()));
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex);
                    }
                    finally
                    {
                        sqldrGetYears.Close();
                        conn.Close();
                    }
                }

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdGetLastYear = new SqlCommand("SELECT TOP 1 Id FROM tbl_years ORDER BY Id DESC", conn);
                    try
                    {
                        Session["s_classYearId"] = Convert.ToInt32(cmdGetLastYear.ExecuteScalar());
                    }
                    catch(Exception ex)
                    {
                        Debug.WriteLine("EXCEPTION " + ex);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }


            }




        }

        protected void gvAcademicModuleList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //opens class list for selected module
            if (e.CommandName == "viewModuleClassList")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_academicMoudleListId"] = clickedRow.Cells[0].Text;
                lblModule.Text = clickedRow.Cells[1].Text;

                hideAllPanels();
                pnlModuleClassList.Visible = true;




            }
        }

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

        //filter class gv year
        protected void btnFilterStudents_Click(object sender, EventArgs e)
        {
            Session["s_classYearId"] = Convert.ToInt32(ddlYear.SelectedValue);
        }

        protected void btnEmailToArray_Click(object sender, EventArgs e)
        {
            ArrayList emailAddressList = new ArrayList();
            for (int i = 0; i < gvModuleClassList.Rows.Count; i++)
            {
                if (((CheckBox)gvModuleClassList.Rows[i].FindControl("cbEmail")).Checked)
                {
                    emailAddressList.Add(gvModuleClassList.Rows[i].Cells[2].Text);
                    foreach (var val in emailAddressList)
                    {
                        Debug.WriteLine("ON CLICK EMAIL : " + val);
                    }


                }
            }
            Session["s_emailAddressToSendList"] = emailAddressList;

            Response.Redirect("AcademicEmail.aspx");
        }

       
    }
}