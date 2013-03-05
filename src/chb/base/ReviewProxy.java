package chb.base;


import chb.client.AServlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Database accessing proxy for reviewing information.
 */
public class ReviewProxy extends DataProxy{
    /**
     * Identity card number.
     */
    protected String identityNo = "";

    public ReviewProxy() { }

    public ReviewProxy(String cpath) {
        super(cpath);
    }

    /**
     * Build query string according to the requirements.
     * @return query string
     */
    protected String buildQueryString() {
        String query = "SELECT ";

        Iterator<String> it = register_info_fields.iterator();
        while(it.hasNext()) {
            query += it.next() + " ";
            if(it.hasNext()) {
                query += " , ";
            }
        }

        query += "FROM register_info WHERE identityNo = ";
        query += "\'" + identityNo + "\';";

        return query;
    }

    /**
     * Query information which has the identityNo as given.
     * @param idNo  Identity card number.
     * @return  Map containing the filed names and their values. The
     * result set can have only one row.
     */
    public Map<String, String> queryInfo(String idNo) {
        if(idNo == null || idNo.length() < 1) {
            return null;
        }

        this.identityNo = idNo;
        Map<String, String> result = new HashMap<String, String>();

        String query = buildQueryString();
        String url = buildConnectionString();
        String class_name = "com.mysql.jdbc.Driver";

        Connection conn = getConnection(url, class_name);
        try {
            Statement stat = conn.createStatement();
            ResultSet set = stat.executeQuery(query);

            while(set.next()) {
                Iterator<String> it = register_info_fields.iterator();
                while (it.hasNext()) {
                    String field = it.next();
                    String value = set.getString(field);
                    /**
                     * createTime and updateTime in the table register_info
                     * should be hidden from users.
                     */
                    if(field.endsWith("createTime") || field.endsWith("updateTime")) {
                        continue;
                    }
                    result.put(field, value);
                }
            }

            /**
             * If there are more than one rows in ResultSet, log it
             * as error because result is ambiguous.
             */
            set.last();
            if(set.getRow() != 1) {
                this.errorLogFile.log(LoggingProxy.ERROR, "["
                        + this.identityNo + "]ReviewProxy error. "
                        + "Multiple rows in ResultSet, ambiguous result. "
                        + "First row is covered.");

                return result;
            }

        }catch (SQLException e) {
            this.errorLogFile.log(LoggingProxy.ERROR, "["
                    + this.identityNo + "]ReviewProxy error. " + e.getMessage());

            return null;
        }

        return result;
    }

    public Map<String, String> queryAppInfo(String idNo) {
        if(idNo == null || idNo.length() < 1) {
            return null;
        }

        Map<String, String> resultM = new HashMap<String, String>();

        String query = "SELECT status, updateTime FROM application_info WHERE identityNo = \'" +idNo + "\'";
        String url = buildConnectionString();
        String class_name = "com.mysql.jdbc.Driver";

        Connection conn = getConnection(url, class_name);
        try {
            Statement stat = conn.createStatement();
            ResultSet set = stat.executeQuery(query);

            set.next();

            String val = set.getString("status");
            resultM.put("status", val);
            val = set.getString("updateTime");
            resultM.put("updateTime", val);

            /**
             * If there are more than one rows in ResultSet, log it
             * as error because result is ambiguous.
             */
            set.last();
            if(set.getRow() != 1) {
                this.errorLogFile.log(LoggingProxy.ERROR, "["
                        + this.identityNo + "]ReviewProxy error. "
                        + "Multiple rows in ResultSet, ambiguous result. "
                        + "First row is covered.");

                return resultM;
            }

        }catch (SQLException e) {
            this.errorLogFile.log(LoggingProxy.ERROR, "["
                    + this.identityNo + "]ReviewProxy error. " + e.getMessage());

            return null;
        }

        return resultM;
    }

}
