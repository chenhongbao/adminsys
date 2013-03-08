package chb.admin;

import chb.base.CsvProxy;
import chb.base.LoggingProxy;
import chb.base.ReviewProxy;
import chb.client.AServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class Csv extends AServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        /**
         * Get configuration in web.xml for servlet.
         */
        String cpath = getInitParameterPath("path.datasource.config");
        String epath = getInitParameterPath("path.csv.error.log");
        String tpath = getInitParameterPath("directory.csv.tmp");
        String csvpath = getInitParameterPath("path.csv.config");

        CsvProxy proxy = new CsvProxy(cpath);
        proxy.setErrorLogPath(epath);
        proxy.setCsvTmpDirectoty(tpath);
        proxy.setCsvConfig(csvpath);

        try {
            File file = proxy.getCsvData();
            String filename = LoggingProxy.getTimeStamp().
                    replace(' ', '_').replace(':', '-') + ".csv";

            InputStream fis = new BufferedInputStream(new FileInputStream(file));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();

            resp.reset();
            resp.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("UTF-8"),"ISO-8859-1"));
            resp.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(resp.getOutputStream());
            resp.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();

        } catch (IOException ex) {
            LoggingProxy logger2 = new LoggingProxy(epath);
            logger2.log(LoggingProxy.ERROR, "[---]Csv error." + ex.getMessage());
        }
    }
}
