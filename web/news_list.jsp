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

<table style="width: 400px;">
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
                    <a target="_blank" style="color: #a52a2a" href="news.se?num=-1">更多>></a>
                </div>
            </td>
        </tr>
    </tfoot>
<%
}
%>
</table>

</body>
</html>
