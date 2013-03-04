package chb.client;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;


import chb.base.*;

public class Register extends AServlet {
    /**
     * Receive the parameters sent by POST method and store them to MySQL.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        /*
        * This step is important without which the chinese characters will be
        * in mess.
        * Because the register.jsp page has set the encoding to UTF-8, so
        * the characters sent by that page will be encoded in the specified encoding.
        */
        req.setCharacterEncoding("utf8");
        Map<String, String[]> map = req.getParameterMap();

        /**
         * The configuration file tells the mapping from parameters to
         * the fields in database and their corresponding types.
         * And it also specifies the database connection information.
         */
        String cpath = this.getInitParameterPath("path.datasource.config");
        if(cpath == null) {
            String lp = getInitParameterPath("path.login.error.log");
            LoggingProxy logger = new LoggingProxy(lp);
            logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())+"]"
                    +"Register error.\tCan't get init-param \'path.datasource.config\'.");

            req.setAttribute("info", "配置文件访问错误，请联系管理员。");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);
        }

        RegisterProxy dbproxy = new RegisterProxy(cpath, map);

        /**
         * The data log will be used the preserve the incoming data while
         * the data is being written to database.
         * We can use the log the recover data after system failure.
         */
        String dpath = this.getInitParameterPath("path.register.data.log");
        dbproxy.setDataLogPath(dpath);
        String epath = this.getInitParameterPath("path.register.error.log");
        dbproxy.setErrorLogPath(epath);

        /**
         * Error log file keeps information about the system error, used to
         * diagnose the system.
         */
        String lpath = this.getInitParameterPath("path.register.error.log");
        LoggingProxy logproxy = new LoggingProxy(lpath);
        if (dbproxy.storeToDb() == false) {
            logproxy.log(LoggingProxy.ERROR,
                    "[" + getHash(req.getParameterMap()) + "]" + "Register error. Can't write to database.");

            req.setAttribute("info", "数据库访问错误，请联系管理员。");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);

            /**
             * It should not return because it still has a chance to write data to log file.
             */
        }

        if (dbproxy.storeToLog() == false) {
            logproxy.log(LoggingProxy.ERROR,
                    "[" + getHash(req.getParameterMap()) + "]" + "Can't write to log.");

            /**
             * Because logging data is trivial, it fails but the servlet continues.
             */
        }

        /**
         * After user has registered, he or she can choose to upload something.
         */
        RequestDispatcher dispatcher = req.getRequestDispatcher("/upload.jsp");
        dispatcher.forward(req, resp);
    }


}
