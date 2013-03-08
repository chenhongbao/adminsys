package chb.base;


import chb.bean.DataLead;
import chb.client.AServlet;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.*;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;

public class CsvProxy extends DataProxy {

    protected File csvConfigFile = null;
    protected File csvTmpDirectoty = null;

    public CsvProxy(String cpath) {
        super(cpath);
    }

    public boolean setCsvConfig(String path) {
        this.csvConfigFile = new File(path);
        return this.csvConfigFile.exists();
    }

    public void setCsvTmpDirectoty(String dir) {
        this.csvTmpDirectoty = new File(dir);
        if (this.csvTmpDirectoty.exists() == false
                || this.csvTmpDirectoty.isDirectory() == false) {
            this.csvTmpDirectoty.mkdirs();
        }
    }


    /**
     * Build SQL query for the database;
     *
     * @return SQL query
     */
    protected String buildQueryString() {
        String query = "SELECT ";

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder = null;
        Document doc = null;
        XPath xpath = null;
        try {
            builder = factory.newDocumentBuilder();
            doc = builder.parse(this.csvConfigFile);
            xpath = XPathFactory.newInstance().newXPath();
            XPathExpression expr = xpath.compile("//csv/column");

            NodeList nodes = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
            for (int j = 0; j < nodes.getLength(); ++j) {
                for (int i = 0; i < nodes.getLength(); ++i) {
                    NamedNodeMap m = nodes.item(i).getAttributes();
                    String s = m.getNamedItem("rank").getNodeValue();
                    if (Integer.valueOf(s) == j + 1) {
                        query += m.getNamedItem("name").getNodeValue();
                        if (j < nodes.getLength() - 1) {
                            query += ",";
                        }

                        break;
                    }
                }
            }

            query += " FROM register_info";
            return query;

        } catch (Exception e) {
            LoggingProxy logger = new LoggingProxy(this.errorLogPath);
            logger.log(LoggingProxy.ERROR, "[---]CsvProxy error. " + e.getMessage());

            return null;
        }

    }


    /**
     * Select all rows in database and return as a list.
     *
     * @return a list of DataLead instance, containing all rows in database.
     */
    protected List<DataLead> selectAll() {

        String query = buildQueryString();

        String url = buildConnectionString();
        String class_name = "com.mysql.jdbc.Driver";
        Connection conn = getConnection(url, class_name);

        if (conn == null) {
            errorLogFile.log(LoggingProxy.ERROR, "[---]Can't get database connection. " +
                    "Returns null.");
            return null;
        }

        ResultSet set = null;
        List<String> cols = new LinkedList<String>();
        List<DataLead> leads = new LinkedList<DataLead>();

        try {
            Statement stat = conn.createStatement();
            set = stat.executeQuery(query);

            ResultSetMetaData rsmd = set.getMetaData();
            int colcnt = rsmd.getColumnCount();
            for (int i = 1; i <= colcnt; ++i) {
                cols.add(rsmd.getColumnName(i));
            }

            while (set.next()) {
                DataLead lead = new DataLead();
                for (int i = 0; i < cols.size(); ++i) {
                    if(cols.get(i).equals("specialityOneName")
                            || cols.get(i).equals("specialityTwoName")) {

                        lead.add(set.getString(cols.get(i))+" "+set.getString(cols.get(i+1)));
                        i += 1;

                        System.out.print("******");

                    } else {
                        lead.add(set.getString(cols.get(i)));
                    }
                }

                leads.add(lead);
            }

            return leads;


        } catch (SQLException e) {
            this.errorLogFile.log(LoggingProxy.ERROR, "[---]CsvProxy error. "
                    + e.getMessage() + query);

            return null;
        }

    }

    /**
     * Create a temporary file with 'csv.tmp' as suffix.
     *
     * @return File instance.
     */
    protected File createCsvFile() {
        try {
            String p = this.csvTmpDirectoty.getAbsolutePath() + File.separator;
            p += LoggingProxy.getTimeStamp().replace(' ', '_').replace(':', '-') + ".csv";

            File f = new File(p);
            if(f.exists() == false) {
                f.createNewFile();
            }

            return f;
        } catch (IOException e) {
            this.errorLogFile.log(LoggingProxy.ERROR, "[---]CsvProxy error. "
                    + e.getMessage());
            return null;
        }
    }

    public File getCsvData() {

        List<DataLead> leads = selectAll();
        if(leads == null) {
            this.errorLogFile.log(LoggingProxy.ERROR, "[---]CsvProxy error. Can't get data. ");
            return null;
        }
        File tmp = createCsvFile();
        if(tmp == null) {
            this.errorLogFile.log(LoggingProxy.ERROR,
                    "[---]CsvProxy error. Can't create tmp file. ");
            return null;
        }
        try {
            /**
             * Create an output stream with UTF-8 encoding.
             */
            FileOutputStream fos = new FileOutputStream(tmp);
            OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");

            /**
             * Write file line by line.
             */
            for (DataLead l : leads) {
                for (int i = 0; i < l.size(); ++i) {
                    osw.write(l.get(i));
                    if (i < l.size() - 1) {
                        osw.write(",");
                    }
                }
                /**
                 * Windows line delimiter.
                 */
                osw.write("\r\n");
            }
            osw.flush();
            osw.close();

            return tmp;

        } catch (FileNotFoundException e) {
            this.errorLogFile.log(LoggingProxy.ERROR, "[---]CsvProxy error. File ont found. "
                    + e.getMessage());
            return null;

        } catch (UnsupportedEncodingException e) {
            this.errorLogFile.log(LoggingProxy.ERROR, "[---]CsvProxy error. Unsupported encoding."
                    + e.getMessage());
            return null;

        } catch (IOException e) {
            this.errorLogFile.log(LoggingProxy.ERROR, "[---]CsvProxy error. IO exception."
                    + e.getMessage());
            return null;

        }

    }


}
