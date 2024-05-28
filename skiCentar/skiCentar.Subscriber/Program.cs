using EasyNetQ;
using SendGrid;
using SendGrid.Helpers.Mail;
using skiCentar.Model;

var bus = RabbitHutch.CreateBus("host=localhost");

await bus.PubSub.SubscribeAsync<Proizvod>("seminarski rad", async msg =>
{
    Console.WriteLine($"Received message: {msg.Naziv}");

    string recipientEmail = "dautbeg@outlook.com"; // Replace with the recipient's email from msg if available
    string token = Guid.NewGuid().ToString();
    string verificationLink = $"https://localhost:5000/verify?token={token}";

    await SendVerificationEmail(recipientEmail, verificationLink);
});

Console.WriteLine("Listening to messages, press <return> key to close!");
Console.ReadLine();

static async Task SendVerificationEmail(string recipientEmail, string verificationLink)
{
    string apiKey = "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";
    var client = new SendGridClient(apiKey);
    var from = new EmailAddress("david.dautbegovic@edu.fit.ba", "David");
    var subject = "Please verify your email address";
    var to = new EmailAddress(recipientEmail);
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
        Console.WriteLine("Failed to send email.");
        // Additional error handling could go here
    }
}

