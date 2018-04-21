using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CIT12.SuperUser
{
    public partial class SuperUserBulkUploadUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null || Session["s_loggedUserRole"].ToString() != "60")
            {
                Response.Redirect("~/Default.aspx");
            }


            GetLastNumber();


            this.Page.Form.DefaultButton = btnPasswordGen.UniqueID;
            this.Page.Form.DefaultFocus = txtPassword.ClientID;
        }

        //gen hashed password
        protected void btnPasswordGen_Click(object sender, EventArgs e)
        {
            lblHashPassword.Text = Encrypt.Encryption(txtPassword.Text);
        }

        //gets last number in the user table
        private void GetLastNumber()
        {
            using (SqlConnection conn = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetLastNumber = new SqlCommand("SELECT TOP 1 Number FROM tbl_user ORDER BY Id DESC", conn);
                try
                {
                    lblLastNumber.Text = Convert.ToString(cmdGetLastNumber.ExecuteScalar());
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

        private void SaveCSVFile()
        {

            Random r = new Random();
            int rInt = r.Next(0, 10000);
            string UpPath = Server.MapPath("~/files");

            if (!Directory.Exists(UpPath))
            {
                Directory.CreateDirectory(UpPath);

            }
            else
            {
                int fileSize = fuCSV.PostedFile.ContentLength;
                string fileName = fuCSV.FileName;
                string filePath = "~/files/" + rInt + fileName;

                Session["s_filePath"] = filePath;

                if (fuCSV.PostedFile.ContentLength > 1500000)
                {
                    Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big.')", true);
                }
                else
                {
                    //then save it to the Folder
                    fuCSV.SaveAs(Server.MapPath(filePath));

                }


            }
        }

        private void UploadCSVFile()
        {

            SqlConnection conn = Connections.ApplicationConnection();


            string filePath = Server.MapPath(Session["s_filePath"].ToString());


            StreamReader sr = new StreamReader(filePath);
            string line = sr.ReadLine();
            string[] value = line.Split(',');


            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("Forename", typeof(String));
            dt.Columns.Add("Surname", typeof(String));
            dt.Columns.Add("Role", typeof(Int32));
            dt.Columns.Add("Number", typeof(Int32));
            dt.Columns.Add("Password", typeof(String));
            dt.Columns.Add("EmailAddress", typeof(String));

            while (!sr.EndOfStream)
            {
                value = sr.ReadLine().Split(',');
                if (value.Length == dt.Columns.Count)
                {
                    row = dt.NewRow();
                    row.ItemArray = value;
                    dt.Rows.Add(row);
                }
            }

            SqlBulkCopy bc = new SqlBulkCopy(conn.ConnectionString, SqlBulkCopyOptions.KeepIdentity);
            bc.DestinationTableName = "tbl_user";
            bc.BatchSize = dt.Rows.Count;

            bc.ColumnMappings.Add("Forename", "Forename");
            bc.ColumnMappings.Add("Surname", "Surname");
            bc.ColumnMappings.Add("Role", "Role");
            bc.ColumnMappings.Add("Number", "Number");
            bc.ColumnMappings.Add("Password", "Password");
            bc.ColumnMappings.Add("EmailAddress", "EmailAddress");


            bc.WriteToServer(dt);
            bc.Close();
            conn.Close();

            lblSuccess.Text = "Success, Your File Has Been Uploaded ";


            //-----------------adds last ids to tbl_student--------------------

            ArrayList usersArrayList = new ArrayList();

            using (SqlConnection connection = Connections.ApplicationConnection())
            {
                SqlCommand cmdGetLastId = new SqlCommand("SELECT TOP (@count) Id FROM tbl_user ORDER BY Id DESC", connection);
                cmdGetLastId.Parameters.AddWithValue("@count", dt.Rows.Count);
                SqlDataReader sqldr = cmdGetLastId.ExecuteReader();
                try
                {
                    while (sqldr.Read())
                    {
                        usersArrayList.Add(sqldr["Id"]);
                    }

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    connection.Close();
                }

            }

            usersArrayList.Sort();

            foreach (var val in usersArrayList)
            {
                Debug.WriteLine("VAL : " + val);
            }


            using (SqlConnection connection = Connections.ApplicationConnection())
            {
                SqlCommand cmdInsertId = new SqlCommand("INSERT INTO tbl_studentUser (StudentId, Level) VALUES (@id, @level)", connection);

                try
                {
                    foreach (var student in usersArrayList)
                    {
                        cmdInsertId.Parameters.Clear();

                        cmdInsertId.Parameters.AddWithValue("@id", student);
                        cmdInsertId.Parameters.AddWithValue("@level", 0);
                        cmdInsertId.ExecuteNonQuery();
                    }
                }
                catch(Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    connection.Close();
                }


            }



        }

        //button click
        protected void btnUploadCSV_Click(object sender, EventArgs e)
        {

            SaveCSVFile();
            UploadCSVFile();


            Debug.WriteLine("FILE : " + Session["s_filePath"]);


        }

    }
}
