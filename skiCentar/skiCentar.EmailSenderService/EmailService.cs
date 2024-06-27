using SendGrid;
using SendGrid.Helpers.Mail;

public class EmailService
{
    private readonly string _apiKey = Environment.GetEnvironmentVariable("EMAIL_APIKEY") ?? "nejma";
    private readonly string _emailSender = Environment.GetEnvironmentVariable("EMAIL_SENDER") ?? "david.dautbegovic@edu.fit.ba";

    public async Task SendVerificationEmailAsync(string email, string verificationLink)
    {

        var client = new SendGridClient(_apiKey);
        var from = new EmailAddress(_emailSender, "SKI CENTAR BIH");
        var subject = "Please verify your email address";
        var to = new EmailAddress(email);
        var plainTextContent = $"Please verify your email by clicking on the following link: {verificationLink}";
        var htmlContent = $"<strong>Please verify your email by clicking on the following link:</strong> <a href='{verificationLink}'>Verify Email</a>";
        var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);

        var response = await client.SendEmailAsync(msg);

        if (response.StatusCode == System.Net.HttpStatusCode.Accepted)
        {
            Console.WriteLine("Email sent successfully!");
        }
        else
        {
            Console.WriteLine(response);
            Console.WriteLine("Failed to send email.");
        }
    }
}
