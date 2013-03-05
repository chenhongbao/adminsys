package chb.client;

import chb.base.LoggingProxy;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.File;
import java.io.IOException;
import java.sql.*;

public class Login extends AServlet{

    protected File configFile = null;
    protected HttpServletRequest reqst = null;
    protected HttpServletResponse respos = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        this.reqst = req;
        this.respos =resp;
        String oper = req.getParameter("operation");

        if(oper.equals("login")) {
            /**
             * If login succeeds, jump to the review.se, otherwise goes back to login.html.
             */
           if(checkUserLogin(req.getParameter("identityNo"), req.getParameter("pwd"))) {
               RequestDispatcher dispatcher = req.getRequestDispatcher("/review.se");
               dispatcher.forward(req, resp);
           }else {
               RequestDispatcher dispatcher = req.getRequestDispatcher("/index.html");
               dispatcher.forward(req, resp);
           }
        } else if (oper.equals("register")) {
            /**
             * If the user clicks the register button, goes to register page.
             * <strong>NOTE:</strong>
             * Give top = 1, will show the top banner, other value will hid the banner.
             */
            RequestDispatcher dispatcher = req.getRequestDispatcher("/register.jsp?top=1");
            dispatcher.forward(req, resp);
        } else {
            /**
             * Bad incoming parameter.
             */
            String lp = getInitParameterPath("path.login.error.log");
            LoggingProxy logger = new LoggingProxy(lp);
            logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())+"]Login abused, wrong field name.");

            req.setAttribute("info", "登陆参数错误，请联系管理员。");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);
        }
    }

    /**
     * Check whether the user has registered.
     * @param idNo the identity number of the user.
     * @param pwd the password of the user
     * @return  true if user exists.
     */
    protected boolean checkUserLogin(String idNo, String pwd) {
        String p = getInitParameterPath("path.datasource.config");
        /* in order to build the connection string, we need configuration file. */
        this.configFile = new File(p);
        if(this.configFile.exists() == false || this.configFile.canRead() == false) {
            return false;
        }

        String url = buildConnectionString();
        Connection conn = getConnection(url, "com.mysql.jdbc.Driver");
        if(conn == null) {
            String lp = getInitParameterPath("path.login.error.log");
            LoggingProxy logger = new LoggingProxy(lp);
            logger.log(LoggingProxy.ERROR, "["+getHash(reqst.getParameterMap())+"]Login error. Database connection error, return null.");

            return false;
        }
        try {
            Statement stat = conn.createStatement();
            String query = "select 1 from register_info where pwd = \'" + pwd + "\' and identityNo = \'" + idNo +"\';";
            ResultSet set = stat.executeQuery(query);

            return set.next();
        } catch (SQLException e) {

            String lp = getInitParameterPath("path.login.error.log");
            LoggingProxy logger = new LoggingProxy(lp);
            logger.log(LoggingProxy.ERROR, "["+getHash(reqst.getParameterMap())+"]Login error." + e.getMessage());

            return false;
        }
    }

    /**
     * Build connection string from XML configuration file.
     *
     * @return connection string
     */
    protected String buildConnectionString() {
        String conn = "";

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
            return null;
        }

        conn += getSingleValueFromXML(xpath, "//datasource/header/@value", doc);
        conn += "//" + getSingleValueFromXML(xpath, "//datasource/address/@value", doc);
        conn += ":" + getSingleValueFromXML(xpath, "//datasource/port/@value", doc);
        conn += "/" + getSingleValueFromXML(xpath, "//datasource/database/@value", doc);
        conn += "?" + getPairValueFromXML(xpath, "//datasource/param", doc);

        return conn;
    }

    /**
     * Draw the value from XML by XPath.
     *
     * @param xpath instance of XPath
     * @param path  XPath expression
     * @param doc   Document instance
     * @return string value
     */
    protected String getSingleValueFromXML(XPath xpath, String path, Document doc) {
        if (doc == null || xpath == null || path == null) {
            return "";
        }
        try {
            XPathExpression expr = xpath.compile(path);
            Object res = expr.evaluate(doc, XPathConstants.NODESET);
            NodeList nodes = (NodeList) res;
            if (nodes.getLength() < 1) {
                return null;
            }
            Node n = nodes.item(0);
            String v = n.getNodeValue();

            return v;
        } catch (Exception e) {
            return "";
        }
    }

    /**
     * Get key-value pairs in the form 'name1=value1&name2=value2'.
     *
     * @param xpath instance of XPath
     * @param path  XPath expression
     * @param doc   Document instance
     * @return string value
     */
    protected String getPairValueFromXML(XPath xpath, String path, Document doc) {
        if (doc == null || xpath == null || path == null) {
            return "";
        }
        try {
            XPathExpression expr = xpath.compile(path);
            Object res = expr.evaluate(doc, XPathConstants.NODESET);
            NodeList nodes = (NodeList) res;
            if (nodes.getLength() < 1) {
                return null;
            }
            String v = "";
            for (int i = 0; i < nodes.getLength(); ++i) {
                Node n = nodes.item(i);
                NamedNodeMap nnm = n.getAttributes();

                Node n1 = nnm.getNamedItem("name");
                Node n2 = nnm.getNamedItem("value");

                if(n1 == null || n2 == null) {
                    continue;
                }
                v +=  n1.getNodeValue();
                v += "=" + n2.getNodeValue();

                if (i != nodes.getLength() - 1) {
                    v += "&";
                }
            }

            return v;
        } catch (Exception e) {
            return "";
        }
    }


    /**
     * Create JDBC connection.
     * @param url       connection url
     * @param classname Class name used in Class.forName().
     * @return connection instance
     */
    public Connection getConnection(String url, String classname) {
        try {
            Class.forName(classname);
            Connection con = DriverManager.getConnection(url);

            return con;
        } catch (ClassNotFoundException e) {
            String lp = getInitParameterPath("path.login.error.log");
            LoggingProxy logger = new LoggingProxy(lp);
            logger.log(LoggingProxy.ERROR, "["+getHash(reqst.getParameterMap())+"]" +"Login error.\t"+ e.getMessage());

            return null;
        } catch (SQLException e) {
            String lp = getInitParameterPath("path.login.error.log");
            LoggingProxy logger = new LoggingProxy(lp);
            logger.log(LoggingProxy.ERROR, "["+getHash(reqst.getParameterMap())+"]"+"Login error.\t"+e.getMessage());

            return null;
        }
    }
}
