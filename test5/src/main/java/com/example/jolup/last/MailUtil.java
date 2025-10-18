package com.example.jolup.last;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

public class MailUtil {

    // 네이버 SMTP 설정
    private static final String SMTP_HOST = "smtp.naver.com";
    private static final int    SMTP_PORT = 587;                 // TLS
    private static final String SMTP_USER = "ohjunho8520@naver.com"; // 네이버 메일 주소
    private static final String SMTP_PASS = "junho8520*^^*";      // 네이버 로그인 비번

    public static void sendMail(String to, String subject, String htmlBody) throws MessagingException {
        Properties props = new Properties();

        // ▼ TLS(587) 사용하는 경우
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // ▼ SSL(465)일 경우 위 두 줄 대신 아래 한 줄 사용
        // props.put("mail.smtp.ssl.enable", "true");

        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", String.valueOf(SMTP_PORT));

        props.put("mail.smtp.ssl.trust", SMTP_HOST);
        props.put("mail.smtp.auth.mechanisms", "LOGIN PLAIN");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SMTP_USER));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);

        MimeBodyPart bodyPart = new MimeBodyPart();
        bodyPart.setContent(htmlBody, "text/html; charset=UTF-8");

        Multipart mp = new MimeMultipart();
        mp.addBodyPart(bodyPart);
        message.setContent(mp);

        Transport.send(message);
    }
}
