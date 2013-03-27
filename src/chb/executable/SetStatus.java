package chb.executable;


import java.io.*;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class SetStatus {

    public static void main(String[] args) {

        if (args.length < 2) {
            System.out.print("请指明文件路径，格式为\'准考证号,姓名\'，独占一行。\n");
            System.out.print("java setstatus <path-to-file> <status>\n");
            return;
        }

        String url = "jdbc:mysql://" + "localhost:" + "3306/" + "adminsys?" + "user=xjtuse&"
                + "password=xjtuse&" + "useUnicode=true&" + "characterEncoding=utf-8";
        String class_name = "com.mysql.jdbc.Driver";

        SetStatus s = new SetStatus();

        Map<String, String> list = s.getNameNoList(args[0]);

        int fail_cnt = 0;
        int succ_cnt = 0;
        String fail_str = "";

        try {
            Class.forName(class_name);
            Connection con = DriverManager.getConnection(url);
            CallableStatement stat = con.prepareCall("CALL set_status(?,?,?,?)");

            for (Map.Entry<String, String> e : list.entrySet()) {

                stat.setString(1, e.getKey());
                stat.setString(2, e.getValue());
                stat.setString(3, args[1]);
                stat.registerOutParameter(4, Types.INTEGER);
                System.out.println(e.getKey() +"," + e.getValue() +"," +args[1] + ",@res");

                try {
                stat.execute();
                } catch (SQLException ex) {
                    fail_cnt += 1;
                    fail_str += e.getKey() + "," + e.getValue() + "\n";
                    stat.clearParameters();

                    ex.printStackTrace();

                    continue;
                }


                int res = stat.getInt(4);
                System.out.println(res);

                if (res == 0) {
                    fail_cnt += 1;
                    fail_str += e.getKey() + "," + e.getValue() + "\n";
                } else {
                    succ_cnt += 1;
                }

                stat.clearParameters();
            }

            if (con.isClosed() == false) {
                con.close();
            }
            if (stat.isClosed() == false) {
                stat.close();
            }

            System.out.print("Set " + succ_cnt + " lines successfully, " + fail_cnt + " failed.\n");
            System.out.print("The failed lines are:\n" + fail_str);
            return;

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }


    }


    protected Map<String, String> getNameNoList(String path) {
        if (path == null || path.length() < 1) {
            System.out.println("The path to the name-number list file cannot be null.");
            return null;
        }

        Map<String, String> list = new LinkedHashMap<String, String>();


        File f = new File(path);
        if (f.exists() == false) {
            System.out.println("The list file does not exists.");
            return null;
        }

        int fail_cnt = 0;
        int succ_cnt = 0;
        try {
            FileInputStream fis = new FileInputStream(f);
            InputStreamReader isr = new InputStreamReader(fis, "UTF-8");

            BufferedReader br = new BufferedReader(isr);
            String line = null;

            while ((line = br.readLine()) != null) {
                if (processLine(line, list) == false) {
                    fail_cnt += 1;
                    continue;
                } else {
                    succ_cnt += 1;
                }
            }

            System.out.print("Get " + succ_cnt + " lines successfully, and " + fail_cnt + " lines failed.\n");

            br.close();

            return list;

        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return null;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private boolean processLine(String line, Map<String, String> list) {

        if (list == null) {
            return false;
        }

        String[] segs = line.split("[,;.:|\\s]");
        int cnt = 0;
        int idx = 0;

        String k = null, v = null;
        while (cnt < 2) {
            if (idx > segs.length - 1) {
                break;
            }
            String t = segs[idx].trim();
            if (t.length() < 1) {
                idx += 1;
                continue;
            }

            if (cnt == 0)
                k = segs[idx];
            else
                v = segs[idx];

            cnt += 1;
            idx += 1;
        }

        if (cnt < 2) {
            System.out.println("line \'" + line + "\' cannot be processed.");
            return false;
        }

        list.put(k, v);

        return true;
    }
}
