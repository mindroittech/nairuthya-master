using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class confirm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["pro"] == "sub")
        {
            Panel1.Visible = true;
            lblName.Text = Request.QueryString["n"];
        }

    }
}