using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Net;
using System.Configuration;
using System.Threading.Tasks;

/// <summary>
/// Summary description for sendsms
/// </summary>
public class sendsms
{
    public sendsms()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string sms(string mob, string msg, string templateId)
    {
        Task.Factory.StartNew(() =>
        {
            if (ConfigurationManager.AppSettings["env"] == "prod")
            {
                string sURL;
                string key = "d71ec9052405cb50831087b1b7fcc6f6";
                string sender = "AGRBRT";
                WebRequest wrGETURL;
                StreamReader objReader;

                sURL = string.Format("http://login.redsms.in/api/smsapi?key={0}&route=2&sender={1}&number={2}&sms={3}&templateid={4}", key, sender, mob, msg, templateId);
                //red sms2

                wrGETURL = WebRequest.Create(sURL);
                try
                {
                    Stream objStream;
                    objStream = wrGETURL.GetResponse().GetResponseStream();
                    objReader = new StreamReader(objStream);
                    objReader.Close();

                }
                catch
                {

                }
            }
        });
        return "Sms has been sent ";
    }
}