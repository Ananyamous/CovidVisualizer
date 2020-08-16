import 'dart:io';
import "package:mailer2/mailer.dart";

class SendEmail {

  static void sendEmail({String toEmail, String bccEmail,
    String subject, String body, String atchPath}) {
    // If you want to use an arbitrary SMTP server, go with `new SmtpOptions()`.
    // This class below is just for convenience. There are more similar classes available.
    var options = new GmailSmtpOptions()
      ..username = 'knights.ecyber@gmail.com'
      ..password = 'Test1234!'; // Note: if you have Google's "app specific passwords" enabled,
    // you need to use one of those here.

    // How you use and store passwords is up to you. Beware of storing passwords in plain.
    var options2 = new SmtpOptions()
      ..username = 'AKIAU7GTJHEX4C2EOO6I'
      ..password = 'BExodEoWMFEn0sthqWwxXM2dj/soqHQErpZQIdBhhTak'
      ..name = 'email-smtp.us-east-1.amazonaws.com'
      ..port = 465
    ;

    // Create our email transport.
    var emailTransport = new SmtpTransport(options);

    // Create our mail/envelope.
    /*
    var envelope = new Envelope()
      ..from = 'knights.ecyber@gmail.com'
      ..recipients.add('gottum_m@hotmail.com')
      ..bccRecipients.add('murali.online@hotmail.com')
      ..subject = 'Testing the Dart Mailer library'
      ..attachments.add(new Attachment(file: new File('path/to/file')))
      ..text = 'This is a cool email message. Whats up?'
      ..html = '<h1>Test</h1><p>Hey!</p>';
    */
    var envelope = new Envelope();
    envelope.from = 'knights.ecyber@gmail.com';
    if(toEmail!=null && toEmail.trim().isNotEmpty) {
      envelope.recipients.add(toEmail);
    }
    if(bccEmail!=null && bccEmail.trim().isNotEmpty) {
      envelope.bccRecipients.add(bccEmail);
      envelope.bccRecipients.add('advaithgo@gmail.com');
      envelope.bccRecipients.add('gotoananya@gmail.com');
      envelope.bccRecipients.add('vaish.mahi2005@gmail.com');
      envelope.bccRecipients.add('abhinav.bollu@gmail.com');
      envelope.bccRecipients.add('y_sunitha@hotmail.com');
    }
    if(subject!=null && subject.trim().isNotEmpty) {
      envelope.subject = subject;
    }
    if(body!=null && body.trim().isNotEmpty) {
      envelope.html = body;
    }
    if(atchPath!=null && atchPath.trim().isNotEmpty) {
      envelope.attachments.add(new Attachment(file: new File(atchPath)));
    }

    // Email it.
    emailTransport.send(envelope)
        .then((envelope) => print('Email sent!'))
        .catchError((e) => print('Error occurred: $e'));
  }

}

