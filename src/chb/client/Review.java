package chb.client;

import chb.base.LoggingProxy;
import chb.base.ReviewProxy;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**
 * Processing request for reviewing user information after
 * user has logged in successfully.
 */
public class Review extends AServlet{

    String identityNo = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.identityNo = req.getParameter("identityNo");

        /**
         * Get configuration in web.xml for servlet.
         */
        String cpath = getInitParameterPath("path.datasource.config");
        ReviewProxy proxy = new ReviewProxy(cpath);
        String epath = getInitParameterPath("path.review.error.log");
        proxy.setErrorLogPath(epath);
        /**
         * Query information returned in the form of string-to-string map.
         */
        Map<String, String> m =proxy.queryInfo(this.identityNo);

        /**
         * If it returns null, report error.
         */
        if(m == null) {
            LoggingProxy logger = new LoggingProxy(epath);
            logger.log(LoggingProxy.ERROR, "[" + this.identityNo +"]Review error. "
                    + "Database query error, return null.");

            req.setAttribute("info", "数据库查询错误，或许用户不存在，请联系管理员。");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);
            /* Must return in case it forward twice, whose second trial will fail. */
            return;
        }

        /**
         * Forward request to register_frozen.jsp.
         */
        req.setAttribute("userInfo", m);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/register.jsp");
        dispatcher.forward(req, resp);
    }
}
