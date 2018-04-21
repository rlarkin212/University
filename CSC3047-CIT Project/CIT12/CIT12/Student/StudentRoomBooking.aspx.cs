using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Student
{
    public partial class StudentRoomBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "10")
            {
                Response.Redirect("~/Default.aspx");
            }

            calDate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
            calDate.VisibleDate = Convert.ToDateTime(DateTime.Now.ToString());


            if (!IsPostBack)
            {

                PoplateDropDowns();
                GetUserEmailAddress();

                Session["s_date"] = calDate.SelectedDate.ToShortDateString();
                txtDate.Text = calDate.SelectedDate.ToShortDateString();
                lblDate.Text = txtDate.Text;
            }

        }

        private void HideAllPanels()
        {
            pnlDate.Visible = false;
            pnlBookings.Visible = false;
            pnlCreateBooking.Visible = false;
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
                    ddlBuilding.Items.Insert(0, new ListItem("-- Select Building --", "0"));

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

                //inital room

                ddlRoom.Items.Insert(0, new ListItem("-- Select A Building For Rooms --", "0"));

                //get times
                SqlCommand cmdGetTimes = new SqlCommand("SELECT Id, Time FROM tbl_times", conn);
                SqlDataReader sqldrTimes = cmdGetTimes.ExecuteReader();
                try
                {
                    ddlTime.Items.Clear();
                    while (sqldrTimes.Read())
                    {
                        ddlTime.Items.Add(new ListItem(sqldrTimes[1].ToString(), sqldrTimes[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrTimes.Close();
                    conn.Close();
                }
            }


        }

        private void GetUserEmailAddress()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetEmail = new SqlCommand("SELECT EmailAddress FROM tbl_user WHERE Id = @loggedUserId", conn);
                cmdGetEmail.Parameters.AddWithValue("@loggedUserId", Convert.ToInt32(Session["s_loggedUserId"]));
                try
                {
                    lblEmailAddress.Text = (String)cmdGetEmail.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        //check date is not before durretn date
        public static bool IsDateBeforeOrToday(string input)
        {
            DateTime pDate;
            if (!DateTime.TryParseExact(input, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out pDate))
            {
                //Invalid date
                //log , show error
                return false;
            }
            return DateTime.Today <= pDate;
        }

        //date change
        protected void calDate_SelectionChanged(object sender, EventArgs e)
        {
            txtDate.Text = calDate.SelectedDate.ToShortDateString();
            string selectedDate = txtDate.Text;

            bool validDate = IsDateBeforeOrToday(selectedDate);

            if (validDate == false)
            {
                lblError.Text = "Please Enter A Date Greater Than The Current Date";

            }
            else
            {
                lblError.Text = "";
                Session["s_date"] = txtDate.Text;
                lblDate.Text = txtDate.Text;

                gvBookings.DataBind();

            }

        }

        //add booking on click
        protected void btnCreateBooking_Click(object sender, EventArgs e)
        {
            HideAllPanels();
            pnlCreateBooking.Visible = true;

            lblDateToBook.Text = lblDate.Text;


            ddlBuilding.ClearSelection();
            ddlBuilding.Items.FindByValue(ddlBuildingFilter.SelectedValue).Selected = true;
            Session["s_buildingId"] = Convert.ToInt32(ddlBuilding.SelectedValue);

            BuildingSelect();



        }

        //ddl building selcted index change
        protected void ddlBuilding_SelectedIndexChanged(object sender, EventArgs e)
        {
            int buildingId = Convert.ToInt32(ddlBuilding.SelectedValue);
            Session["s_buildingId"] = Convert.ToInt32(ddlBuilding.SelectedValue);

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get rooms
                SqlCommand cmdGetRooms = new SqlCommand("SELECT Id, Room FROM tbl_rooms WHERE BuildingId = @id ORDER BY Room ASC", conn);
                cmdGetRooms.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_buildingId"]));

                SqlDataReader sqldrGetRooms = cmdGetRooms.ExecuteReader();
                try
                {
                    ddlRoom.Items.Clear();
                    while (sqldrGetRooms.Read())
                    {
                        ddlRoom.Items.Add(new ListItem(sqldrGetRooms[1].ToString(), sqldrGetRooms[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetRooms.Close();
                    conn.Close();
                }
            }

        }

        private void BuildingSelect()
        {
            int buildingId = Convert.ToInt32(ddlBuilding.SelectedValue);
            Session["s_buildingId"] = Convert.ToInt32(ddlBuilding.SelectedValue);

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //get rooms
                SqlCommand cmdGetRooms = new SqlCommand("SELECT Id, Room FROM tbl_rooms WHERE BuildingId = @id ORDER BY Room ASC", conn);
                cmdGetRooms.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_buildingId"]));

                SqlDataReader sqldrGetRooms = cmdGetRooms.ExecuteReader();
                try
                {
                    ddlRoom.Items.Clear();
                    while (sqldrGetRooms.Read())
                    {
                        ddlRoom.Items.Add(new ListItem(sqldrGetRooms[1].ToString(), sqldrGetRooms[0].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetRooms.Close();
                    conn.Close();
                }
            }
        }


        //object for booking room + time 
        public class Classes
        {
            public string Building { get; set; }
            public string Room { get; set; }
            public string Time { get; set; }
        }

        //check for clashes / submit event 
        protected void btnSubmitBooking_Click(object sender, EventArgs e)
        {
            //gvBookings.DataBind();

            List<Classes> selectedDateBookingTimesArray = new List<Classes>();
            bool clashes = false;

            //add each gridview time to an array list
            foreach (GridViewRow row in gvBookings.Rows)
            {
                string building = row.Cells[0].Text;
                string room = row.Cells[1].Text;
                string time = row.Cells[3].Text;

                selectedDateBookingTimesArray.Add(new Classes()
                {
                    Building = building,
                    Room = room,
                    Time = time
                });

            }

            //chek for clashes

            string bookingAtI = "";
            string newBooking = "";

            for (int i = 0; i < selectedDateBookingTimesArray.Count; i++)
            {
                bookingAtI = selectedDateBookingTimesArray[i].Building + " " + selectedDateBookingTimesArray[i].Room + " " + selectedDateBookingTimesArray[i].Time;
                newBooking = ddlBuilding.SelectedItem.Text + " " + ddlRoom.SelectedItem.Text + " " + ddlTime.SelectedItem.Text;

                Debug.WriteLine("Booking at I : " + bookingAtI);
                Debug.WriteLine("New Booking : " + newBooking);

                if (bookingAtI.Equals(newBooking))
                {
                    clashes = true;
                    break;

                }

            }
            //if there are no clashes
            if (clashes == false)
            {
                CreateBooking();
            }
            //if clashes exist
            else
            {
                lblClashes.Text = "A Booking Is Already Been Made For This Room At This Time";
            }


        }

        //create event
        private void CreateBooking()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertBooking = new SqlCommand("INSERT INTO tbl_roomBooking (RoomId, StudentId, Date, TimeId) VALUES (@roomId, @studentId, @date, @timeId)", conn);
                cmdInsertBooking.Parameters.AddWithValue("@roomId", Convert.ToInt32(ddlRoom.SelectedValue));
                cmdInsertBooking.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                cmdInsertBooking.Parameters.AddWithValue("@date", Convert.ToDateTime(lblDateToBook.Text));
                cmdInsertBooking.Parameters.AddWithValue("@timeId", Convert.ToInt32(ddlTime.SelectedValue));

                try
                {
                    cmdInsertBooking.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();

                    HideAllPanels();

                    gvBookings.DataBind();

                    lblsuccess.Text = "Success, Your Room Booking Has Been Made";
                    pnlDate.Visible = true;
                    pnlBookings.Visible = true;

                    //send confirmation email
                    RoomBookingConfirmation();
                }

            }
        }

        //email confirmation
        private void RoomBookingConfirmation()
        {


            string emailHeader = "Your Room Has Been Booked";
            string emailSubject = "Room Booking Confirmation ";
            string emailBody = "Your Room - " + ddlBuilding.SelectedItem.Text + " : " + ddlRoom.SelectedItem.Text + " has been booked for " + ddlTime.SelectedItem.Text;
            MailAddress mailAddress = new MailAddress(lblEmailAddress.Text);
            string emailFileName = "";
            string emailFile = "";

            //send email 
            Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);

            ddlBuilding.ClearSelection();
            ddlRoom.ClearSelection();
            ddlTime.ClearSelection();


        }





    }


}
