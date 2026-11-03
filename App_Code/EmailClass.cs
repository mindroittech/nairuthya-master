using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;

/// <summary>
/// Summary description for EmailClass
/// </summary>
public class EmailClass
{
	public EmailClass()
	{
		
	}

    public string SendMail(string from, string name,string to,string subject,string body)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(from, name);
            mail.To.Add(new MailAddress(to));
            mail.Subject = subject;
            mail.Body = body + "<br/><br/> ";
            mail.IsBodyHtml = true;
            SmtpClient client = new SmtpClient("mail.plutocrat.co.in");
         
            client.Port =587;
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential("admin@plutocrat.co.in", "plutoblr34#");
            client.EnableSsl =false;
            client.Send(mail);
          
        }
        catch
        {

        }
        return "true";
    }
}