package chb.test;


import chb.base.LoggingProxy;

public class Main {

    public static void main(String[] args) {
        String lpath = "E:\\Users\\Administrator\\workspace\\git\\adminsys\\web\\log\\register.data.log";
        LoggingProxy logproxy = new LoggingProxy(lpath);

        logproxy.log(LoggingProxy.WARNING, "Hello, LoggingProcxy.");
    }
}
