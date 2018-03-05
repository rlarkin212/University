using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class Accounts_editItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../logIn.aspx");
        }


        if (!IsPostBack)
        {
            string row = Request.QueryString["editItemId"];
            //get the querystring data from you URL and store it in a variable
            //this will be used in the SQL select statement



            //set-up object to use the web.config file
            string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;

            //set-up connection object called 'myConnection'
            SqlConnection myConnection = new SqlConnection(connectionString);

            // open database communication
            myConnection.Open();

            //create the SQL statement
            string query = "SELECT * FROM itemsForSale WHERE Id=@rowid";

            //set-up SQL command and use the SQL and myConnection object
            SqlCommand myCommand = new SqlCommand(query, myConnection);
            //create a parametrised object
            myCommand.Parameters.AddWithValue("@rowid", row);

            //create a sqldatareader object that asks for dats from a table
            SqlDataReader rdr = myCommand.ExecuteReader();


            //when in read mode ask for data
            while (rdr.Read())
            {
                //put field data from 'birdname' into variable
                string name = rdr["Name"].ToString();
                //put variable value into textbox birdsnametext
                nameEdit.Text = name;

                string description = rdr["Descrption"].ToString();
                descriptionEdit.Text = description;

                string price = rdr["Price"].ToString();
                priceEdit.Text = price;

                //need to add in image

                string itemCat = rdr["CategoryID"].ToString();
                itemCatEdit.Text = itemCat;

                string itemVis = rdr["visability"].ToString();
                visEdit.Text = itemVis;

                string itemSpons = rdr["Sponsored"].ToString();
                sponsEdit.Text = itemSpons;

                

            }
        }


    }



    protected void editItemInfoBtn_Click(object sender, EventArgs e)
    {
        string UpPath = Server.MapPath("~/files");

        Random r = new Random();
        int rInt = r.Next(0, 10000);

        if (!Directory.Exists(UpPath))
        {
            Directory.CreateDirectory(UpPath);

        }
        else
        {
            int imgSize = itemImageEdit.PostedFile.ContentLength;
            string imgName = itemImageEdit.FileName;
            string imgPath = "~/files/" + rInt + imgName;

            if (itemImageEdit.PostedFile.ContentLength > 1500000)
            {
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big.')", true);
            }
            else
            {
                //then save it to the Folder
                itemImageEdit.SaveAs(Server.MapPath(imgPath));
                // myinfo.Text = "file " + imgPath + " uploaded";
            }
        }





        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);

        myConnection.Open();

        int row = int.Parse(Request.QueryString["editItemId"]);
        string name = nameEdit.Text;
        string description = descriptionEdit.Text;
        string price = priceEdit.Text;
        string image = rInt + itemImageEdit.FileName;
        int itemCat = Convert.ToInt16(itemCatEdit.SelectedValue);
        int vis = Convert.ToInt16(visEdit.SelectedValue);
        int spons = Convert.ToInt16(sponsEdit.SelectedValue);

        if(itemImageEdit.HasFile){
            string query = "Update itemsForSale SET Name=@name, Descrption=@description, Price=@price,ImagePath=@image,CategoryID=@itemCat,visability=@vis,Sponsored=@spons WHERE Id=@id";

            SqlCommand myCommand = new SqlCommand(query, myConnection);

            myCommand.Parameters.AddWithValue("@id", row);
            myCommand.Parameters.AddWithValue("@name", name);
            myCommand.Parameters.AddWithValue("@description", description);
            myCommand.Parameters.AddWithValue("@price", price);
            myCommand.Parameters.AddWithValue("@image", image);
            myCommand.Parameters.AddWithValue("@itemCat", itemCat);
            myCommand.Parameters.AddWithValue("@vis", vis);
            myCommand.Parameters.AddWithValue("@spons", spons);

            myCommand.ExecuteNonQuery();
            
        }
        else
        {
            string queryNP = "Update itemsForSale SET Name=@name, Descrption=@description, Price=@price,CategoryID=@itemCat,visability=@vis,Sponsored=@spons WHERE Id=@id";

            SqlCommand myCommandNP = new SqlCommand(queryNP, myConnection);

            myCommandNP.Parameters.AddWithValue("@id", row);
            myCommandNP.Parameters.AddWithValue("@name", name);
            myCommandNP.Parameters.AddWithValue("@description", description);
            myCommandNP.Parameters.AddWithValue("@price", price);
            myCommandNP.Parameters.AddWithValue("@itemCat", itemCat);
            myCommandNP.Parameters.AddWithValue("@vis", vis);
            myCommandNP.Parameters.AddWithValue("@spons", spons);

            myCommandNP.ExecuteNonQuery();
        }


       
        myConnection.Close();

        Response.Redirect("myAccount.aspx");

    }

    protected void deleteItemBtn_Click(object sender, EventArgs e)
    {


        string connectionString = WebConfigurationManager.ConnectionStrings["elmtreeConnection"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(connectionString);
        myConnection.Open();

        int row = int.Parse(Request.QueryString["editItemId"]);
        string query = "DELETE FROM itemsForSale WHERE Id=@id";

        SqlCommand myCommand = new SqlCommand(query, myConnection);

        myCommand.Parameters.AddWithValue("@id", row);
        myCommand.ExecuteNonQuery();

        int messageRow = int.Parse(Request.QueryString["editItemId"]);
        string queryMsgDel = "DELETE FROM messages WHERE itemId=@id";

        SqlCommand myCommandMsgDel = new SqlCommand(queryMsgDel, myConnection);

        myCommandMsgDel.Parameters.AddWithValue("@id", messageRow);
        myCommandMsgDel.ExecuteNonQuery();

        myConnection.Close();

        Response.Redirect("myAccount.aspx");








        Response.Redirect("myAccount.aspx");







    }
}