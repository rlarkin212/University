using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using PlanningPokerLib;


namespace CIT12
{
    public partial class PlanningPoker : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_loggedUserId"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnGetStats_Click(object sender, EventArgs e)
        {

            PlanningPokerLib.PlanningPoker ppLib = new PlanningPokerLib.PlanningPoker();

            ArrayList Values = new ArrayList();

            //seperators fro txt box values
            char[] delimiterChars = { ' ', ',', '.', ':', '\t' };
            string rawValues = txtValues.Text;

            //array of the split values
            string[] stringValues = rawValues.Split(delimiterChars);

            //iterates through the stringValues aray converting to a double and then adding to the median Values Array list
            foreach (var val in stringValues)
            {
                string value = val;
                Values.Add(Convert.ToInt32(value));
            }

            //median
            Int32 median = ppLib.GetMedian((Int32[])Values.ToArray(typeof(Int32)));
            lblMedian.Text = median.ToString();

            //mean
            Int32 mean = ppLib.GetMean((Int32[])Values.ToArray(typeof(Int32)));
            lblMean.Text = mean.ToString();

            //mode
            Int32 mode = ppLib.GetMode((Int32[])Values.ToArray(typeof(Int32)));
            lblMode.Text = mode.ToString();


            //max
            Int32 max = ppLib.GetMax((Int32[])Values.ToArray(typeof(Int32)));
            lblMax.Text = max.ToString();

            //min
            Int32 min = ppLib.GetMin((Int32[])Values.ToArray(typeof(Int32)));
            lblMin.Text = min.ToString();

            //standard deviation
            Int32 standardDeviation = ppLib.GetStandardDeviation((Int32[])Values.ToArray(typeof(Int32)));
            lblStandardDeviation.Text = standardDeviation.ToString();
        }


    }
}