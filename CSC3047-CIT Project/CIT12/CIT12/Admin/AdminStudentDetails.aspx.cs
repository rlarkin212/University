using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIT12.Admin
{
    public partial class AdminStudentDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "30")
            {
                if (Session["s_loggedUserRole"].ToString() == "60")
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }

            this.Page.Form.DefaultButton = btnNumberSearch.UniqueID;
            this.Page.Form.DefaultFocus = txtNumberSearch.ClientID;

        }

        private void HideAllPanels()
        {
            pnlStudents.Visible = false;
            pnlDetails.Visible = false;
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdViewDetails")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_studentId"] = clickedRow.Cells[0].Text;

                HideAllPanels();
                pnlDetails.Visible = true;

                PopulateDetails();

            }
        }

        private void PopulateDetails()
        {
            //loads data from table into form
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //personal details
                SqlCommand cmdPersonalDetails = new SqlCommand("SELECT Number,Forename,Surname,EmailAddress FROM tbl_user WHERE Id = @id", conn);
                cmdPersonalDetails.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_studentId"]));

                using (SqlDataReader rdrPersonalDetails = cmdPersonalDetails.ExecuteReader())
                {
                    while (rdrPersonalDetails.Read())
                    {
                        txtPersonalStudentNumber.Text = rdrPersonalDetails["Number"].ToString();
                        txtPersonalForename.Text = rdrPersonalDetails["Forename"].ToString();
                        txtPersonalSurname.Text = rdrPersonalDetails["Surname"].ToString();
                        txtPersonalEmail.Text = rdrPersonalDetails["EmailAddress"].ToString();
                    }
                    rdrPersonalDetails.Close();
                }

                //home address, term address & next of kin details 
                SqlCommand cmdAddressInfo = new SqlCommand("SELECT HomeHouseNo,HomeStreet,HomeTown_City, HomeCountry, TermHouseNo, TermStreet, TermTown_City, TermCountry, PhoneNumber, NextOfKinForename, NextOfKinSurname, NextOfKinHouseNo, NextOfKinStreet, NextOfKinTown_City, NextOfKinCountry, NextOfKinEmail, NextOfKinPhone FROM tbl_studentUser WHERE StudentId = @studentId", conn);

                cmdAddressInfo.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));

                using (SqlDataReader rdrAddressDetais = cmdAddressInfo.ExecuteReader())
                {
                    while (rdrAddressDetais.Read())
                    {
                        //home address values
                        txtHomeAddressNo.Text = rdrAddressDetais["HomeHouseNo"].ToString();
                        txtHomeAddressStreet.Text = rdrAddressDetais["HomeStreet"].ToString();
                        txtHomeAddressTown_City.Text = rdrAddressDetais["HomeTown_City"].ToString();
                        txtHomeAddressCountry.Text = rdrAddressDetais["HomeCountry"].ToString();

                        //term address values
                        txtTermAddressHouseNo.Text = rdrAddressDetais["TermHouseNo"].ToString();
                        txtTermAddressStreet.Text = rdrAddressDetais["TermStreet"].ToString();
                        txtTermAddressTown.Text = rdrAddressDetais["TermTown_City"].ToString();
                        txtTermAddressCountry.Text = rdrAddressDetais["TermCountry"].ToString();
                        //phone number
                        txtPersonalPhoneNumber.Text = rdrAddressDetais["PhoneNumber"].ToString();

                        //next of kin values
                        txtNextOfKinForename.Text = rdrAddressDetais["NextOfKinForename"].ToString();
                        txtNextOfKinSurname.Text = rdrAddressDetais["NextOfKinSurname"].ToString();
                        txtNextOfKinAddressHouseNo.Text = rdrAddressDetais["NextOfKinHouseNo"].ToString();
                        txtNextOfKinAddressStreet.Text = rdrAddressDetais["NextOfKinStreet"].ToString();
                        txtNextOfKinAddressTown.Text = rdrAddressDetais["NextOfKinTown_City"].ToString();
                        txtNextOfKinAddressCountry.Text = rdrAddressDetais["NextOfKinCountry"].ToString();
                        txtNextOfKinEmail.Text = rdrAddressDetais["NextOfKinEmail"].ToString();
                        txtNextOfKinPhoneNumber.Text = rdrAddressDetais["NextOfKinPhone"].ToString();


                    }
                    rdrAddressDetais.Close();
                }
                //close connection
                conn.Close();
                

            }
        }

        protected void btnSubmitDetails_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //update personal details tbl_user
                SqlCommand cmdUpdatePersonalDetails = new SqlCommand("UPDATE tbl_user SET Forename = @forename, Surname = @surname, EmailAddress = @emailAddress WHERE Id = @id ", conn);
                cmdUpdatePersonalDetails.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_studentId"]));
                cmdUpdatePersonalDetails.Parameters.AddWithValue("@forename", txtPersonalForename.Text.ToString());
                cmdUpdatePersonalDetails.Parameters.AddWithValue("@surname", txtPersonalSurname.Text.ToString());
                cmdUpdatePersonalDetails.Parameters.AddWithValue("@emailAddress", txtPersonalEmail.Text.ToString());

                //update address details tbl_studentUser
                SqlCommand cmdUpdateAddressDetails = new SqlCommand("UPDATE tbl_studentUser SET HomeHouseNo = @homeHouseNo, HomeStreet = @homeStreet, HomeTown_City = @homeTown_city, HomeCountry = @homeCountry, TermHouseNo = @termHouseNo, TermStreet = @termStreet, TermTown_City = @termTown_City, TermCountry = @termCountry, PhoneNumber = @phoneNumber, NextOfKinForename = @nextOfKinForename, NextOfKinSurname = @nextOfKinSurname, NextOfKinHouseNo = @nextOfKinHouseNo, NextOfKinStreet = @nextOfKinStreet, NextOfKinTown_City = @nextOfKinTown_City , NextOfKinCountry = @nextOfKinCountry, NextOfKinEmail = @nextOfKinEmail, NextOfKinPhone = @nextOfKinPhone WHERE StudentId = @studentId", conn);
                cmdUpdateAddressDetails.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));
                cmdUpdateAddressDetails.Parameters.AddWithValue("@homeHouseNo", txtHomeAddressNo.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@homeStreet", txtHomeAddressStreet.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@homeTown_city", txtHomeAddressTown_City.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@homeCountry", txtHomeAddressCountry.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@termHouseNo", txtTermAddressHouseNo.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@termStreet", txtTermAddressStreet.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@termTown_City", txtTermAddressTown.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@termCountry", txtTermAddressCountry.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@phoneNumber", txtPersonalPhoneNumber.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinForename", txtNextOfKinForename.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinSurname", txtNextOfKinSurname.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinHouseNo", txtNextOfKinAddressHouseNo.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinStreet", txtNextOfKinAddressStreet.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinTown_City", txtNextOfKinAddressTown.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinCountry", txtNextOfKinAddressCountry.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinEmail", txtNextOfKinEmail.Text.ToString());
                cmdUpdateAddressDetails.Parameters.AddWithValue("@nextOfKinPhone", txtNextOfKinPhoneNumber.Text.ToString());


                try
                {
                    cmdUpdatePersonalDetails.ExecuteNonQuery();
                    cmdUpdateAddressDetails.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                    gvStudents.DataBind();

                    HideAllPanels();
                    lblSuccess.Text = "Success, Student Details Have Been Updated";
                    pnlStudents.Visible = true;
                }
            }
        }
    }
}