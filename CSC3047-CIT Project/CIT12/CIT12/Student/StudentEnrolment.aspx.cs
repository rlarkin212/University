using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Collections;
using System.Net.Mail;

namespace CIT12.Student
{
    public partial class StudentEnrollement : System.Web.UI.Page
    {

        private void hideAllPanels()
        {
            pnlStep1.Visible = false;
            pnlStep2.Visible = false;
            pnlStep3.Visible = false;
            pnlSuccess.Visible = false;
            pnlManualEnrolement.Visible = false;
        }


        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "10")
            {
                Response.Redirect("~/Default.aspx");
            }
            Debug.WriteLine("LOGGED USER ID : " + Session["s_loggedUserId"]);



            //CheckDate();

            //sets enter button for each panel
            if (pnlStep1.Visible == true)
            {
                this.Page.Form.DefaultButton = btnSubmitStep1.UniqueID;

            }




            if (!IsPostBack)
            {
                //loads data from table into form
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    //personal details
                    SqlCommand cmdPersonalDetails = new SqlCommand("SELECT Number,Forename,Surname,EmailAddress FROM tbl_user WHERE Id = @id", conn);
                    cmdPersonalDetails.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_loggedUserId"]));

                    using (SqlDataReader rdrPersonalDetails = cmdPersonalDetails.ExecuteReader())
                    {
                        while (rdrPersonalDetails.Read())
                        {
                            txtPersonalStudentNumber.Text = rdrPersonalDetails["Number"].ToString();
                            txtPersonalForename.Text = rdrPersonalDetails["Forename"].ToString();
                            txtPersonalSurname.Text = rdrPersonalDetails["Surname"].ToString();
                            txtPersonalEmail.Text = rdrPersonalDetails["EmailAddress"].ToString();
                        }
                    }

                    //home address, term address & next of kin details 
                    SqlCommand cmdAddressInfo = new SqlCommand("SELECT HomeHouseNo,HomeStreet,HomeTown_City, HomeCountry, TermHouseNo, TermStreet, TermTown_City, TermCountry, PhoneNumber, NextOfKinForename, NextOfKinSurname, NextOfKinHouseNo, NextOfKinStreet, NextOfKinTown_City, NextOfKinCountry, NextOfKinEmail, NextOfKinPhone FROM tbl_studentUser WHERE StudentId = @studentId", conn);

                    cmdAddressInfo.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));

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
                    }
                    //close connection
                    conn.Close();

                }
            }

        }

        private void CheckDate()
        {

            DateTime startOfyear;


            using (SqlConnection conn = Connections.ApplicationConnection())
            {

                SqlCommand cmdGetStartDate = new SqlCommand("SELECT TOP 1 StartDate FROM tbl_academicYearStart ORDER BY Id DESC", conn);
                try
                {

                    startOfyear = Convert.ToDateTime(cmdGetStartDate.ExecuteScalar());
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


            DateTime currentDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            DateTime topDate = Convert.ToDateTime(startOfyear.AddDays(14).ToShortDateString());
            DateTime bottomDate = Convert.ToDateTime(startOfyear.AddDays(-14).ToShortDateString());

            Debug.WriteLine("CURRENT DATE : " + currentDate);
            Debug.WriteLine("STAT DATE : " + startOfyear);
            Debug.WriteLine("TOP DATE : " + topDate);
            Debug.WriteLine("BOTTOM DATE : " + bottomDate);


            if (currentDate > bottomDate && currentDate < topDate)
            {
                Response.Redirect("~/Default.aspx");
            }


        }


        //personal details step 1 submit
        protected void btnSubmitStep1_Click(object sender, EventArgs e)
        {

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //update personal details tbl_user
                SqlCommand cmdUpdatePersonalDetails = new SqlCommand("UPDATE tbl_user SET Forename = @forename, Surname = @surname WHERE Id = @id ", conn);
                cmdUpdatePersonalDetails.Parameters.AddWithValue("@id", Convert.ToInt32(Session["s_loggedUserId"]));
                cmdUpdatePersonalDetails.Parameters.AddWithValue("@forename", txtPersonalForename.Text.ToString());
                cmdUpdatePersonalDetails.Parameters.AddWithValue("@surname", txtPersonalSurname.Text.ToString());

                //update address details tbl_studentUser
                SqlCommand cmdUpdateAddressDetails = new SqlCommand("UPDATE tbl_studentUser SET HomeHouseNo = @homeHouseNo, HomeStreet = @homeStreet, HomeTown_City = @homeTown_city, HomeCountry = @homeCountry, TermHouseNo = @termHouseNo, TermStreet = @termStreet, TermTown_City = @termTown_City, TermCountry = @termCountry, PhoneNumber = @phoneNumber, NextOfKinForename = @nextOfKinForename, NextOfKinSurname = @nextOfKinSurname, NextOfKinHouseNo = @nextOfKinHouseNo, NextOfKinStreet = @nextOfKinStreet, NextOfKinTown_City = @nextOfKinTown_City , NextOfKinCountry = @nextOfKinCountry, NextOfKinEmail = @nextOfKinEmail, NextOfKinPhone = @nextOfKinPhone WHERE StudentId = @studentId", conn);
                cmdUpdateAddressDetails.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
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

                //update level + 1
                int level;
                SqlCommand cmdGetLevel = new SqlCommand("SELECT StudentLevel FROM tbl_studentUser WHERE StudentId = @studentId", conn);
                cmdGetLevel.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));

                level = Convert.ToInt32(cmdGetLevel.ExecuteScalar());
                //TODO uncomment after testing 
                if (level != 1 && level < 5)
                {
                    //level = level + 1;
                }
                Session["s_studentLevel"] = level.ToString();
                Debug.WriteLine("STUDENT LEVEL: " + Session["s_studentLevel"]);

                SqlCommand cmdUpdateLevel = new SqlCommand("UPDATE tbl_studentUser SET StudentLevel = @studentLevel WHERE StudentId = @studentId", conn);
                cmdUpdateLevel.Parameters.AddWithValue("@studentLevel", Convert.ToInt32(level));
                cmdUpdateLevel.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));

                try
                {
                    cmdUpdatePersonalDetails.ExecuteNonQuery();
                    cmdUpdateAddressDetails.ExecuteNonQuery();
                    //cmdUpdateLevel.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("EXCEPTION : " + ex);
                }
                finally
                {
                    conn.Close();
                }

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 33+'%').attr('aria-valuenow', valeur);", true);

                hideAllPanels();
                pnlStep2.Visible = true;

            }

        }
        //-----------------------------------step 2------------------------------------

        //view class times cliock
        protected void btnViewClassTime_Click(object sender, EventArgs e)
        {
            ListViewDataItem clickedModule = ((Button)sender).NamingContainer as ListViewDataItem;
            string moduleName = ((Label)clickedModule.FindControl("lblModuleTitle")).Text;
            string moduleId = ((Label)clickedModule.FindControl("lblModuleId")).Text;

            lblModalTitle.Text = "Class Times - " + moduleName;
            Session["s_moduleIdForTimetable"] = moduleId;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 33+'%').attr('aria-valuenow', valeur);", true);
        }

        //object for class times + days 
        public class Classes
        {
            public string DayId { get; set; }
            public string Time { get; set; }
        }
        //sort array of time + day



        //----------------module submit click --------------------------
        protected void btnSubmitModules_Click(object sender, EventArgs e)
        {
            //adds CAT POINTS
            Int32 overallCatPoints = 0;
            //class dayId + time array
            List<Classes> classTimesList = new List<Classes>();
            //modules to enroll array
            ArrayList modulesToEnrollArray = new ArrayList();
            //time clashes flag
            bool clashesFlag = false;
            //day + time variables
            string dayId;
            string time;
            //already enrolled array list
            ArrayList alreadyEnrolledIdArrayList = new ArrayList();

            //----------loops through list view----------
            foreach (ListViewItem item in lvModules.Items)
            {

                //gets checked modules
                CheckBox checkedModule = (CheckBox)item.FindControl("cbPickModule");
                if (checkedModule.Checked == true)
                {
                    //adds cat points
                    Label catPoint = (Label)item.FindControl("lblCatPoints");
                    overallCatPoints = overallCatPoints + Convert.ToInt32(catPoint.Text);

                    //----------GETS TIMETABLE DATA-----------------------
                    Label moduleId = (Label)item.FindControl("lblModuleId");
                    //adds to moudles to enroll in 
                    modulesToEnrollArray.Add(moduleId.Text);

                    //gets classtimes + adds time & day to array of objects
                    using (SqlConnection conn = Connections.ApplicationConnection())
                    {
                        SqlCommand cmdGetClassTimes = new SqlCommand("SELECT tbl_timeTable.DayId, tbl_timeTable.Time FROM tbl_timeTable WHERE (tbl_timeTable.ModuleId = @moduleId)", conn);
                        cmdGetClassTimes.Parameters.AddWithValue("@moduleId", moduleId.Text);

                        using (SqlDataReader sqldr = cmdGetClassTimes.ExecuteReader())
                        {
                            while (sqldr.Read())
                            {
                                dayId = sqldr["DayId"].ToString();
                                time = sqldr["Time"].ToString();

                                classTimesList.Add(new Classes()
                                {
                                    DayId = dayId,
                                    Time = time
                                });


                            }
                            sqldr.Close();
                        }
                        conn.Close();
                    }
                }
            }



            //sorts array
            List<Classes> ClassesSortedList = classTimesList.OrderBy(o => o.DayId).ToList();

            //checks for time table clashes
            string classAtI = "";
            string classAtJ = "";

            for (int i = 1; i < ClassesSortedList.Count; i++)
            {
                classAtI = ClassesSortedList[i].DayId + " " + ClassesSortedList[i].Time;
                classAtJ = ClassesSortedList[i - 1].DayId + " " + ClassesSortedList[i - 1].Time;

                if (classAtI.Equals(classAtJ))
                {
                    clashesFlag = true;
                    break;

                }

            }

            //enrolled module ID session for enrolement timetable output
            //Session["s_moudleEnrolledArrrayList"] = modulesToEnrollArray;

            //------------------checks if selected cat points = 120 OR clashesFlag = true - else go to step 3---------------------
            if (overallCatPoints != 120 || clashesFlag == true)
            {
                if (overallCatPoints != 120)
                {
                    lblStep2Error.Text = "The Modules You Have Selected Do Not Add Up To 120 CAT Points";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 33+'%').attr('aria-valuenow', valeur);", true);
                }

                if (clashesFlag == true)
                {
                    lblStep2Error.Text = "The Modules You Have Selected Clash With Eachother Please Review Your Selections";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 33+'%').attr('aria-valuenow', valeur);", true);
                }
            }
            else //enroll and get + set outstanfing fees
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 66+'%').attr('aria-valuenow', valeur);", true);
                hideAllPanels();
                pnlStep3.Visible = true;

                //enroll in selected modules
                using (SqlConnection conn = Connections.ApplicationConnection())
                {
                    try
                    {
                        //gets fee price for user
                        decimal feeCost;
                        SqlCommand cmdGetFees = new SqlCommand("SELECT tbl_feesType.Price FROM tbl_feesType INNER JOIN tbl_studentUser ON tbl_feesType.Id = tbl_studentUser.FeesType WHERE (tbl_studentUser.StudentId = @loggedUserId)", conn);
                        cmdGetFees.Parameters.AddWithValue("@loggedUserId", Convert.ToInt32(Session["s_loggedUserId"]));
                        feeCost = (decimal)cmdGetFees.ExecuteScalar();
                        Debug.WriteLine("FEE COST : " + feeCost);
                        lblStudentFinanceCost.Text = Convert.ToString(feeCost);

                        //delete current outstanding fee record
                        //SqlCommand cmdDeleteOutstandingFees = new SqlCommand("DELETE FROM tbl_outstandingFees WHERE StudentId = @studentId", conn);
                        //cmdDeleteOutstandingFees.Parameters.AddWithValue("@studentFees", Convert.ToInt32(Session["s_loggedUserId"]));
                        //cmdDeleteOutstandingFees.ExecuteNonQuery();


                        Debug.WriteLine("FEE COST BEFORE INSERT : " + feeCost);
                        //inserts into outstanding fees
                        SqlCommand cmdInsertOutstandingFees = new SqlCommand("INSERT INTO tbl_outstandingFees (StudentId, OutstandingFees) VALUES (@studentId, @outstandingFees)", conn);
                        cmdInsertOutstandingFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                        cmdInsertOutstandingFees.Parameters.AddWithValue("@outstandingFees", Convert.ToDecimal(feeCost));
                        cmdInsertOutstandingFees.ExecuteNonQuery();

                        //get module ids from tbl_studentModule
                        SqlCommand cmdGetAlreadyEnrolledModuleId = new SqlCommand("SELECT ModuleId FROM tbl_studentModule WHERE StudentId = @studentId", conn);
                        cmdGetAlreadyEnrolledModuleId.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                        using (SqlDataReader sqldr = cmdGetAlreadyEnrolledModuleId.ExecuteReader())
                        {
                            while (sqldr.Read())
                            {
                                alreadyEnrolledIdArrayList.Add(sqldr["ModuleId"]);
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex);
                    }

                    //insert enrolled modules
                    foreach (var m in modulesToEnrollArray)
                    {

                        SqlCommand cmdInsertModulesToEnroll = new SqlCommand("INSERT INTO tbl_studentModule (StudentId, ModuleId, YearId, Complete) VALUES (@studentId, @moduleId, @yearId, @complete)", conn);
                        cmdInsertModulesToEnroll.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                        cmdInsertModulesToEnroll.Parameters.AddWithValue("@moduleId", Convert.ToInt32(m));
                        cmdInsertModulesToEnroll.Parameters.AddWithValue("@yearId", Convert.ToInt32(11));
                        cmdInsertModulesToEnroll.Parameters.AddWithValue("@complete", Convert.ToInt32(0));

                        cmdInsertModulesToEnroll.ExecuteNonQuery();


                    }
                    conn.Close();

                }

            }
        }

        //----------------manual enrolement submit click --------------------------
        protected void btnManualEnrolement_Click(object sender, EventArgs e)
        {
            progressBar.Attributes.Add("class", "progress-bar progress-bar-danger");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 33+'%').attr('aria-valuenow', valeur);", true);
            hideAllPanels();
            pnlManualEnrolement.Visible = true;
        }

        protected void btnSubmitManualEnrolement_Click(object sender, EventArgs e)
        {
            string studentId = "";
            string studentName = "";
            string studentNumber = "";
            string studentEmail = "";

            string advisorId = "";
            string advisorEmail = "";

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //--------------gets student information for logegd in user --------------------------
                SqlCommand cmdGetStudentInfo = new SqlCommand("SELECT Id, CONCAT(Forename, '' ,Surname) AS FullName, Number, EmailAddress FROM tbl_user WHERE Id = @id ", conn);
                cmdGetStudentInfo.Parameters.AddWithValue("@Id", Convert.ToInt32(Session["s_loggedUserId"]));
                SqlDataReader sqldrGetStudentInfo = cmdGetStudentInfo.ExecuteReader();
                try
                {
                    while (sqldrGetStudentInfo.Read())
                    {
                        studentId = sqldrGetStudentInfo["Id"].ToString();
                        studentName = sqldrGetStudentInfo["FullName"].ToString();
                        studentNumber = sqldrGetStudentInfo["Number"].ToString();
                        studentEmail = sqldrGetStudentInfo["EmailAddress"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetStudentInfo.Close();
                }

                //------------------gets email for students advisor of studies-------------------------
                SqlCommand cmdgetAdvisor = new SqlCommand("SELECT tbl_user.Id, tbl_user.EmailAddress FROM tbl_user INNER JOIN tbl_advisorOfStudies ON tbl_user.Id = tbl_advisorOfStudies.AcademicId WHERE (tbl_advisorOfStudies.StudentId = @studentId)", conn);
                cmdgetAdvisor.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                SqlDataReader sqldrGetAdvisorInfo = cmdgetAdvisor.ExecuteReader();

                try
                {
                    while (sqldrGetAdvisorInfo.Read())
                    {
                        advisorId = sqldrGetAdvisorInfo["Id"].ToString();
                        advisorEmail = sqldrGetAdvisorInfo["EmailAddress"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqldrGetAdvisorInfo.Close();
                }
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 100+'%').attr('aria-valuenow', valeur);", true);
                progressBar.Attributes.Add("class", "progress-bar progress-bar-success");

                //------------------inset into help table for response -------------------------

                SqlCommand cmdInsertAdvisorHelpTable = new SqlCommand("INSERT INTO tbl_advisorEnrolementHelp (StudentId, AdvisorId, RequestDate) VALUES (@studentId, @advisorId, @requestDate)", conn);
                cmdInsertAdvisorHelpTable.Parameters.AddWithValue("@studentId", Convert.ToInt32(studentId));
                cmdInsertAdvisorHelpTable.Parameters.AddWithValue("@advisorId", Convert.ToInt32(advisorId));
                cmdInsertAdvisorHelpTable.Parameters.AddWithValue("@requestDate", Convert.ToDateTime(DateTime.Now.ToShortDateString()));

                try
                {
                    cmdInsertAdvisorHelpTable.ExecuteNonQuery();
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

            //---------sends email to advisor of studies-------------

            string emailHeader = "Manual Enrolement Request - " + studentName;
            string emailSubject = studentNumber + " : " + studentName + " " + "Has Requested Manual Enrolement";
            string emailBody = studentNumber + " : " + studentName + " " + "Has Requested Manual Enrolement They Can Be Contacted Here To Arrange A Meeting - " + studentEmail;
            MailAddress mailAddress = new MailAddress(advisorEmail.ToString());
            string emailFileName = "";
            string emailFile = "";

            //send email 
            Email.SendEmail(mailAddress, emailHeader, emailSubject, emailBody, emailFileName, emailFile);

            lblManualEnrolementSuccess.Text = "Your Request Has Been Succesfull, Your Advisor Of Studies Will Be In Touch. Please Keep A Lookout In Your Inbox " + studentEmail;

            btnSubmitManualEnrolement.Visible = false;
            btnReturnHome.Visible = true;

        }

        //-----------------------------------step 3------------------------------------
        protected void btnContinuePayment_Click(object sender, EventArgs e)
        {
            FeesDiv.Visible = false;
            PayOptionsButtonsDiv.Visible = true;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 66+'%').attr('aria-valuenow', valeur);", true);
        }

        //shows student finance payment panel
        protected void btnStudentFinanceOption_Click(object sender, EventArgs e)
        {
            //gets outstanding fees
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetOutstandingFees = new SqlCommand("SELECT OutstandingFees FROM tbl_outstandingFees WHERE StudentId = @studentId", conn);
                cmdGetOutstandingFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));

                try
                {
                    decimal outstandingFees = (decimal)cmdGetOutstandingFees.ExecuteScalar();
                    lblStudnetFinanceOutstandingFees.Text = outstandingFees.ToString();
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


            PayOptionsButtonsDiv.Visible = false;
            StudentFinanceOptionDiv.Visible = true;
            PrivateFinanceOptionDiv.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 66+'%').attr('aria-valuenow', valeur);", true);
        }
        //shows private finace panel
        protected void btnPrivateFinanceOption_Click(object sender, EventArgs e)
        {
            //gets outstanding fees

            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetOutstandingFees = new SqlCommand("SELECT OutstandingFees FROM tbl_outstandingFees WHERE StudentId = @studentId", conn);
                cmdGetOutstandingFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));

                try
                {
                    Decimal outstandingFees = (Decimal)cmdGetOutstandingFees.ExecuteScalar();
                    Debug.WriteLine("OUTSTANDING FEES : " + outstandingFees);
                    lblPrivateFinanceOutstandignFees.Text = outstandingFees.ToString();
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


            PayOptionsButtonsDiv.Visible = false;
            StudentFinanceOptionDiv.Visible = false;
            PrivateFinanceOptionDiv.Visible = true;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 66+'%').attr('aria-valuenow', valeur);", true);
        }
        //submit student finance payment
        protected void btnSubmitStudentFinancePayment_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                try
                {
                    //update outstanding fees
                    SqlCommand cmdUpdateOutstandigFees = new SqlCommand("UPDATE tbl_outstandingFees SET OutstandingFees = @fees WHERE StudentId = @studentId", conn);
                    cmdUpdateOutstandigFees.Parameters.AddWithValue("@fees", Convert.ToDecimal(0));
                    cmdUpdateOutstandigFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                    cmdUpdateOutstandigFees.ExecuteNonQuery();


                    //sets paid flag in tbl_studentUser
                    SqlCommand cmdSubmitStudentFinancePayment = new SqlCommand("UPDATE tbl_studentUser SET FeesPaid = @feesPaid WHERE StudentId = @studentId", conn);
                    cmdSubmitStudentFinancePayment.Parameters.AddWithValue("@feesPaid", Convert.ToInt32(1));
                    cmdSubmitStudentFinancePayment.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                    cmdSubmitStudentFinancePayment.ExecuteNonQuery();

                    //insert into payment records
                    SqlCommand cmdSubmitPaymentRecord = new SqlCommand("INSERT INTO tbl_paymentRecord (Date,Amount) Values(@date,@amount)");
                    cmdSubmitPaymentRecord.Parameters.AddWithValue("@date", Convert.ToDateTime(DateTime.Now.ToShortDateString()));
                    cmdSubmitPaymentRecord.Parameters.AddWithValue("@amount", Convert.ToDecimal(lblStudnetFinanceOutstandingFees.Text));
                    cmdSubmitPaymentRecord.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex);
                }
                finally
                {
                    conn.Close();
                }

                progressBar.Attributes.Add("class", "progress-bar progress-bar-success");
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 100+'%').attr('aria-valuenow', valeur);", true);


                hideAllPanels();
                pnlSuccess.Visible = true;
            }
        }
        //submit private payment
        protected void btnSubmitPrivatePayment_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //new value to update db outstand fees

                if (txtCardNumber.Text.Length == 16 && txtExpiryMonth.Text.Length == 2 && txtExpiryYear.Text.Length == 2 & txtCvCode.Text.Length == 3)
                {
                    decimal newOutstandingValue = Convert.ToDecimal(lblPrivateFinanceOutstandignFees.Text) - Convert.ToDecimal(txtAmountToPay.Text);
                    lblPaymentError.Text = "";
                    try
                    {
                        //compare dates for expired cards
                        int currentMonth = DateTime.Now.Month;
                        string year = DateTime.Now.ToString("yy");
                        int currentyear = Convert.ToInt32(year);

                        if (Convert.ToInt32(txtExpiryMonth.Text) < currentMonth || Convert.ToInt32(txtExpiryYear.Text) < currentyear)
                        {
                            lblProvatePaymentError.Text = "It Apperas The Card Details You Have Entered Are Expired";
                        }
                        else
                        {
                            if (newOutstandingValue == Convert.ToDecimal(0.00))
                            {
                                //sets fully paid

                                //update outstanding fees
                                SqlCommand cmdUpdateOutstandigFees = new SqlCommand("UPDATE tbl_outstandingFees SET OutstandingFees = @fees WHERE StudentId = @studentId", conn);
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@fees", Convert.ToDecimal(0));
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                                cmdUpdateOutstandigFees.ExecuteNonQuery();

                                SqlCommand cmdSubmitPrivateFinancePayment = new SqlCommand("UPDATE tbl_studentUser SET FeesPaid = @feesPaid WHERE StudentId = @studentId", conn);
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@feesPaid", Convert.ToInt32(1));
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                                cmdSubmitPrivateFinancePayment.ExecuteNonQuery();
                            }
                            else
                            {
                                //updates outstandg fees to new value 
                                SqlCommand cmdUpdateOutstandigFees = new SqlCommand("UPDATE tbl_outstandingFees SET OutstandingFees = @fees WHERE StudentId = @studentId", conn);
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@fees", Convert.ToDecimal(newOutstandingValue));
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                                cmdUpdateOutstandigFees.ExecuteNonQuery();

                                SqlCommand cmdSubmitPrivateFinancePayment = new SqlCommand("UPDATE tbl_studentUser SET FeesPaid = @feesPaid WHERE StudentId = @studentId", conn);
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@feesPaid", Convert.ToInt32(2));
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_loggedUserId"]));
                                cmdSubmitPrivateFinancePayment.ExecuteNonQuery();

                            }

                            //insert into payment records
                            SqlCommand cmdSubmitPaymentRecord = new SqlCommand("INSERT INTO tbl_paymentRecord (Date,Amount) Values(@date,@amount)");
                            cmdSubmitPaymentRecord.Parameters.AddWithValue("@date", Convert.ToDateTime(DateTime.Now.ToShortDateString()));
                            cmdSubmitPaymentRecord.Parameters.AddWithValue("@amount", Convert.ToDecimal(newOutstandingValue));
                            cmdSubmitPaymentRecord.ExecuteNonQuery();
                        }



                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
                else
                {
                    lblPaymentError.Text = "Please Enter Valid Credit Card Information";
                }

            }
            progressBar.Attributes.Add("class", "progress-bar progress-bar-success");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "progressBar", "$('.progress-bar').css('width', 100+'%').attr('aria-valuenow', valeur);", true);


            hideAllPanels();
            pnlSuccess.Visible = true;

        }


    }



}

