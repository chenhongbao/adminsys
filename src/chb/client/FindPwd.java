package chb.client;


import chb.base.LoggingProxy;
import chb.base.MailProxy;
import chb.base.ReviewProxy;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

public class FindPwd extends AServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String identityNo = null;
        identityNo = req.getParameter("identityNo");
        /**
         * Get configuration in web.xml for servlet.
         */
        String cpath = getInitParameterPath("path.datasource.config");
        ReviewProxy proxy = new ReviewProxy(cpath);
        String epath = getInitParameterPath("path.findpwd.error.log");
        proxy.setErrorLogPath(epath);
        /**
         * Query information returned in the form of string-to-string map.
         */
        Map<String, String> m =proxy.queryInfo(identityNo);

        String pwd = m.get("pwd");
        String tomail = m.get("email");
        String toname = m.get("name");
        if(m.size() == 0 || pwd == null || tomail ==  null || toname == null) {
            LoggingProxy logger = new LoggingProxy(epath);
            logger.log(LoggingProxy.ERROR, "[---]EmailProxy warning. Account does not exist. (\'"
                    + identityNo +"\').");
            /**
             * Never show any information about the existence of users' accounts.
             * So if the user does not exist, still give the positive feedback.
             */
            RequestDispatcher dispatcher = req.getRequestDispatcher("/register_success.jsp");
            dispatcher.forward(req, resp);

            return;
        }

        String message = "Dear applicant, your password in admission system for XJTU soft engineering school is :"
                + pwd +"\n\r";
        message += toname +"，你好。你在西安交通大学软件学院招生系统的登陆密码是："+ pwd + "。";

        cpath = getInitParameterPath("path.email.config");
        MailProxy mailproxy = new MailProxy(cpath);
        mailproxy.setErrorLogPath(epath);

        if(mailproxy.setUp(tomail, toname, message) == false) {
            LoggingProxy logger = new LoggingProxy(epath);
            logger.log(LoggingProxy.ERROR, "[---]EmailProxy error. Can't build message for \'"
                    + toname +"\'.");
        }

        if(mailproxy.sendEmail() == false) {
            LoggingProxy logger2 = new LoggingProxy(epath);
            logger2.log(LoggingProxy.ERROR, "[---]EmailProxy error. Can't send messsage to \'"
                    + toname + "\'.");
        }

        /**
         * After user has uploaded files, he or she finishes all things.
         */
        RequestDispatcher dispatcher = req.getRequestDispatcher("/register_success.jsp");
        dispatcher.forward(req, resp);

        return;

    }
}
