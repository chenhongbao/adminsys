<%@ page contentType="text/html; charset=utf-8"%>

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

<table style="height: 300px; width: 100%; border: 0px; padding: 0px; margin: 0px;">
    <tbody>
    <tr>
        <td align="center" valign="center">
                   <div style="width:400px; border: 1px; border-color: #a52a2a; border-style: solid; padding-top: 10px;">
                       <form action="findpwd.se" method="POST" target="_top">
                            <p>
                                <span style="font-size: 15px; font-weight: bolder;">请输入你的证件号：</span>
                                <input type="text" name="identityNo" id="identityNo" size="20" value=""/>
                                <input type="submit" name="getemail" value="获取密码" />
                            </p>
                       </form>
                   </div>
        </td>
    </tr>
    </tbody>
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
