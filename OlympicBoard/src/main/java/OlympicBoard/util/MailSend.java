package OlympicBoard.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend {

	public static void id(String email, String id) {
        String user = "testmaillth@gmail.com";
        String password = "rnrmfxptmxm1!";

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com"); 
        prop.put("mail.smtp.port", 465); 
        prop.put("mail.smtp.auth", "true"); 
        prop.put("mail.smtp.ssl.enable", "true"); 
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
           
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
           
            message.setSubject("[2022 Beijing] 요청하신 회원 아이디입니다.");

            message.setText("회원님의 아이디는 "+id+" 입니다.");
            
            Transport.send(message);
                   
                        
        } catch (AddressException e) {            
            e.printStackTrace();
        } catch (MessagingException e) {            
            e.printStackTrace();
        }
    }
}
