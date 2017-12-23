using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Diagnostics;
using System.Net;

namespace CIT12
{
    public class Email
    {
        //takes in the email variable input and execuates the method

        public static bool SendEmail(MailAddress toAddress, string header, string subject, string body)
        {
            MailMessage newPM = new MailMessage();
            newPM.To.Add(toAddress);
            newPM.From = new MailAddress("cit12group@gmail.com", header, System.Text.Encoding.UTF8);
            newPM.Subject = subject;
            newPM.Body = body;
            newPM.IsBodyHtml = true;
            SmtpClient smtpgmail = new SmtpClient();
            smtpgmail.Credentials = new System.Net.NetworkCredential("cit12group@gmail.com", "group12password");
            smtpgmail.Port = 587;
            smtpgmail.Host = "smtp.gmail.com";
            smtpgmail.EnableSsl = true;

            try
            {
                smtpgmail.Send(newPM);

            }
            catch (Exception ex)
            {

                Debug.WriteLine(ex);
                return false;
            }

            return true;
        }






    }
}