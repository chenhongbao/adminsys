<%@ page import="chb.bean.NewsLead" %>
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
<body>
<%
    NewsLead lead = (NewsLead)request.getAttribute("newsLead");
%>
<table width="680" cellspacing="0" cellpadding="0" border="0">
    <tbody>
    <tr>
        <td class="text" valign="middle"style="width: 100%;">
            <div class="title"><%= lead.getTitle()%></div>
            <hr width="100%" size="1" noshade="" color="#999999" align="CENTER" />
            <p align="center">
                <span class="style2">发表时间：<%= lead.getCreateTime()%>&nbsp;修改时间：<%= lead.getUpdateTime()%>&nbsp;作者：<%= lead.getAuthorName()%></span>
            </p>
            <p><%= lead.getContent()%></p>
        </td>
    </tr>
    </tbody>

</table>

</body>
</html>
