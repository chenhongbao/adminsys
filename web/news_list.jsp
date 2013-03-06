<%@ page import="chb.bean.NewsLead" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <title>西安交通大学软件学院招生系统</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="css/reset_style.css" type="text/css">
</head>
<body style="padding: 0px;">

<%
if(request.getParameter("top")!=null && request.getParameter("top").equals("1"))  {
%>
<table style="width: 100%; border: 0px; padding: 0px; margin: 0px;">
    <tr>
        <td align="center">
            <div style="width: 760px; overflow: hidden;">
                <img style="float: left;" src="img/xjtuse_adsys.png" alt="西安交通大学招生系统" title="西安交通大学招生系统"/>

                <div style="width: 353px; height: 25px; float: left;"></div>
                <div style="width: auto; height: 13px; float: right;">
                    <a style="font-size: 13px;color: #333333;"
                       href="javascript:window.external.AddFavorite('http://se.xjtu.edu.cn','西安交通大学软件学院')"
                       target="_top">加入收藏&nbsp;|</a>
                    <a style="font-size: 13px;color: #333333;" href="#">管理入口</a>
                </div>
            </div>
        </td>
    </tr>
    <tr align="center">
        <td>
            <div style="overflow: hidden;">
                <img src="img/top_1.png"/>
            </div>
        </td>
    </tr>
    <tr align="center">
        <td>
            <div style="overflow: hidden;">
                <img src="img/big_screen.jpg"/>
            </div>
        </td>
    </tr>
    <tr align="center">
        <td>
            <div style="overflow: hidden;">
                <img src="img/top_2.png"/>
            </div>
        </td>
    </tr>
</table>
<%
}
%>

<table style="width: 100%;">
    <tr>
        <td align="center">
            <%
                if(request.getParameter("top")!=null && request.getParameter("top").equals("1")) {
            %>
        <div style="width: 760px;">
            <%
                } else {
            %>
                <div style="width: 460px;">
                    <%
                        }
                    %>
<table style="width: 100%;">
    <tbody>
    <tr>
        <td align="left" colspan="3">
             <img src="img/news_title.png" alt="招生动态" title="招生动态"/>
        </td>
    </tr>
<%
if(request.getAttribute("newsList") != null) {
    List<NewsLead> list = (List<NewsLead>)request.getAttribute("newsList");
    for(int i=0; i<list.size(); ++i) {
        NewsLead lead = list.get(i);
%>
<tr>
    <td align="left" style="width: 50%;">
        <span><a target="_blank" href="<%= "news.se?"+"title="+URLEncoder.encode(lead.getTitle(),"UTF-8")%>">
            <%= lead.getTitle()%></a></span>
    </td>
    <td align="left">
        <span><%= lead.getUpdateTime()%></span>
    </td>
    <td align="left">
        <span><%= lead.getAuthorName()%></span>
    </td>
</tr>
<%
    }
}
%>
<%
String num = (String)request.getAttribute("num");
if( num != null && num.equals("-1") == false) {
%>
    <tr>
        <td style="height: 10px;"></td>
        <td></td>
        <td></td>
    </tr>
    </tbody>
    <tfoot>
        <tr>
            <td></td>
            <td></td>
            <td align="right">
                <div>
                    <a target="_blank" style="color: #a52a2a" href="news.se?num=-1&top=1">更多>></a>
                </div>
            </td>
        </tr>
    </tfoot>
<%
}
%>
</table>
    </div>
    </td>
    </tr>
</table>

<%
    if(request.getParameter("top")!=null && request.getParameter("top").equals("1")) {
        %>
<table style="width: 100%; border: 0px; padding: 0px; margin: 0px;">
    <tr>
        <td align="center">
            <div style="overflow: hidden;">
                <img src="img/bottom_01.jpg"/>
            </div>
        </td>
    </tr>
    <tr>
        <td align="center">
            <div style="overflow: hidden;">
                <img src="img/bottom_02.jpg"/>
            </div>
        </td>
    </tr>
</table>
<%
    }
%>

</body>
</html>
