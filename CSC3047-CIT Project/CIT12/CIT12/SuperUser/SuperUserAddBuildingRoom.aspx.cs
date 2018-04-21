using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.SuperUser
{
    public partial class SuperUserAddBuildingRoom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "60")
            {
                Response.Redirect("~/Default.aspx");
            }

            if (!IsPostBack)
            {
                PoplateDropDowns();
            }
        }

        private void HideAllPanels()
        {
            pnlBuilding.Visible = false;
            pnlRoom.Visible = false;
        }

        private void PoplateDropDowns()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get buildings
                SqlCommand cmdGetBuildings = new SqlCommand("SELECT Id, Building FROM tbl_building", conn);
                SqlDataReader sqldrGetBuildings = cmdGetBuildings.ExecuteReader();
                try
                {
                    ddlBuilding.Items.Clear();
                    ddlBuildingFilter.Items.Clear();

                    while (sqldrGetBuildings.Read())
                    {
                        ddlBuilding.Items.Add(new ListItem(sqldrGetBuildings[1].ToString(), sqldrGetBuildings[0].ToString()));
                        ddlBuildingFilter.Items.Add(new ListItem(sqldrGetBuildings[1].ToString(), sqldrGetBuildings[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetBuildings.Close();
                }

            }
        }

        protected void btnBuilding_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlBuilding.Visible = true;

            lblSuccess.Text = "";

            this.Page.Form.DefaultButton = btnAddBuilding.UniqueID;
            this.Page.Form.DefaultFocus = txtBuilding.ClientID;
        }

        protected void btnRoom_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlRoom.Visible = true;

            lblSuccess.Text = "";

            this.Page.Form.DefaultButton = btnAddRoom.UniqueID;
            this.Page.Form.DefaultFocus = txtRoom.ClientID;
        }

        //----------------building----------------------------------------
        protected void gvBuildings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdRemoveBuilding")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdDeleteBuilding = new SqlCommand("DELETE FROM tbl_building WHERE Id = @id", conn);
                    cmdDeleteBuilding.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[0].Text));

                    SqlCommand cmdRemoveAlBuildings = new SqlCommand("DELETE FROM tbl_rooms WHERE BuildingId = @buildingId", conn);
                    cmdRemoveAlBuildings.Parameters.AddWithValue("@buildingId", Convert.ToInt32(clickedRow.Cells[0].Text));

                    
                    try
                    {
                        cmdDeleteBuilding.ExecuteNonQuery();
                        cmdRemoveAlBuildings.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        gvBuildings.DataBind();

                        ddlBuilding.DataBind();
                        ddlBuildingFilter.DataBind();

                        lblSuccess.Text = "Success, The Building Has Been Removed";
                    }
                }
            }
        }


        //add building
        protected void btnAddBuilding_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertBuilding = new SqlCommand("INSERT INTO tbl_building (Building) VALUES (@building)", conn);
                cmdInsertBuilding.Parameters.AddWithValue("@building", Convert.ToString(txtBuilding.Text));
                try
                {

                    cmdInsertBuilding.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();

                    gvBuildings.DataBind();

                    ddlBuilding.DataBind();
                    ddlBuildingFilter.DataBind();


                    txtBuilding.Text = "";
                    lblSuccess.Text = "Success, The Building Has Been Added";
                }
            }
        }
        //----------------room----------------------------------------
        protected void gvRooms_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdRemoveRoom")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    SqlCommand cmdDeleteRoom = new SqlCommand("DELETE FROM tbl_rooms WHERE Id = @id", conn);
                    cmdDeleteRoom.Parameters.AddWithValue("@id", Convert.ToInt32(clickedRow.Cells[0].Text));
                    try
                    {
                        cmdDeleteRoom.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        conn.Close();
                        ddlBuilding.DataBind();
                        ddlBuildingFilter.DataBind();

                        gvRooms.DataBind();
                        lblSuccess.Text = "Success, The Room Has Been Removed";
                    }
                }
            }
        }

        //add room
        protected void btnAddRoom_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertRoom = new SqlCommand("INSERT INTO tbl_rooms (BuildingId, Room) VALUES (@buildingId, @room)", conn);
                cmdInsertRoom.Parameters.AddWithValue("@buildingId", Convert.ToInt32(ddlBuilding.SelectedValue));
                cmdInsertRoom.Parameters.AddWithValue("@room", Convert.ToString(txtRoom.Text));
                try
                {

                    cmdInsertRoom.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                    gvRooms.DataBind();

                    ddlBuilding.ClearSelection();
                    txtRoom.Text = "";
                    lblSuccess.Text = "Success, The Room Has Been Added";
                }
            }
        }


    }
}