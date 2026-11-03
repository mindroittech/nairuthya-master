using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_view_members : System.Web.UI.Page
{
    DataClassesDataContext db = new DataClassesDataContext();
    sendsms send = new sendsms();
    protected void Page_Load(object sender, EventArgs e)
    {
        Label2.Visible = false;
        try
        {
            string admin = Session["admin"].ToString();

        }

        catch
        {
            Response.Redirect("../adminlogin.aspx");
        }
    }

    public bool IsVisible(string status)
    {

        if (status == "Stopped")
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string uname = e.CommandArgument.ToString();

            if (e.CommandName == "profile")
            {
                Response.Redirect("mprofile.aspx?uname=" + uname);
            }
          
            if (e.CommandName == "stop")
            {
                var find = db.tblMembers.Where(x => x.username == uname).SingleOrDefault();

                find.status = "Stopped";
                find.enddate = DateTime.UtcNow.AddHours(5.5);

                db.SubmitChanges();

                Response.Redirect("view-members.aspx");
            }

        }
        catch
        { }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       // Response.Redirect("mem-export.aspx?plan=All");
        Export();
    }

   
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void Export1()
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Members.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView1.AllowPaging = false;
        GridView1.DataBind();
        //Change the Header Row back to white color
        GridView1.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < GridView1.HeaderRow.Cells.Count; i++)
        {
            GridView1.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        GridView1.RenderControl(htw);

        GridView1.AllowPaging = true;
        GridView1.DataBind();
        Response.Write(sw.ToString());
        Response.End();
    }

    protected void Export()
    {
        Filter();
      
        GridView1.Columns[7].Visible = false; // Profile
      
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename= Members.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            GridView1.AllowPaging = false;
            GridView1.DataBind();

            GridView1.RowStyle.HorizontalAlign = HorizontalAlign.Center;
            foreach (GridViewRow row in GridView1.Rows)
            {
               
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GridView1.RowStyle.BackColor;
                    }
                    if (row.Cells[3] == cell || row.Cells[7] == cell)
                        cell.CssClass = "text";
                    else
                        cell.CssClass = "textmode";
                }
            }

            GridView1.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } .text{mso-number-format:\@; }  </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    private void Filter()
    {
        if (TextBox1.Text == string.Empty || TextBox2.Text == string.Empty)
        {
            Label2.Text = "Select Date";
            Label2.Visible = true;
            return;
        }

        DateTime startDate = Convert.ToDateTime(TextBox1.Text);
        DateTime endDate = Convert.ToDateTime(TextBox2.Text);

        startDate = startDate.Date;
        endDate = endDate.Date.AddDays(1).AddMilliseconds(-1);

        string userInput = TextBox3.Text.Trim();

        // LINQ query to retrieve members based on join date and active status
        var get = from c in db.tblMembers
                  where c.joindate >= startDate && c.joindate <= endDate && c.isActive == 1
                  select new
                  {
                      c.id,
                      c.username,
                      c.name,
                      c.pan,
                      c.status,
                      c.mobile,
                      c.amount,
                      c.joindate,
                      c.noOfunits
                  };

        // Set the GridView data source to the result of the LINQ query
        GridView1.DataSourceID = null;
        GridView1.AllowPaging = false;

        if (!string.IsNullOrEmpty(userInput))
        {
            get = get.Where(c =>
                c.username.Contains(userInput) ||
                c.name.Contains(userInput) ||
                c.mobile.Contains(userInput));
        }
        GridView1.DataSource = get;
        GridView1.DataBind();
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chk = row.FindControl("CheckBox1") as CheckBox;

                if (chk != null && chk.Checked)
                {
                    int memberId = Convert.ToInt32(
                        GridView1.DataKeys[row.RowIndex].Values["id"]
                    );

                    var member = db.tblMembers
                                   .SingleOrDefault(c => c.id == memberId);

                    if (member != null)
                    {
                        member.isActive = 0;
                    }
                }
            }
        }

        db.SubmitChanges();

        Response.Redirect("view-members.aspx");
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        try
        {
            if (TextBox1.Text == string.Empty || TextBox2.Text == string.Empty)
            {
                Label2.Text = "Select Date";
                Label2.Visible = true;
                return;
            }

            DateTime startDate = Convert.ToDateTime(TextBox1.Text);
            DateTime endDate = Convert.ToDateTime(TextBox2.Text);

            startDate = startDate.Date;  
            endDate = endDate.Date.AddDays(1).AddMilliseconds(-1);

            // LINQ query to retrieve members based on join date and active status
            var get = from c in db.tblMembers
                      where c.joindate >= startDate && c.joindate <= endDate && c.isActive == 1
                      select new
                      {
                          c.id,
                          c.username,
                          c.name,
                          c.pan,
                          c.status,
                          c.mobile,
                          c.amount,
                          c.noOfunits,
                          c.joindate,
                         
                      };

            // Set the GridView data source to the result of the LINQ query
            GridView1.DataSourceID = null;
            GridView1.AllowPaging = false;
            GridView1.DataSource = get;
            GridView1.DataBind();
        }
        catch
        {
            Label2.Text = "Select Date";
            Label2.Visible = true;

        }
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("view-members.aspx");
    }
    protected void Button5_Click(object sender, EventArgs e)
    {

        if (TextBox3.Text == string.Empty)
        {
            Label2.Text = "Enter Username or Name or Mobile";
            Label2.Visible = true;
            return;
        }
        var get = from c in db.tblMembers
                  where ( c.name.Contains(TextBox3.Text) || c.mobile.Contains(TextBox3.Text)) && c.isActive == 1
                  select new
                  {
                      c.id,
                      c.username,
                      c.name,
                      c.pan,
                      c.status,
                      c.mobile,
                      c.amount,
                      c.noOfunits,
                      c.joindate,
                     
                  };

        // Set the GridView data source to the result of the LINQ query
        GridView1.DataSourceID = null;
        GridView1.AllowPaging = false;
        GridView1.DataSource = get;
        GridView1.DataBind();
    }
    protected void btnSms_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox chk = row.FindControl("CheckBox1") as CheckBox;

            if (chk.Checked)
            {
                string uname = row.Cells[1].Text.Trim();

                var insert = (from c in db.tblMembers
                          where c.username == uname
                          select c).SingleOrDefault();

                //string msg = "Dear " + insert.name + ", Welcome to AGS Group. Your Login ID:" + insert.username + "and Password:" + insert.password + " Login at: https://www.agsgroupind.com";
                //send.sms(insert.mobile, msg, "1407175915349613985");

            }

        }

        Response.Redirect("view-members.aspx");
    }
}