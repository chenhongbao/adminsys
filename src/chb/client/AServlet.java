package chb.client;

import javax.servlet.http.HttpServlet;
import java.io.File;
import java.util.Collection;
import java.util.Map;


public class AServlet extends HttpServlet {
    /**
     * A helper function which get the complete path of a certain file in
     * the init-param in web.xml.<br/>
     * It will see whether the path is absolute. If it is, returns it directly. if
     * it is not, append the absolute path of the currently working directory to the front
     * of the returned path.
     * @param initParam name of the init-param.
     * @return a string representing the complete path of a file.
     */
    protected String getInitParameterPath(String initParam) {
        String path = getServletConfig().getInitParameter(initParam);
        if(path == null) {
            return null;
        }
        java.io.File f = new File(path);
        if(f.isAbsolute()) {
            f = null;
            return path;
        } else {
            f = null;
            return getServletContext().getRealPath("/") + getServletConfig().getInitParameter(initParam);
        }
    }

    /**
     * Compute the hash code for the current parameters' values.
     *
     * @return hash string of md5
     */
    public static String getHash(Map<String, String[]> paramMap) {
        String hash = "";
        char hexDigits[] = {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] bts = getBytesFromValues(paramMap);
            md.update(bts);
            byte tmp[] = md.digest();
            char str[] = new char[16 * 2];
            int k = 0;
            for (int i = 0; i < 16; i++) {

                byte byte0 = tmp[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            hash = new String(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return hash;
    }

    /**
     * Generate byte array from values in parameter map.
     *
     * @return byte array.
     */
    protected static byte[] getBytesFromValues(Map<String, String[]> paramMap) {
        if (paramMap == null) {
            return new byte[128];
        }

        String res = "";
        Collection<String[]> coll = paramMap.values();
        for (String[] ss : coll) {
            for (String s : ss) {
                res += s;
            }
        }

        return res.getBytes();
    }


}
