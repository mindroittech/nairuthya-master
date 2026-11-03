using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Helper
/// </summary>

public enum StatusCodes
{
    Pending = 1,
    Success = 2,
    Failed = 3,
    Refund = 4
}
public static class Helper
{
    static DataClassesDataContext db = new DataClassesDataContext();
    public static int totalRegistration(DateTime date)
    {
        var find = (from c in db.tblMembers
                    where c.joindate.Value.Date == date
                    select c.id).Count();

        return find;

    }
   
    public static string GenerateOTP()
    {
        string strPwdchar = "1234567890";
        string otp = "";
        Random rnd = new Random();
        for (int i = 0; i <= 5; i++)
        {
            int iRandom = rnd.Next(0, strPwdchar.Length - 1);
            otp += strPwdchar.Substring(iRandom, 1);
        }

        return otp;
    }

    public static decimal totalPayout(DateTime date)
    {
        var find = (from c in db.PaymentRequests
                    where c.status == "Paid" && c.paiddate.Value.Date == date && c.comments!= "Self Pin Generation"
                    select c.amount).Sum();
        return find ?? 0;
    }
    public static decimal totalTDS(DateTime date)
    {
        var find = (from c in db.PaymentRequests
                    where c.status == "Paid" && c.paiddate.Value.Date == date
                    select c.tax).Sum();
        return find ?? 0;
    }
    public static decimal totalAC(DateTime date)
    {
        var find = (from c in db.PaymentRequests
                    where c.status == "Paid" && c.paiddate.Value.Date == date
                    select c.sc).Sum();
        return find ?? 0;
    }
   
}