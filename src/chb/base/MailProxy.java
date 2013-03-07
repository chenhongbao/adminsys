package chb.base;

import java.util.Date;

import chb.client.AServlet;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.w3c.dom.Document;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathFactory;

public class MailProxy extends DataProxy{

    private String hostname = "";
    private String toemail = "";
    private String toname = "";
    private String fromemail = "";
    private String fromname = "";
    private String user = "";
    private String password = "";
    private String subject = "";
    private String message = "";

    public MailProxy(String cpath) {
        super(cpath);
    }


    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setFromname(String fromname) {
        this.fromname = fromname;
    }

    public void setFromemail(String fromemail) {
        this.fromemail = fromemail;
    }

    public void setHostname(String hostname) {
        this.hostname = hostname;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean setUp(String toemail, String toname, String message) {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder = null;
        Document doc = null;
        XPath xpath = null;
        try {
            builder = factory.newDocumentBuilder();
            doc = builder.parse(this.configFile);
            xpath = XPathFactory.newInstance().newXPath();
        } catch (Exception e) {
            LoggingProxy logger = new LoggingProxy(this.errorLogPath);
            logger.log(LoggingProxy.ERROR, "[---]EmailProxy error. " + e.getMessage());

            return false;
        }

        this.hostname = getSingleValueFromXML(xpath, "//email/hostname/@value", doc);
        this.fromemail = getSingleValueFromXML(xpath, "//email/fromemail/@value", doc);
        this.fromname = getSingleValueFromXML(xpath, "//email/fromname/@value", doc);
        this.user = getSingleValueFromXML(xpath, "//email/user/@value", doc);
        this.password = getSingleValueFromXML(xpath, "//email/password/@value", doc);
        this.subject = getSingleValueFromXML(xpath, "//email/subject/@value", doc);
        this.toemail = toemail;
        this.toname = toname;
        this.message = message;

        return true;

    }

    public boolean sendEmail() {
        try {
        SimpleEmail email = new SimpleEmail();
        email.setHostName(this.hostname);
        email.addTo(this.toemail,this.toname);
        email.setFrom(this.fromemail, this.fromname);
        email.setAuthentication(this.user, this.password);
        email.setSubject(this.subject);
        email.setMsg(this.message);
        email.setCharset("UTF-8");
        email.send();
        } catch (EmailException e) {
            LoggingProxy logger = new LoggingProxy(this.errorLogPath);
            logger.log(LoggingProxy.ERROR, "[---]EmailProxy error. " + e.getMessage());

            return false;
        }

        return true;
    }
}
