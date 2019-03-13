using Mailer.Properties;
using System;
using System.Net;
using System.Net.Mail;
using System.Threading;

namespace Mailer
{
    class Program
    {
        public static void Send(Email email)
        {
            email.Result = "";
            email.Success = true;
            try
            {
                // send email
                var senderAddress = new MailAddress(
                    (string)Settings.Default["SenderAddress"],
                    (string)Settings.Default["SenderName"]);
                var toAddress = new MailAddress(email.Address);
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
                    mail.Subject = email.Subject;
                    mail.Body = email.Body;
                    mail.IsBodyHtml = true;
                    smtp.Send(mail);
                }
            }
            catch (Exception ex)
            {
                email.Result = ex.Message + " " + ex.InnerException;
                email.Success = false;
            }
        }

        static void Main(string[] args)
        {
            Console.WriteLine("Press space to stop...");
            do
            {
                while (!Console.KeyAvailable)
                {
                    try
                    {
                        var emails = Database.GetEmails();
                        if(emails.Count > 0)
                        {
                            foreach (var email in emails)
                            {
                                Console.WriteLine("Sending email to {0}...", email.Address);
                                Send(email);
                                if (!email.Success)
                                {
                                    Console.WriteLine(email.Result);
                                }
                                Thread.Sleep(100);
                            }
                            Database.UpdateEmails(emails);
                        }
                    }
                    catch(Exception ex)
                    {
                        Console.WriteLine(ex.Message + " " + ex.InnerException);
                    }
                    Thread.Sleep(1000);
                }
            } 
            while (Console.ReadKey(true).Key != ConsoleKey.Spacebar);
        }
    }
}
