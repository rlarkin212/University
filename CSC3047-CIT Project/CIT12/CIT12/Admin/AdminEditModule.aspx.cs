using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminEditModule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {

                SqlCommand cmdModuleDetails = new SqlCommand("SELECT * FROM tbl_modules WHERE Id = @id", conn);
                cmdModuleDetails.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_ModuleId"]));

                using (SqlDataReader rdrModuleDetails = cmdModuleDetails.ExecuteReader())
                {
                    while (rdrModuleDetails.Read())
                    {
                        if (!IsPostBack)
                        {
                            txtTitle.Text = rdrModuleDetails["Title"].ToString();
                            txtDesc.Text = rdrModuleDetails["ModuleDescription"].ToString();
                            lblCode.Text = rdrModuleDetails["Code"].ToString();

                            ddlLevel.SelectedValue = rdrModuleDetails["Level"].ToString();
                            ddlSemester.SelectedValue = rdrModuleDetails["SemesterId"].ToString();                            
                            txtCAT.Text = rdrModuleDetails["CatPoints"].ToString();

                            if (ddlLevel.SelectedValue != "1")
                            {                              
                                ddlPreReq.Enabled = true;
                                ddlPreReq.SelectedValue = rdrModuleDetails["PreReqModules"].ToString();
                            }
                            else
                            {

                                ddlPreReq.Enabled = false;
                                ddlPreReq.SelectedValue = "N/A";

                            }
                            
                            
                            if (rdrModuleDetails["Active"].ToString() == "1")
                            {
                                cbActive.Checked = true;
                            }
                            else
                            {
                                cbActive.Checked = false;
                            }
                        }
                    }
                }
                conn.Close();               
            }

            
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int active;
            if (cbActive.Checked == true)
            {
                active = 1;         
            }
            else
            {
                active = 0;
            }

            using (SqlConnection conn = Connections.ApplicationConnection())
            {


                SqlCommand cmdEditModule = new SqlCommand("UPDATE tbl_modules SET Title = @title, ModuleDescription = @desc, Level = @level, SemesterId = @semester, CatPoints = @cat, Active = @active, PreReqModules = @preReqMod WHERE Id = @id", conn);

                cmdEditModule.Parameters.AddWithValue("@title", txtTitle.Text);
                cmdEditModule.Parameters.AddWithValue("@desc", txtDesc.Text);
                cmdEditModule.Parameters.AddWithValue("@level", ddlLevel.SelectedValue);
                cmdEditModule.Parameters.AddWithValue("@semester", ddlSemester.SelectedValue);
                cmdEditModule.Parameters.AddWithValue("@preReqMod", ddlPreReq.SelectedValue);
                cmdEditModule.Parameters.AddWithValue("@cat", txtCAT.Text);
                cmdEditModule.Parameters.AddWithValue("@active", active);

                cmdEditModule.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_ModuleId"]));

                cmdEditModule.ExecuteNonQuery();
            }



        }

        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlLevel.SelectedValue != "1")
            {
                ddlPreReq.Items.Clear();
                ddlPreReq.Items.Add("N/A");
                ddlPreReq.Enabled = true;
            }
            else
            {
                ddlPreReq.Enabled = false;
                ddlPreReq.SelectedValue = "N/A";
            }
        }
    }

}
