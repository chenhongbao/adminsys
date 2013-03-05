package chb.base;


import chb.client.AServlet;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.*;
import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

/**
 * Database accessing proxy for registering.
 */
public class RegisterProxy extends DataProxy {


    public RegisterProxy() {
    }

    /**
     * Constructor.
     *
     * @param cpath Path to the configuration file.
     * @param map   Parameter map returned by req.getParameterMap().
     */
    public RegisterProxy(String cpath, Map map) {
        this.setConfigPath(cpath);
        this.setParamMap(map);
    }


    /**
     * Save the parameter map to database according to the settings in
     * configuration file.
     *
     * @return True for success.
     */
    public boolean storeToDb() {
        String url = buildConnectionString();
        String class_name = "com.mysql.jdbc.Driver";

        Connection conn = getConnection(url, class_name);
        if (conn == null) {
            return false;
        }
        Statement stat = null;
        String query = buildQeuryString();

        try {
            stat = conn.createStatement();
            stat.execute(query);
            stat.close();
            conn.close();

            return true;
        } catch (SQLException e) {
            LoggingProxy logger = new LoggingProxy(this.errorLogPath);
            logger.log(LoggingProxy.ERROR, "["+AServlet.getHash(this.paramMap)
                    +"]RegisterProxy error. " + e.getMessage()+ " " + query);

            return false;
        } finally {
            if (stat != null) {
                try {
                    if (stat.isClosed() == false)
                        stat.close();
                } catch (SQLException e) {
                    return false;
                }
            }
            try {
                if (conn.isClosed() == false) {
                    conn.close();
                }
            } catch (SQLException e) {
                return false;
            }
        }
    }

    /**
     * Save the parameter map to database according to the settings in
     * configuration file.
     *
     * @param map Map returned by req.getParameterMap().
     * @return True for success.
     */
    public boolean storeToDb(Map map) {
        setParamMap(map);
        return storeToDb();
    }

    /**
     * Save the parameter map to database according to the settings in
     * configuration file.
     *
     * @param cpath Path to the configuration file.
     * @param map   Map returned by req.getParameterMap().
     * @return True for success.
     */
    public boolean storeToDb(String cpath, Map map) {
        setConfigPath(cpath);
        setParamMap(map);
        return storeToDb();
    }

    /**
     * Save parameters to log file.
     */
    public boolean storeToLog() {

        if (this.paramMap == null || this.paramMap.size() < 1
                || this.dataLogPath == null) {

            return false;
        }

        if (this.dataLogFile == null) {
            this.dataLogFile = new LoggingProxy(this.dataLogPath);
        }

        return this.dataLogFile.log(LoggingProxy.INFO,
                "[" + AServlet.getHash(this.paramMap) + "]" + paramToString(this.paramMap));
    }

    /**
     * Build query string from parameter map.
     *
     * @return query string
     */
    protected String buildQeuryString() {
        String query = "INSERT INTO register_info (";
        String args = "";
        String vals = "";
        String updates = "";

        Set<Map.Entry<String, String[]>> entries = this.paramMap.entrySet();
        Iterator<Map.Entry<String, String[]>> it = entries.iterator();
        while (it.hasNext()) {
            Map.Entry<String, String[]> item = it.next();
            /**
             * If the key is not in the fields of register_info_fields, it
             * will not be processed.
             */
            if(register_info_fields.contains(item.getKey()) == false) {
                continue;
            }
            args += item.getKey();
            updates += item.getKey() + " = ";

            String[] val = item.getValue();
            if (val.length == 0) {
                vals += "null";
                updates += "null";
            } else {
                vals += "\'" + val[0] + "\'";
                updates += "\'" + val[0] + "\'";
            }
            if (it.hasNext()) {
                vals += ",";
                args += ",";
                updates += ",";
            }
        }

        /**
         * If the invalid field name is at the last position,
         * it will append an extra comma ',' to the end of the query
         * string.
         * So we need to drop the comma.
         */
        args = args.trim();
        while (args.endsWith(",")) {
            args = args.substring(0, args.length()-1);
        }

        vals = vals.trim();
        while (vals.endsWith(",")) {
            vals = vals.substring(0, vals.length()-1);
        }

        updates = updates.trim();
        while (updates.endsWith(",")) {
            updates = updates.substring(0, updates.length()-1);
        }

        /**
         * Set the createTime and updateTime in the table register_info.
         */
        args += ",createTime";
        vals += ",\'" + LoggingProxy.getTimeStamp() +"\'";
        updates += ",updateTime=\'" + LoggingProxy.getTimeStamp()+"\'";

        /**
         * Add all the components together.
         */
        query += args + ")";
        query += " VALUES (";
        query += vals + ") ON DUPLICATE KEY UPDATE ";
        query += updates + ";";

        return query;
    }

    /**
     * Initialize table application_info.
     * @return query string
     */
    protected String buildQueryString2() {
        String id = (String)this.paramMap.get("identity");
        String idNo = (String)this.paramMap.get("identityNo");
        String status = "未审核";

        String query = "INSERT INTO application_info (identity, identityNo, status) ";
        query += "VALUES (\'" + id + "\',\'" + idNo + "\',\'" + status + "');";

        return query;
    }

}
