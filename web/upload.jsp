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

<style type="text/css">
    body {
        text-align: center;
    }
    .register {
        width: 740px;
        margin-left: auto;
        margin-right: auto;
        text-align: left;
    }
</style>

<body>

<!-- Give '?top=1', will show the top banner, other value will hid the banner. -->
<%
    if(request.getParameter("top")!=null && request.getParameter("top").equals("1")) {
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
</table>

<%
    }
%>


<form name="upload_all" method="post" action="upload.se" id="form1" enctype="multipart/form-data">
    <input name="identityNo" id='identityNo' type="hidden" value="<%= request.getParameter("identityNo")%>" />
    <br>
    <div id="uploadFile" class="register">
        <fieldset>
            <legend>
                上传文件
            </legend>
            <br>
            <table>
                <tbody>
                <tr>
                    <td align="left"><span id="photoLabel">免冠照片</span></td>
                    <td align="left">
                        <input name="photoUpload" id="photoUpload" onkeydown="event.returnValue=false;" onpaste="return false;" type="file">
                    </td>
                </tr>
                <tr>
                    <td align="left"><span id="attachmentLabel">打包附件</span></td>
                    <td align="left">
                        <input name="attachmentUpload" id="attachmentUpload" onkeydown="event.returnValue=false;" onpaste="return false;" type="file">
                    </td>
                </tr>
                </tbody>

            </table>

            <br>
            <span style="color: Red">温馨提示：</span>
            <br>
            <span style="color: Red">上传免冠照片和附件是可选项目，但提交完整材料将有利于你成功报考西安交通大学软件学院。注意，上传照片小于100K,格式为JPG或者GIF，附件需把有关材料（如成绩单扫描件，四六级证扫描件等）打包成zip文件再上传，大小最多不超过5MB。</span>
            <br>
            <br>

        </fieldset>
    </div>
    <table align="center" class="register" style="width: 100%;">
        <tbody>
        <tr>
            <td align="center"><input name="upload" value="上传文件" onclick=""
                       id="upload" type="submit"></td>
        </tr>
        </tbody>
    </table>
</form>

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
