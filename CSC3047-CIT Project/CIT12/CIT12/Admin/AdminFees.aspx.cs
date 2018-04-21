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
    public partial class AdminFees : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                PopulateDropDowns();
            }
        }

        private void HideAllPanels()
        {
            pnlStudentList.Visible = false;
            pnlPayment.Visible = false;
        }

        private void PopulateDropDowns()
        {
            ddlFeeTypes.Items.Clear();
            ddlFeeTypes.Items.Insert(0, new ListItem("Not Paid", "0"));
            ddlFeeTypes.Items.Insert(1, new ListItem("Fully Paid", "1"));
            ddlFeeTypes.Items.Insert(2, new ListItem("Partially Paid", "2"));
        }
        //students on row databound
        protected void gvStudents_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                if (e.Row.Cells[5].Text == "0")
                {
                    e.Row.Cells[5].Text = "Not Paid";
                }

                if (e.Row.Cells[5].Text == "1")
                {
                    e.Row.Cells[5].Text = "Fully Paid";
                }

                if (e.Row.Cells[5].Text == "2")
                {
                    e.Row.Cells[5].Text = "Partially Paid";
                }



            }
        }
        //student row command
        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmdUpdateFees")
            {
                var clickedButton = e.CommandSource as Button;
                var clickedRow = clickedButton.NamingContainer as GridViewRow;

                Session["s_studentId"] = clickedRow.Cells[0].Text;
                lblStudent.Text = clickedRow.Cells[2].Text;


                GetOutstandingFees();

                HideAllPanels();
                pnlPayment.Visible = true;
            }
        }

        //---Payment panel----------------------------


        private void GetOutstandingFees()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetOutstandingFees = new SqlCommand("SELECT OutstandingFees FROM tbl_outstandingFees WHERE StudentId = @studentId", conn);
                cmdGetOutstandingFees.Parameters.AddWithValue("@studentId", Session["s_studentId"]);

                try
                {
                    lblOutstandingFees.Text = Convert.ToString(cmdGetOutstandingFees.ExecuteScalar());
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

        //submit payment
        protected void btnSubmitPrivatePayment_Click(object sender, EventArgs e)
        {

            decimal outstandingFees = Convert.ToDecimal(lblOutstandingFees.Text);
            decimal payingFees = Convert.ToInt32(txtAmountToPay.Text);


            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                //new value to update db outstand fees

                if (txtCardNumber.Text.Length == 16 && txtExpiryMonth.Text.Length == 2 && txtExpiryYear.Text.Length == 2 & txtCvCode.Text.Length == 3)
                {
                    decimal newOutstandingValue = Convert.ToDecimal(lblOutstandingFees.Text) - Convert.ToDecimal(txtAmountToPay.Text);
                    lblPaymentError.Text = "";

                    if (newOutstandingValue < 0)
                    {
                        lblPaymentError.Text = "Please Enter A Payment Amout Greater Than The Students Outstanding Fees";
                    }

                    try
                    {
                        //compare dates for expired cards
                        int currentMonth = DateTime.Now.Month;
                        string year = DateTime.Now.ToString("yy");
                        int currentyear = Convert.ToInt32(year);

                        if (Convert.ToInt32(txtExpiryMonth.Text) < currentMonth || Convert.ToInt32(txtExpiryYear.Text) < currentyear)
                        {
                            lblPaymentError.Text = "It Apperas The Card Details You Have Entered Are Expired";
                        }
                        else
                        {
                            if (newOutstandingValue == Convert.ToDecimal(0.00))
                            {
                                //sets fully paid

                                //update outstanding fees
                                SqlCommand cmdUpdateOutstandigFees = new SqlCommand("UPDATE tbl_outstandingFees SET OutstandingFees = @fees WHERE StudentId = @studentId", conn);
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@fees", Convert.ToDecimal(0));
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));
                                cmdUpdateOutstandigFees.ExecuteNonQuery();

                                SqlCommand cmdSubmitPrivateFinancePayment = new SqlCommand("UPDATE tbl_studentUser SET FeesPaid = @feesPaid WHERE StudentId = @studentId", conn);
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@feesPaid", Convert.ToInt32(1));
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));
                                cmdSubmitPrivateFinancePayment.ExecuteNonQuery();
                            }
                            else
                            {
                                //updates outstandg fees to new value 
                                SqlCommand cmdUpdateOutstandigFees = new SqlCommand("UPDATE tbl_outstandingFees SET OutstandingFees = @fees WHERE StudentId = @studentId", conn);
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@fees", Convert.ToDecimal(newOutstandingValue));
                                cmdUpdateOutstandigFees.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));
                                cmdUpdateOutstandigFees.ExecuteNonQuery();

                                SqlCommand cmdSubmitPrivateFinancePayment = new SqlCommand("UPDATE tbl_studentUser SET FeesPaid = @feesPaid WHERE StudentId = @studentId", conn);
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@feesPaid", Convert.ToInt32(2));
                                cmdSubmitPrivateFinancePayment.Parameters.AddWithValue("@studentId", Convert.ToInt32(Session["s_studentId"]));
                                cmdSubmitPrivateFinancePayment.ExecuteNonQuery();

                            }

                            //insert into payment records
                            SqlCommand cmdSubmitPaymentRecord = new SqlCommand("INSERT INTO tbl_paymentRecord (Date,Amount) Values(@date,@amount)");
                            cmdSubmitPaymentRecord.Parameters.AddWithValue("@date", Convert.ToDateTime(DateTime.Now.ToShortDateString()));
                            cmdSubmitPaymentRecord.Parameters.AddWithValue("@amount", Convert.ToDecimal(newOutstandingValue));
                            cmdSubmitPaymentRecord.ExecuteNonQuery();

                            lblSuccess.Text = "Success, Student Fee Details Have Been Updated";

                            HideAllPanels();
                            pnlStudentList.Visible = true;

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


        }
    }
}