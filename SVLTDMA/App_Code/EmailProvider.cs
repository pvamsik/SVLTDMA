using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.IO;

/// <summary>
/// Summary description for EmailProvider
/// </summary>
public class EmailProvider
{

    public String emailServer { get; set; }
    public int emailPort { get; set; }
    public bool emailSSLRequired { get; set; }
    public String emailUserId { get; set; }
    public String emailUserPwd { get; set; }


    public EmailProvider()
    {
        emailServer = ConfigurationManager.AppSettings["emailServer"];
        emailPort = Convert.ToInt32(ConfigurationManager.AppSettings["emailServerPort"]);
        emailSSLRequired = Convert.ToBoolean(ConfigurationManager.AppSettings["emailServerSSLEnabled"]);
        emailUserId = ConfigurationManager.AppSettings["emailUserId"];
        emailUserPwd = ConfigurationManager.AppSettings["emailUserPwd"];
    }

    public string sendEmail(string Subject, string Message, string emailReceiver, List<string> emailCopyReceivers)
    {
        string returnMessage = "";
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["emailSend"]))
        {
            MailMessage mailObj = new MailMessage(emailUserId, emailReceiver, Subject, Message);
            mailObj.IsBodyHtml = true;
            if (emailCopyReceivers.Count > 0)
            {
                foreach (var eR in emailCopyReceivers)
                {
                    mailObj.CC.Add(new MailAddress(eR));
                }
            }
            SmtpClient SMTPClient = new SmtpClient();
            SMTPClient.UseDefaultCredentials = false;
            SMTPClient.Credentials = new NetworkCredential(emailUserId, emailUserPwd);
            SMTPClient.Host = emailServer;
            SMTPClient.Port = emailPort;
            SMTPClient.EnableSsl = emailSSLRequired;
            SMTPClient.Timeout = 20000;
            try
            {
                SMTPClient.Send(mailObj);
                returnMessage = "Success";
            }
            catch (Exception ex)
            {
                returnMessage = ex.Message;
            }
        }
        else
        {
            returnMessage = "Mail not sent";
        }
        return returnMessage;
    }

    public string sendEmailReceipt(string Subject, string Message, string emailReceiver)
    {
        string returnMessage = "";
        MailMessage mailObj = new MailMessage(emailUserId, emailReceiver, Subject, Message);
        mailObj.IsBodyHtml = true;
        SmtpClient SMTPClient = new SmtpClient();
        SMTPClient.UseDefaultCredentials = false;
        SMTPClient.Credentials = new NetworkCredential(emailUserId, emailUserPwd);
        SMTPClient.Host = emailServer;
        SMTPClient.Port = emailPort;
        SMTPClient.EnableSsl = emailSSLRequired;
        SMTPClient.Timeout = 20000;
        try
        {
            SMTPClient.Send(mailObj);
            returnMessage = "Email Sent Successfully!";
        }
        catch (Exception ex)
        {
            returnMessage = ex.Message;
        }

        return returnMessage;
    }

    public string sendEmailReceipt(string Subject, string Message, string emailReceiver, List<string> emailCopyReceivers)
    {
        string returnMessage = "";
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["emailSend"]))
        {
            MailMessage mailObj = new MailMessage(emailUserId, emailReceiver, Subject, Message);
            mailObj.IsBodyHtml = true;
            if (emailCopyReceivers.Count > 0)
            {
                foreach (var eR in emailCopyReceivers)
                {
                    mailObj.CC.Add(new MailAddress(eR));
                }
            }
            SmtpClient SMTPClient = new SmtpClient();
            SMTPClient.UseDefaultCredentials = false;
            SMTPClient.Credentials = new NetworkCredential(emailUserId, emailUserPwd);
            SMTPClient.Host = emailServer;
            SMTPClient.Port = emailPort;
            SMTPClient.EnableSsl = emailSSLRequired;
            SMTPClient.Timeout = 20000;
            try
            {
                SMTPClient.Send(mailObj);
                returnMessage = "Success";
            }
            catch (Exception ex)
            {
                returnMessage = ex.Message;
            }
        }
        else
        {
            returnMessage = "Mail not sent";
        }
        return returnMessage;
    }
}