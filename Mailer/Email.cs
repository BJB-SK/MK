using System;
using System.Net;
using System.Net.Mail;
using Mailer.Properties;

public class Email
{
    public int Id;
    public string Subject;
    public string Address;
    public string Body;
    public string Result;
    public bool Success;

    public Email(int id, string address, string subject, string body)
    {
        Id = id;
        Address = address;
        Subject = subject;
        Body = body;
    }

    public void Send()
    {
        Result = "";
        Success = true;
        try
        {
            // send email
            var senderAddress = new MailAddress(
                (string)Settings.Default["SenderAddress"],
                (string)Settings.Default["SenderName"]);
            var toAddress = new MailAddress(Address);
            var smtp = new SmtpClient
            {
                Host = (string)Settings.Default["SmtpServer"],
                Port = (int)Settings.Default["SmtpPort"],
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(senderAddress.Address, (string)Settings.Default["Password"]),
                Timeout = 5000
            };
            smtp.ServicePoint.MaxIdleTime = 2;
            smtp.ServicePoint.ConnectionLimit = 1;
            using (var mail = new MailMessage(senderAddress, toAddress))
            {
                mail.Subject = Subject;
                mail.Body = Body;
                mail.IsBodyHtml = true;
                smtp.Send(mail);
            }
        }
        catch(Exception ex)
        {
            Result = ex.Message + " " + ex.InnerException;
            Success = false;
        }
    }
}