package chb.base;

import chb.client.AServlet;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;

/**
 * Super class for all the database accessing classes.
 * <br><br/>
 * Encapsulate common operations.
 */
public class DataProxy {

    /**
     * Configuration file.
     */
    protected String configPath = null;
    protected File configFile = null;

    /**
     * Data logging file.
     */
    protected String dataLogPath = null;
    protected LoggingProxy dataLogFile = null;

    protected String errorLogPath = null;
    protected LoggingProxy errorLogFile = null;

    /**
     * Request parameters map.
     */
    protected Map paramMap = null;

    /**
     * The hash code of the parameter map.
     */
    public String hash = null;

    /**
     * All the valid field names in table register_info_fields.
     */
    protected static Set<String> register_info_fields = new LinkedHashSet<String>() {
    };

    static {
        /**
         * Personal information.
         * id="personalInfoPanel"
         */
        register_info_fields.add("name");
        register_info_fields.add("sex");
        register_info_fields.add("birthday");
        register_info_fields.add("people");
        register_info_fields.add("identity");
        register_info_fields.add("political");
        register_info_fields.add("identityNo");
        register_info_fields.add("location");
        /**
         * Communication information.
         * id =register_info_fields.add("communicationInfoPanel"
         */
        register_info_fields.add("phone");
        register_info_fields.add("mobile");
        register_info_fields.add("email");
        register_info_fields.add("postalCode");
        register_info_fields.add("address");
        register_info_fields.add("unitName");
        register_info_fields.add("unitAddress");
        register_info_fields.add("unitPhone");
        register_info_fields.add("unitPostalCode");

        /**
         * Other information.
         * id="otherInfoPanel"
         */
        register_info_fields.add("pwd");
        register_info_fields.add("confirmPwd");
        register_info_fields.add("newOrOld");
        register_info_fields.add("allDay");
        register_info_fields.add("examType");
        register_info_fields.add("education");
        register_info_fields.add("comment");

        /**
         * First choice college.
         * id="firstChoiceCollegePanel"
         */
        register_info_fields.add("admitCardNo");
        register_info_fields.add("firstChoiceCollegeName");
        register_info_fields.add("firstChoiceCollegePostalCode");
        register_info_fields.add("firstChoiceCollegeAddress");
        register_info_fields.add("firstChoiceSpecialityTypeCode");

        // Newly added columns according to Qin Lianying's requirement.
        register_info_fields.add("masterType");
        register_info_fields.add("weipeiType");

        /**
         * First choice speciality information.
         * id="firstChoiceSpecialityPanel"
         */
        register_info_fields.add("firstChoiceSpecialityName");
        register_info_fields.add("firstChoiceSpecialityCode");
        register_info_fields.add("firstChoiceSpecialityTypeName");

        /**
         * Exam Result.
         * id="examResultPanel"
         */
        register_info_fields.add("politicalPoint");
        register_info_fields.add("zzcode");
        register_info_fields.add("englishPoint");
        register_info_fields.add("yycode");
        register_info_fields.add("specialityOneName");
        register_info_fields.add("specialityOnePoint");
        register_info_fields.add("zyycode");
        register_info_fields.add("specialityTwoName");
        register_info_fields.add("specialityTwoPoint");
        register_info_fields.add("zyecode");
        register_info_fields.add("totalPoint");

        /**
         * Bachelor information.
         * id="bachelorPanel"
         */
        register_info_fields.add("graduateSchoolName");
        register_info_fields.add("graduateSpecialityName");
        register_info_fields.add("graduateSpecialityType");
        register_info_fields.add("graduateTime");
        register_info_fields.add("bachelorType");
        register_info_fields.add("getBachelorTime");

        /**
         * Speciality information.
         * id="specialityPanel"
         */
        register_info_fields.add("adjustSpeciality");
        register_info_fields.add("adjustSpeciality2");
        register_info_fields.add("adjustSpeciality3");
        register_info_fields.add("allowChangeSpeciality");
        register_info_fields.add("ddllUnionTrainUnit");
        register_info_fields.add("ddllUnionTrainUnit2");
        register_info_fields.add("ddllUnionTrainUnit3");
    }


    public DataProxy() {}

    public DataProxy(String cpath) {
        this.setConfigPath(cpath);
    }

    public DataProxy(String cpath, Map map) {
        this.setConfigPath(cpath);
        this.setParamMap(map);
    }

    /**
     * Create JDBC connection.
     *
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
            return null;
        } catch (SQLException e) {
            return null;
        }
    }

    /**
     * Convert the values in map to a string.
     *
     * @param map Parameter map.
     * @return a string with values properly arranged.
     */
    public static String paramToString(Map map) {
        if (map == null) {
            return "[ERROR:PARAMETER MAP IS NULL]";
        }

        Set<String> set = map.keySet();
        List<String> lst = new ArrayList<String>();
        for (String s : set) {
            lst.add(s);
        }
        Collections.sort(lst, new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return o1.compareTo(o2);
            }
        });

        String res = "";
        for (int i = 0; i < lst.size(); ++i) {
            String k = lst.get(i);
            String[] values = (String[]) map.get(k);
            String res2 = "";
            res2 += k + ":";

            for (int j = 0; j < values.length; ++j) {
                if (j == values.length - 1) {
                    res2 += values[j];
                } else {
                    res2 += values[j] + ",";
                }
            }

            if (i == lst.size() - 1) {
                res += res2;
            } else {
                res += res2 + "|";
            }
        }

        return res;
    }


    public void setDataLogPath(String dataLogPath) {
        this.dataLogPath = dataLogPath;
        this.dataLogFile = new LoggingProxy(this.dataLogPath);
    }


    public void setErrorLogPath(String errorLogPath) {
        this.errorLogPath = errorLogPath;
        this.errorLogFile = new LoggingProxy(this.errorLogPath);
    }


    /**
     * Set the parameter map returned by req.getParameterMap().
     *
     * @param map Map<String, String[]> map.
     * @return True for success.
     */
    public boolean setParamMap(Map map) {
        if (map == null || map.size() < 1) {
            return false;
        }

        this.paramMap = map;
        return true;
    }


    /**
     * Set the path for configuration file.
     *
     * @param cpath Path.
     * @return True for success.
     */
    public boolean setConfigPath(String cpath) {
        if (cpath == null || cpath.length() < 1) {
            return false;
        }

        this.configFile = new File(cpath);
        if (this.configFile.exists() == false) {
            return false;
        }

        return true;
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
            LoggingProxy logger = new LoggingProxy(this.errorLogPath);
            logger.log(LoggingProxy.ERROR, "[" + AServlet.getHash(this.paramMap)
                    + "]Persistency error. " + e.getMessage());

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
                if (n1 == null || n2 == null) {
                    continue;
                }

                v += n1.getNodeValue() + "=" + n2.getNodeValue();

                if (i != nodes.getLength() - 1) {
                    v += "&";
                }
            }

            return v;
        } catch (Exception e) {
            return "";
        }
    }


}
