﻿using System;
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

public partial class Administration_printerSettings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack == true))
        {
            //On Page load, display the current Printer Settings
            txtPrinterPort.Text = ConfigurationManager.AppSettings["portName"];
            txtPortSetting.Text = ConfigurationManager.AppSettings["portSettings"];

            String pkInstalledPrinters;
            for (int i = 0; i < PrinterSettings.InstalledPrinters.Count; i++)
            {
                pkInstalledPrinters = PrinterSettings.InstalledPrinters[i];
                comboInstalledPrinters.Items.Add(pkInstalledPrinters);
            }
        }
    }

    protected void cmdSavePrinterSettings_Click(object sender, EventArgs e)
    {
        //Save the Printer Settings to Web Configuration file.
        ConfigurationManager.AppSettings["portName"] = txtPrinterPort.Text;
        ConfigurationManager.AppSettings["portSettings"] = txtPortSetting.Text;

        //Test the printer connectivity based on new printer settings.
        testPrinter();
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

}