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

<table style="width: 100%; border: 0px; padding: 0px; margin: 0px;">
    <tr>
        <td align="center">
            <div style="width: 760px; overflow: hidden;">
                <img style="float: left;" src="img/xjtuse_adsys.png" alt="西安交通大学招生系统" title="西安交通大学招生系统"/>

                <div style="width: 353px; height: 25px; float: left;"></div>
                <div style="width: auto; height: 13px; float: right;">
                    <a style="font-size: 13px;color: #333333;" href="http://se.xjtu.edu.cn/"
                       target="_blank">学院主页&nbsp;|</a>
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
    NewsLead lead = (NewsLead)request.getAttribute("newsLead");
%>
<table width="100%;">
    <tr><td align="center">
<table width="680" cellspacing="0" cellpadding="0" border="0">
    <tbody>
    <tr>
        <td class="text" valign="middle" style="width: 100%;">
            <div class="news_title"><%= lead.getTitle()%></div>
            <hr width="100%" size="1" noshade="" color="#999999" align="CENTER" />
            <p align="center">
                <span class="news_signature">发表时间：<%= lead.getCreateTime()%>&nbsp;修改时间：<%= lead.getUpdateTime()%>&nbsp;作者：<%= lead.getAuthorName()%></span>
            </p>
            <p class="news_text"><%= lead.getContent()%></p>
        </td>
    </tr>
    </tbody>

</table>
    </td></tr>
</table>

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
</body>
</html>
