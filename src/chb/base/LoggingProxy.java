package chb.base;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class LoggingProxy {
    /**
     * Three levels of logging.
     */
    public final static String INFO = "INFO";
    public final static String WARNING = "WARNING";
    public final static String ERROR = "ERROR";

    protected File log = null;

    public LoggingProxy() {}

    public LoggingProxy(String logPath) {
         setLogFile(logPath);
    }

    /**
     * Set the logging file.
     * @param logPath Path to the logging file.
     * @return  True for success.
     */
    public boolean setLogFile(String logPath) {
        if(logPath == null | logPath.length() < 1) {
            return false;
        }
         this.log = new File(logPath);
        if(this.log.exists() == false) {
            try {
                this.log.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }

        if(this.log.canWrite() == false ) {
            this.log.setWritable(true);
        }

        return true;
    }

    /**
     * Logging API.
     * @param level Level of log.
     * @param msg Message to be logged.
     * @return  True for success.
     */
    public boolean log(String level, String msg) {
        FileWriter fw = null;
        String text = "";

        text += "***\t" + getTimeStamp() + "\t***\t";
        text += "[" + level +"]\t" + msg;
        try {
            fw = new FileWriter(log, true);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        PrintWriter  pw = new PrintWriter(fw);
        pw.append(text + "\n");
        pw.flush();
        pw.close();

        return true;
    }

    /**
     * Get NOW() as string.
     * @return string of the time currently
     */
    public static String getTimeStamp() {
        Date now=new Date();
        SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd k:mm:ss");
        return f.format(now);
    }



}
