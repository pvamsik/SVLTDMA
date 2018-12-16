using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StarMicronics.StarIO;
using System.Configuration;
using System.Drawing;
using System.Text;
using System.Drawing.Printing;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using CommonDTO;

public partial class Administration_printerSettings : System.Web.UI.Page
{
    public Data data;

    static System.Drawing.Font headerFont = new Font("Old English Text MT", 14, FontStyle.Bold);
    static System.Drawing.Font subHeaderFont = new Font("Calibri", 9, FontStyle.Bold);
    static System.Drawing.Font regularFont = new Font("Calibri", 9, FontStyle.Regular);
    static System.Drawing.Font boldFont = new Font("Calibri", 9, FontStyle.Bold);
    static float height = 14.0F;
    protected void Page_Load(object sender, EventArgs e)
    {
        data = new Data();
        lblName.Text = Request.UserHostName;
    }

    protected void cmdSavePrinterSettings_Click(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString());
        string sql = "INSERT INTO printerSettings(name, mode, port, settings) VALUES (@name, @type, @port, @settings)";

        SqlCommand com = new SqlCommand(sql, conn);
        com.Parameters.Add("@name", SqlDbType.NVarChar).Value = lblName.Text;
        com.Parameters.Add("@type", SqlDbType.NVarChar).Value = rblClientType.SelectedValue.ToString();
        com.Parameters.Add("@port", SqlDbType.NVarChar).Value = txtPrinterPort.Text;
        com.Parameters.Add("@settings", SqlDbType.NVarChar).Value = txtPortSetting.Text;

        try
        {
            conn.Open();
            com.CommandType = CommandType.Text;
            com.ExecuteNonQuery();

            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            messages.InnerHtml = "<script>$(document).ready(function() { $('#message').fadeOut( 10000 ); });</script><div id='message' class='alert alert-danger'>";
            messages.InnerHtml += "<button type='button' class='close' data-dismiss='alert'>&times;</button>";
            messages.InnerHtml += ex.GetType().ToString() + ": " + ex.Message;
            messages.InnerHtml += "</div>";
        }
        finally
        {
            conn.Close();
        }


        ////Save the Printer Settings to Web Configuration file.
        //ConfigurationManager.AppSettings["portName"] = txtPrinterPort.Text;
        //ConfigurationManager.AppSettings["portSettings"] = txtPortSetting.Text;

        ////Test the printer connectivity based on new printer settings.
        //testPrinter();
    }

    /// <summary>
    /// This function tests if the printer is currently available or not and sets the status on the Printer Settings screen.
    /// </summary>
    private void testPrinter()
    {
        printManager pM = new printManager();
        if (pM.testPrinterStatus() == true)
        {
            pM.printTestMessage("Printer is Available");
            lblPrinterStatus.Text = "Printer Online!!!";
            lblPrinterStatus.ForeColor = Color.Green;
        }
        else
        {
            lblPrinterStatus.Text = "Printer Offline!!!";
            lblPrinterStatus.ForeColor = Color.Red;
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[rowIndex];

            string printerPort = row.Cells[4].Text;
            string printerSettings = (row.Cells[5].Text).Replace("&nbsp;", "").Trim();
            printManager pM = new printManager(printerPort, printerSettings);
            try
            {
                pM.printReceipt("Abhishekam", "$ 1,000,000.00");
            }
            catch (Exception ex)
            {
                messages.InnerText = ex.Message.ToString();
            }
            
            //List<ClientDTO> clients;
            //if(Application["clients"] != null)
            //{
            //    clients = Application["clients"] as List<ClientDTO>;
            //}
            //else
            //{
            //    clients = data.GetClients();
            //}
            //if(clients != null)
            //{
            //    string ipAddress = Request.UserHostName;
            //    ClientDTO client = clients.Where(x => x.ClientIP == ipAddress).SingleOrDefault();

            //    string printerPort = client.PrinterPort;
            //    string printerSettings = client.PrinterSettings;
            //    if (string.IsNullOrEmpty(printerSettings))
            //        printerSettings = "";

            //    printManager pM = new printManager(printerPort, printerSettings);
            //    pM.printReceipt("Abhishekam", "$ 1,000,000.00");
            //}

            /*
            TOMPrintManager pm = new TOMPrintManager();
            using(OrderEntities context = new OrderEntities() )
            {
                Order o = context.Orders.FirstOrDefault(c => c.Id == 1);
                pm.print(o);
            }
            */
            //PrintDocument pd = new PrintDocument();
            //pd.DefaultPageSettings.Landscape = false;
            //pd.OriginAtMargins = false;
            //pd.PrintPage += new PrintPageEventHandler(testPrintPage);
            //pd.Print();
        }
    }

    //// The PrintPage event is raised for each page to be printed.
    //private void testPrintPage(object sender, PrintPageEventArgs ev)
    //{
    //    float yPos = 0;
    //    float leftMargin = 0; //ev.MarginBounds.Left;
    //    float topMargin = 5; // ev.MarginBounds.Top;
    //    float rightMargin = ev.MarginBounds.Right;
    //    String line = "";

    //    ev.Graphics.PageUnit = GraphicsUnit.Point;
    //    float pageWidth = 213.0F;


    //    // Print SVLT Header
    //    line = "Sri Venkateswara Lotus Temple\n";
    //    ev.Graphics.DrawString(line, headerFont, Brushes.Black, leftMargin, yPos, new StringFormat());
    //    yPos = yPos + headerFont.GetHeight(ev.Graphics);
    //    line = "12501 Braddock Rd, Fairfax, VA - 22030";
    //    ev.Graphics.DrawString(line, subHeaderFont, Brushes.Black, leftMargin, yPos, new StringFormat());
    //    yPos += subHeaderFont.GetHeight(ev.Graphics);

    //    //Print Devotee Information
    //    line = "\n";
    //    line += "Name: " + "Vamsi Pulavarthi \n";

    //    /*
    //     * Cash: No additional data to be printed
    //     * In Kind: No addtional data to be printed
    //     * Check: Print the following
    //     *          Check Number
    //     *          Check Date
    //     *          If Check deposit is enabled, print the following additional data 
    //     *              Routing Number 
    //     *              Account Number
    //     * Credit Card: Print the following
    //     *          Name
    //     *          Transaction ID
    //     *          Card Type
    //     *          Card Number
    //     *          Expiration Date
    //     *          Approval Code
    //     *          Transaction Type: Purchase, Void, Refund etc.
    //     */
    //    line += "Payment Method: " + "Credit Card \n";
    //    line += "Transaction ID: " + "7850879064 \n";
    //    line += "Card Type: " + "Visa \n";
    //    line += "Card Number: " + "XXXX0010 \n";
    //    line += "Exp Dt: " + "09/19 \n";
    //    line += "Approval Code: " + "001986 \n";
    //    line += "Transaction Type: " + "Purchase \n\n";
    //    ev.Graphics.DrawString(line, regularFont, Brushes.Black, leftMargin, yPos, new StringFormat());

    //    yPos += (regularFont.GetHeight(ev.Graphics) * 11);

    //    //line = "12345678901234567890123456789012345";
    //    //line += "\n" + ev.Graphics.MeasureString(line, regularFont);
    //    //line += processFeeDisplay("Fee Name - EXTRA EXTRA EXTRA EXTRA EXTRA EXTRA LONG", "10.00", ev);

    //    //line += "-----------------------------------------------------\n";
    //    //line += "Service Date: " + "09/08/2016 \n";
    //    //line += "Archana       " + "21.00 \n";
    //    //line += "\nService Date: " + "09/10/2016 \n";
    //    //line += processFeeDisplay("My Fee name is not very long", "10.00");
    //    //line += processFeeDisplay("Short Fee Name", "10.00");
    //    //string feeName = "My Fee name ";

    //    //line += processFeeDisplay("My Fee name long long long long long long long long long", "10.00");
    //    //line += "-----------------------------------------------------\n\n";
    //    //line += "CARDMEMBER ACKNOWLEDGES RECEIPT OF GOODS \n";
    //    //line += "AND/OR SERVICES IN THE AMOUNT OF THE TOTAL SHOWN\n";
    //    //line += "HEREON AND AGREES TO PERFORM THE OBLIGATIONS SET\n";
    //    //line += "FORTH BY THE CARDMEMBER'S AGREEMENT WITH THE \nISSUER. \n";
    //    //line += "-----------------------------------------------------\n\n";
    //    //line += "Thank You for your patronage at SV Lotus Temple";
    //    //yPos = yPos + subHeaderFont.GetHeight(ev.Graphics);

    //    ev.Graphics.DrawLine(Pens.Black, 0, yPos, pageWidth, yPos);
    //    yPos += height;
    //    yPos = processFeeDisplay("Fee Name", "Amt", "Qty", ev, yPos, "orderTotal");
    //    ev.Graphics.DrawLine(Pens.Black, 0, yPos, pageWidth, yPos);
    //    yPos += height;
    //    yPos = processFeeDisplay("1234567890", "$ 51.00", "1", ev, yPos, "orderItem");
    //    yPos = processFeeDisplay("123456789012345678901234567890", "$ 1,000,000.00", "251", ev, yPos, "orderItem");
    //    ev.Graphics.DrawLine(Pens.Black, 0, yPos, pageWidth, yPos);
    //    yPos += height;
    //    yPos = processFeeDisplay("Total Amount", "$ 1,000,000.00", "1261", ev, yPos, "orderTotal");
    //    ev.Graphics.DrawLine(Pens.Black, 0, yPos, pageWidth, yPos);
    //    yPos += height;
    //}

    //public float processFeeDisplay(string feeName, string feeAmount, string quantity, PrintPageEventArgs ev, float y, string type)
    //{

    //    float maxFeeNameSize = 125.0F;
    //    float maxQtySize = 23.0F;
    //    float maxFeeAmountSize = 63.0F;

    //    // Create rectangle for drawing.
    //    float x = 0.0F;


    //    // Construct 2 new StringFormat objects
    //    StringFormat format1 = new StringFormat(StringFormatFlags.NoClip);
    //    StringFormat format2 = new StringFormat(format1);

    //    // Set the LineAlignment and Alignment properties for
    //    // both StringFormat objects to different values.
    //    format1.LineAlignment = StringAlignment.Center;
    //    format1.Alignment = StringAlignment.Near;
    //    format2.LineAlignment = StringAlignment.Center;
    //    format2.Alignment = StringAlignment.Far;

    //    if (type == "orderItem")
    //    {
    //        RectangleF leftRect = new RectangleF(new PointF(x, y), new SizeF(maxFeeNameSize, regularFont.GetHeight(ev.Graphics)));
    //        RectangleF middleRect = new RectangleF(new PointF(x + maxFeeNameSize, y), new SizeF(maxQtySize, regularFont.GetHeight(ev.Graphics)));
    //        RectangleF rightRect = new RectangleF(new PointF(x + maxFeeNameSize + maxQtySize, y), new SizeF(maxFeeAmountSize, regularFont.GetHeight(ev.Graphics)));

    //        ev.Graphics.DrawString(feeName, regularFont, Brushes.Black, leftRect, format1);
    //        ev.Graphics.DrawString(quantity.ToString(), regularFont, Brushes.Black, middleRect, format2);
    //        ev.Graphics.DrawString(feeAmount, regularFont, Brushes.Black, rightRect, format2);
    //    }
    //    if(type == "orderTotal")
    //    {
    //        RectangleF leftRect = new RectangleF(new PointF(x, y), new SizeF(maxFeeNameSize, boldFont.GetHeight(ev.Graphics)));
    //        RectangleF middleRect = new RectangleF(new PointF(x + maxFeeNameSize, y), new SizeF(maxQtySize, boldFont.GetHeight(ev.Graphics)));
    //        RectangleF rightRect = new RectangleF(new PointF(x + maxFeeNameSize + maxQtySize, y), new SizeF(maxFeeAmountSize, boldFont.GetHeight(ev.Graphics)));

    //        ev.Graphics.DrawString(feeName, boldFont, Brushes.Black, leftRect, format1);
    //        ev.Graphics.DrawString(quantity.ToString(), regularFont, Brushes.Black, middleRect, format2);
    //        ev.Graphics.DrawString(feeAmount, boldFont, Brushes.Black, rightRect, format2);
    //    }

    //    y += height;
    //    return y;
    //}

    //public void moveLine(RectangleF r, float height)
    //{
    //    r.Y += height;
    //}
}