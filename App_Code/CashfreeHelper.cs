
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;

public static class CashfreeHelper
{
    private static string BaseUrl
    {
        get
        {
            return "https://sandbox.cashfree.com/pg";
        }
    }

    private static string ApiVersion
    {
        get
        {
            return ConfigurationManager.AppSettings["CashfreeApiVersion"];
        }
    }

    private static string GetSetting(string key)
    {
        string value = ConfigurationManager.AppSettings[key];

        if (string.IsNullOrWhiteSpace(value))
            throw new Exception("Missing Web.config setting: " + key);

        return value.Trim();
    }

    private static string ApiCall(
        string method,
        string url,
        string json)
    {
        ServicePointManager.SecurityProtocol =
            SecurityProtocolType.Tls12;

        HttpWebRequest request =
            (HttpWebRequest)WebRequest.Create(url);

        request.Method = method;
        request.ContentType = "application/json";
        request.Accept = "application/json";

        request.Headers.Add(
            "x-client-id",
            GetSetting("CashfreeAppId")
        );

        request.Headers.Add(
            "x-client-secret",
            GetSetting("CashfreeSecretKey")
        );

        request.Headers.Add(
            "x-api-version",
            GetSetting("CashfreeApiVersion")
        );

        request.Headers.Add(
            "x-request-id",
            Guid.NewGuid().ToString()
        );

        request.Timeout = 30000;
        request.ReadWriteTimeout = 30000;

        if (method == "POST")
        {
            request.Headers.Add(
                "x-idempotency-key",
                Guid.NewGuid().ToString()
            );

            byte[] bytes = Encoding.UTF8.GetBytes(json);

            request.ContentLength = bytes.Length;

            using (Stream stream = request.GetRequestStream())
            {
                stream.Write(bytes, 0, bytes.Length);
            }
        }

        try
        {
            using (HttpWebResponse response =
                (HttpWebResponse)request.GetResponse())
            {
                using (StreamReader reader =
                    new StreamReader(response.GetResponseStream()))
                {
                    return reader.ReadToEnd();
                }
            }
        }
        catch (WebException ex)
        {
            string errorResponse = "";
            string statusCode = "";

            if (ex.Response != null)
            {
                HttpWebResponse httpResponse =
                    ex.Response as HttpWebResponse;

                if (httpResponse != null)
                    statusCode = ((int)httpResponse.StatusCode).ToString();

                using (StreamReader reader =
                    new StreamReader(ex.Response.GetResponseStream()))
                {
                    errorResponse = reader.ReadToEnd();
                }
            }

            string errorMessage =
                "Cashfree API Error | HTTP Status: " +
                statusCode +
                " | Message: " +
                ex.Message +
                " | Response: " +
                errorResponse;

            System.Diagnostics.Trace.TraceError(errorMessage);

            throw new Exception(errorMessage, ex);
        }
    }

    public static Dictionary<string, object> CreateOrder(
        string orderId,
        decimal amount,
        string customerName,
        string mobile)
    {
        if (string.IsNullOrWhiteSpace(orderId))
            throw new Exception("Order ID is required.");

        if (amount <= 0)
            throw new Exception("Invalid payment amount.");

        if (string.IsNullOrWhiteSpace(mobile))
            throw new Exception("Customer mobile number is required.");

        mobile = mobile.Trim();

        if (mobile.Length != 10)
            throw new Exception("Customer mobile number must contain 10 digits.");

        foreach (char c in mobile)
        {
            if (!char.IsDigit(c))
                throw new Exception("Invalid customer mobile number.");
        }

        JavaScriptSerializer serializer =
            new JavaScriptSerializer();

        Dictionary<string, object> customer =
            new Dictionary<string, object>();

        customer.Add("customer_id", "REG_" + mobile);
        customer.Add("customer_phone", mobile);

        Dictionary<string, object> orderMeta =
            new Dictionary<string, object>();

        orderMeta.Add(
            "return_url",
            "https://nairuthya.in/payment-return.aspx?order_id={order_id}"
        );

        Dictionary<string, object> body =
            new Dictionary<string, object>();

        body.Add("order_id", orderId);
        body.Add("order_amount", Math.Round(amount, 2));
        body.Add("order_currency", "INR");
        body.Add("customer_details", customer);
        body.Add("order_meta", orderMeta);
        body.Add("order_note", "Member Registration");

        string json = serializer.Serialize(body);

        string response = ApiCall(
            "POST",
            BaseUrl + "/orders",
            json
        );

        Dictionary<string, object> result =
            serializer.Deserialize<Dictionary<string, object>>(response);

        if (result == null ||
            !result.ContainsKey("payment_session_id") ||
            string.IsNullOrWhiteSpace(
                Convert.ToString(result["payment_session_id"])))
        {
            throw new Exception(
                "Cashfree did not return a valid payment_session_id. Response: " +
                response
            );
        }

        return result;
    }

    public static Dictionary<string, object> FetchOrder(
        string orderId)
    {
        JavaScriptSerializer serializer =
            new JavaScriptSerializer();

        string response = ApiCall(
            "GET",
            BaseUrl + "/orders/" +
            Uri.EscapeDataString(orderId),
            null
        );

        return serializer.Deserialize<
            Dictionary<string, object>>(response);
    }

    public static ArrayList FetchPayments(string orderId)
    {
        JavaScriptSerializer serializer =
            new JavaScriptSerializer();

        string response = ApiCall(
            "GET",
            BaseUrl + "/orders/" +
            Uri.EscapeDataString(orderId) +
            "/payments",
            null
        );

        return serializer.Deserialize<ArrayList>(response);
    }
}
