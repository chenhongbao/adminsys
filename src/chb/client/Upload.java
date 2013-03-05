package chb.client;

import chb.base.LoggingProxy;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

public class Upload extends AServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if( ServletFileUpload.isMultipartContent(req) == false) {
            req.setAttribute("info","提交数据类型错误，请联系管理员。");

            RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);

            return;
        }

        /**
         * Configuration file for Upload.
         */
        String conf = getInitParameterPath("path.upload.config");
        File f = new File(conf);

        /**
         * Prepare the XPath instance.
         */
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder = null;
        Document doc = null;
        XPath xpath = null;
        try {
            builder = factory.newDocumentBuilder();
            doc = builder.parse(f);
            xpath = XPathFactory.newInstance().newXPath();
        } catch (Exception e) {
            String p = getInitParameterPath("path.upload.error.log");
            LoggingProxy logger  = new LoggingProxy(p);
            logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())+"]Upload file error."
                    + e.getMessage() +" (" + f.getAbsolutePath() + ")");

            req.setAttribute("info", "配置文件错误，请联系管理员。");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);
            /**
             * Must return because it will goes to end the commit twice.
             */
            return;
        }

        /**
         * Get maximum memory usage.
         */
        String p = "//upload/maxMemorySize/@value";
        String maxmem = getSingleValueFromXML(xpath, p, doc).trim();

        /**
         * Get the temporary directory.
         */
        p = "//upload/tempDiretory/@value";
        String tmpdir = getSingleValueFromXML(xpath, p, doc).trim();
        /**
         * If the path is absolute path, uses it. But if it is a relative path,
         * we should append the real path of web server to its front.
         */
        File tmpf = new File(tmpdir);
        if(tmpf.isAbsolute() == false) {
            tmpdir = getServletContext().getRealPath("/") + tmpdir;
            tmpf = new File(tmpdir);
        }

        /**
         * Create the directory if it does not exist.
         */
        if(tmpf.exists() == false) {
             tmpf.mkdirs();
        }

        /**
         * Get the maximum uploaded file size.
         */
        p = "//upload/maxFileSize/@value";
        String maxsz = getSingleValueFromXML(xpath, p, doc).trim();

        /**
         * Set constraints on the uploaded files.
         */
        DiskFileItemFactory  uploadfactory = new DiskFileItemFactory();
        uploadfactory.setSizeThreshold(Integer.valueOf(maxmem));
        uploadfactory.setRepository(tmpf);

        ServletFileUpload upload = new ServletFileUpload(uploadfactory);
        upload.setFileSizeMax(Integer.valueOf(maxsz));

        try {
            List<FileItem> items = upload.parseRequest(req);

            /**
             * Because the request is encoded as binary, we must use
             * the common-upload library to access the parameter.
             */
            String filename = null;
            for(FileItem i: items) {
                if(i.isFormField() && i.getFieldName().equals("identityNo")) {
                    filename = i.getString();
                }
            }

            /**
             * If the use does not enter from the register page, reject his
             * uploading.
             */
            if(filename.toLowerCase().equals("null")) {
                String p7 = getInitParameterPath("path.upload.error.log");
                LoggingProxy logger  = new LoggingProxy(p7);
                logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())
                        +"]Upload file error. Wrong identityNo.");

                req.setAttribute("info", "参数值错误，请重新上传。");
                RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
                dispatcher.forward(req, resp);

                /* Must return here because it will go to the end and commit twice.*/
                return;
            }

            /* Preserve the filename because function will change it. */
            String filename2 = filename;

            if(filename == null) {
                String p4 = getInitParameterPath("path.upload.error.log");
                LoggingProxy logger  = new LoggingProxy(p4);
                logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())
                        +"]Upload file error. Missing identityNo as parameter.");

                req.setAttribute("info", "缺少参数，请重新上传。");
                RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
                dispatcher.forward(req, resp);

                /* Must return here because it will go to the end and commit twice.*/
                return;
            }

            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                /**
                 * Iterate over the uploaded parameters.
                 */
                FileItem item = (FileItem) iter.next();
                /**
                 * If the user does not want to upload, skip it.
                 */
                if(item.isFormField()==false && item.getName().length()<1) {

                    System.out.print("***Upload nothing.("+item.getFieldName()+")***");
                    continue;
                }

                if (item.isFormField() == false) {
                     if(item.getFieldName().equals("photoUpload")) {

                         p = "//upload/photoDirectory/@value";
                         String photoDir = getSingleValueFromXML(xpath, p, doc).trim();
                         /**
                          * Save photo into the web server directory.
                          */
                         photoDir = getServletContext().getRealPath("/") +  photoDir;
                         File target = new File(photoDir);
                         if(target.exists() == false) {
                             /**
                              * If the directories does not exist, create them.
                              */
                              target.mkdirs();
                         }

                         /**
                          * If the file is in chinese, it cannot decode the filename
                          * correctly. However, the ascii characters remain right.
                          * So we cannot just split the file name by dot.
                          */
                         if(item.getName().endsWith("JPG") || item.getName().endsWith("jpg")) {
                             filename += ".jpg";
                         }
                         if(item.getName().endsWith("GIF") || item.getName().endsWith("gif")) {
                             filename += ".gif";
                         }

                         if(filename.endsWith(".jpg") == false && filename.endsWith(".gif") == false) {
                             String p4 = getInitParameterPath("path.upload.error.log");
                             LoggingProxy logger  = new LoggingProxy(p4);
                             logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())+"]Upload file error, wrong file type.(" + item.getName() +")");

                             req.setAttribute("info", "文件类型错误，请重新上传。");
                             RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
                             dispatcher.forward(req, resp);

                             /* Must return here because it will go to the end and commit twice.*/
                             return;
                         }

                         filename = photoDir + "/" + filename;
                         target = new File(filename);
                         if(target.exists() == false) {
                             target.createNewFile();
                             target.setWritable(true);
                         }

                         item.write(target);

                     } else if(item.getFieldName().equals("attachmentUpload")) {
                         /* filename has been changed in the if statement above, now
                         * restore its previous value. */
                         filename = filename2;

                         p = "//upload/zipDirectory/@value";
                         String zipDir = getSingleValueFromXML(xpath, p, doc).trim();

                         /* Save zip files into the web server directory. */
                         zipDir = getServletContext().getRealPath("/") +  zipDir;
                         File target = new File(zipDir);
                         if(target.exists() == false) {
                             /* Make directories in case they don't exist. */
                             target.mkdirs();
                         }

                         if(item.getName().endsWith("zip")) {
                             filename += ".zip";
                         }

                         if(filename.endsWith(".zip") ==false) {
                             String p6 = getInitParameterPath("path.upload.error.log");
                             LoggingProxy logger  = new LoggingProxy(p6);
                             logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())+"]Upload file error, wrong file type.(" + item.getName() +")");

                             req.setAttribute("info", "文件类型错误，请重新上传。");
                             RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
                             dispatcher.forward(req, resp);
                             /* Must return here because it will go to the end and commit twice.*/
                             return;
                         }

                         filename = zipDir + "/" + filename;
                         target = new File(filename);
                         if(target.exists() == false) {
                             target.createNewFile();
                             target.setWritable(true);
                         }

                         item.write(target);
                     }
                }
            }

        } catch (FileUploadException e) {
            String p2 = getInitParameterPath("path.upload.error.log");
            LoggingProxy logger  = new LoggingProxy(p2);
            logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())+"]Upload file error. " +e.getMessage());

            req.setAttribute("info", "上传文件错误，请联系管理员。");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
            dispatcher.forward(req, resp);

            /**
             * Must return becaue it will go to the end and forward twice.
             */
            return;

        } catch (Exception e) {
            String p5 = getInitParameterPath("path.upload.error.log");
            LoggingProxy logger  = new LoggingProxy(p5);
            logger.log(LoggingProxy.ERROR, "["+getHash(req.getParameterMap())+"]Upload file error, can't write file. ");

            e.printStackTrace();

            if(resp.isCommitted() == false) {
                req.setAttribute("info", "上传文件写入错误，请联系管理员。");
                RequestDispatcher dispatcher = req.getRequestDispatcher("/error.jsp");
                dispatcher.forward(req, resp);

                /**
                 * Must return becaue it will go to the end and forward twice.
                 */
                return;
            }
        }

        /**
         * After user has uploaded files, he or she finishes all things.
         */
        RequestDispatcher dispatcher = req.getRequestDispatcher("/register_success.jsp");
        dispatcher.forward(req, resp);

        return;
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
}
