using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using CommonDTO;
using System.Globalization;
using CommonDTO.Entities;

/// <summary>
/// Summary description for TOMPrintManager
/// </summary>
public class TOMPrintManager
{
    static System.Drawing.Font headerFont = new Font("Old English Text MT", 14, FontStyle.Bold);
    static System.Drawing.Font subHeaderFont = new Font("Calibri", 9, FontStyle.Bold);
    static System.Drawing.Font regularFont = new Font("Calibri", 9, FontStyle.Regular);
    static System.Drawing.Font boldFont = new Font("Calibri", 9, FontStyle.Bold);
    static float height = 14.0F;
    static float maxFeeNameSize = 125.0F;
    static float maxQtySize = 23.0F;
    static float maxFeeAmountSize = 63.0F;
    Order po;

    public TOMPrintManager()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public void print(Order o)
    {
        po = o;
        PrintDocument pd = new PrintDocument();
        pd.DefaultPageSettings.Landscape = false;
        pd.OriginAtMargins = false;
        pd.PrintPage += new PrintPageEventHandler(printData);
        pd.Print();
    }

    private void printData(object sender, PrintPageEventArgs ev)
    {
        float yPos = 0;
        float leftMargin = 0;
        float rightMargin = ev.MarginBounds.Right;
        ev.Graphics.PageUnit = GraphicsUnit.Point;

        // Print SVLT Header
        String line = "";
        line = "Sri Venkateswara Lotus Temple\n";
        ev.Graphics.DrawString(line, headerFont, Brushes.Black, leftMargin, yPos, new StringFormat());
        yPos = yPos + headerFont.GetHeight(ev.Graphics);
        line = "12501 Braddock Rd, Fairfax, VA - 22030";
        ev.Graphics.DrawString(line, subHeaderFont, Brushes.Black, leftMargin, yPos, new StringFormat());
        yPos += subHeaderFont.GetHeight(ev.Graphics);

        //Print Devotee Information
        line = "\n";
        line += "Name: " + "Vamsi Pulavarthi \n";

        /*
         * Cash: No additional data to be printed
         * In Kind: No addtional data to be printed
         * Check: Print the following
         *          Check Number
         *          Check Date
         *          If Check deposit is enabled, print the following additional data 
         *              Routing Number 
         *              Account Number
         * Credit Card: Print the following
         *          Name
         *          Transaction ID
         *          Card Type
         *          Card Number
         *          Expiration Date
         *          Approval Code
         *          Transaction Type: Purchase, Void, Refund etc.
         */
        line += "Payment Method: " + po.paymentMethodName + "\n";
        if(po.paymentMethodName == "CREDIT CARD")
        {
            line += "Transaction ID: " + po.authorizationTransactionId + "\n";
            line += "Card Type: " + po.cardType + "\n";
            line += "Card Number: " + po.cardNumberMasked + "\n";
            line += "Order Date: " + po.orderDate + "\n";
            line += "Approval Code: " + po.authorizationTransactionCode + "\n\n";
            line += "-----------------------------------------------------\n";

            ev.Graphics.DrawString(line, regularFont, Brushes.Black, leftMargin, yPos, new StringFormat());
            yPos += (regularFont.GetHeight(ev.Graphics) * 11);
        } else
        {

        }
        if (po.paymentMethodName == "CHECK")
        {
            line += "Check Number: " + po.checkNumber + "\n";
            line += "Check Date: " + po.checkDate + "\n";
            line += "-----------------------------------------------------\n";

            ev.Graphics.DrawString(line, regularFont, Brushes.Black, leftMargin, yPos, new StringFormat());
            yPos += (regularFont.GetHeight(ev.Graphics) * 7);
        }
        if (po.paymentMethodName == "CASH" || po.paymentMethodName == "IN KIND")
        {
            line += "-----------------------------------------------------\n";

            ev.Graphics.DrawString(line, regularFont, Brushes.Black, leftMargin, yPos, new StringFormat());
            yPos += (regularFont.GetHeight(ev.Graphics) * 5);
        }

        yPos = processFeeDisplay("Fee Name", "Amt", "Qty", ev, yPos, "orderTotal");

        List<string> serviceDates = po.OrderItems.Select(i => i.serviceDate).Distinct().ToList();
        foreach (var sd in serviceDates)
        {
            ev.Graphics.DrawString(sd.ToString(), boldFont, Brushes.Black, leftMargin, yPos, new StringFormat());
            yPos += regularFont.GetHeight(ev.Graphics);

            foreach (var item in po.OrderItems.Where(x => x.serviceDate == sd).ToList())
            {
                yPos = processFeeDisplay(item.serviceName.ToString(), string.Format("{0:C}", item.price), item.quantity.ToString(), ev, yPos, "orderItem");
            }

        }
        yPos = processFeeDisplay("Total Amount", string.Format("{0:C}", po.orderTotal), po.orderItemCount.ToString(), ev, yPos, "orderTotal");

        //line += "Service Date: " + "09/08/2016 \n";
        line = "-----------------------------------------------------\n\n";
        line += "Thank You for your patronage at SV Lotus Temple";
        ev.Graphics.DrawString(line, regularFont, Brushes.Black, leftMargin, yPos, new StringFormat());
        yPos += (regularFont.GetHeight(ev.Graphics) * 2);


    }

    public float processFeeDisplay(string feeName, string feeAmount, string quantity, PrintPageEventArgs ev, float y, string type)
    {

        // Create rectangle for drawing.
        float x = 0.0F;

        // Construct 2 new StringFormat objects
        StringFormat format1 = new StringFormat(StringFormatFlags.NoClip);
        StringFormat format2 = new StringFormat(format1);

        // Set the LineAlignment and Alignment properties for
        // both StringFormat objects to different values.
        format1.LineAlignment = StringAlignment.Center;
        format1.Alignment = StringAlignment.Near;
        format2.LineAlignment = StringAlignment.Center;
        format2.Alignment = StringAlignment.Far;

        if (type == "orderItem")
        {
            RectangleF leftRect = new RectangleF(new PointF(x, y), new SizeF(maxFeeNameSize, regularFont.GetHeight(ev.Graphics)));
            RectangleF middleRect = new RectangleF(new PointF(x + maxFeeNameSize, y), new SizeF(maxQtySize, regularFont.GetHeight(ev.Graphics)));
            RectangleF rightRect = new RectangleF(new PointF(x + maxFeeNameSize + maxQtySize, y), new SizeF(maxFeeAmountSize, regularFont.GetHeight(ev.Graphics)));

            ev.Graphics.DrawString(feeName, regularFont, Brushes.Black, leftRect, format1);
            ev.Graphics.DrawString(quantity.ToString(), regularFont, Brushes.Black, middleRect, format2);
            ev.Graphics.DrawString(feeAmount, regularFont, Brushes.Black, rightRect, format2);
        }
        if (type == "orderTotal")
        {
            RectangleF leftRect = new RectangleF(new PointF(x, y), new SizeF(maxFeeNameSize, boldFont.GetHeight(ev.Graphics)));
            RectangleF middleRect = new RectangleF(new PointF(x + maxFeeNameSize, y), new SizeF(maxQtySize, boldFont.GetHeight(ev.Graphics)));
            RectangleF rightRect = new RectangleF(new PointF(x + maxFeeNameSize + maxQtySize, y), new SizeF(maxFeeAmountSize, boldFont.GetHeight(ev.Graphics)));

            ev.Graphics.DrawString(feeName, boldFont, Brushes.Black, leftRect, format1);
            ev.Graphics.DrawString(quantity.ToString(), boldFont, Brushes.Black, middleRect, format2);
            ev.Graphics.DrawString(feeAmount, boldFont, Brushes.Black, rightRect, format2);
        }

        y += height;
        return y;
    }
}