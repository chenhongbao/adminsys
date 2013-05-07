<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>
<%@ page contentType="text/html; charset=utf-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>
        西安交通大学软件学院招生系统
    </title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="css/reset_style.css" type="text/css">
    <script src="js/function.js" type="text/javascript"></script>

    <script type="text/javascript">
        var userInfo = null;
        var infoNames = null;
        <%
          if(request.getAttribute("userInfo") != null) {
          %>

        userInfo = {
            <%
            Map<String, String> m =(Map<String, String>)request.getAttribute("userInfo");
            Set<Map.Entry<String, String>> s = m.entrySet();
            Iterator<Map.Entry<String, String>> it = s.iterator();

            while (it.hasNext()) {
            Map.Entry<String, String> e = it.next();
            /* No new line is allowed. */
            String k = e.getKey().replace("\n", "");
            String v = e.getValue();
            if(v == null) {
                 v = "";
            } else {
                /* Textarea's new line is noted by charCode(13). */
                v = v.replace("\r\n", "\\n");
                v = v.replace("\n\r", "\\n");
                v = v.replace("\n", "\\n");
                if(v == null) {
                     v = "";
                }
            }
            out.print(k + ":" + "\"" + v + "\"");
            if(it.hasNext()) {
            out.print(",");
            }
            }
            %>
        };

        <%
        it = s.iterator();
        %>
        infoNames = [
        <%
        while (it.hasNext()) {
        Map.Entry<String, String> e = it.next();
        out.print("\""+e.getKey()+"\"");
        if(it.hasNext()) {
        out.print(",");
        }
        }
        %>
        ];
        <%
          }
        %>

        /* First element is status, second element is updateTime. */

<%
if(request.getAttribute("applicationInfo") != null) {
    Map<String, String> m2 = (Map<String, String>)request.getAttribute("applicationInfo");
    out.print("var applicationInfo = [");
    out.print("\""+ m2.get("status") +"\"");
    out.print(",");
    out.print("\""+ m2.get("updateTime") +"\"];");
}
%>

    </script>

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

</head>
<body>

<script type="text/javascript" defer="defer">
    /**
     * set the content of the notice banner.
     */
    function setNotice(x,status, uptime) {
        if(x && status && uptime) {
            x.innerHTML = "同学，你好。欢迎填报西安交通大学软件学院。"
                    +"<br>你当前的状态是<strong>"
                    + status +"</strong>（更新时间："+ uptime +"）。";
        }
    }
    /**
     * When user logs in, set all the values registered by him formerly.
     */
    function setDefaultView() {
        /* If the userInfo and infoNames have not been set, show the registering
        * form as blank.*/
        if(!userInfo || !infoNames) {
            var notice = document.getElementById("notice");
            if(notice) {
                /* user is registering. */
                 setNotice(notice, "未审核", "当前");
            }
             return;
        }

        var notice = document.getElementById("notice");
        if(notice) {
            /* user is registering. */
            setNotice(notice, applicationInfo[0], applicationInfo[1]);
        }

        /* User logs in at a second time, show status. */


        for(var i = 0; i < infoNames.length; i = i+1) {
            var tagname = infoNames[i];
            var value = userInfo[tagname];
            var elem = document.getElementById(tagname);
            if(elem) {
                if(elem.tagName.toUpperCase() == "SELECT") {
                    var nodes = elem.options;
                    for(var j=0; j<nodes.length; j = j+1) {
                        if(nodes[j].value == value) {
                            nodes[j].selected = true;
                            break;
                        }
                    }
                } else if(elem.tagName.toUpperCase() == "INPUT") {
                    if(elem.type.toUpperCase() != "PASSWORD"){
                        elem.value = value;
                    }
                    if(elem.getAttribute("name") == "identityNo") {
                        elem.setAttribute("disabled", "disabled");
                        // Add a hidden input to pass the identityNo
                        var form = document.getElementById("form1");
                        if(form) {
                            var n = document.createElement("input");
                            n.setAttribute("type", "hidden");
                            n.setAttribute("value", elem.value);
                            n.setAttribute("name", "identityNo");
                            form.appendChild(n);
                        }
                    }
                } else if(elem.tagName.toUpperCase() == "TEXTAREA") {
                    elem.value = value;
                }
            }
        }
     }
</script>

<!-- Call the method after the whole page is loaded. -->
<!-- Detect the type of the browser for compatibility. -->
<script type="text/javascript" defer="defer">
    window.onload = setDefaultView;
    setDefaultView();
    setTimeout("setDefaultView()", 1000);

</script>
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
                    <a style="font-size: 13px;color: #333333;" href="http://se.xjtu.edu.cn/"
                       target="_blank">学院主页&nbsp;</a>
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

<div id="systemInfo" class="register">
    <br>
    <!-- This span is preserved for notice. -->
    <fieldset style="border-color: #8b0000;">
         <legend style="color: #8b0000">系统通知</legend>
        <span id="notice" name="notice"></span>
    </fieldset>

</div>

<form name="register_all" method="post" action="register.se" id="form1">
<br>

<div id="personalInfoPanel" class="register">
    <fieldset>
        <legend>
            个人信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="right"><span id="nameLabel">姓名：</span></td>
                <td align="left"><input name="name" value="" id="name" type="text">
                </td>
                <td align="right"><span id="sexLabel">性别：</span></td>
                <td align="left"><select name="sex" id="sex" style="width:100%;">
                    <option value="男">男</option>
                    <option value="女">女</option>

                </select>
                </td>
            </tr>
            <tr>
                <td align="right"><span id="locationLabel">籍贯：</span></td>
                <td align="left">
                    <input name="location" value="" id="location" type="text" />
                </td>
                <td align="right"><span id="peopleLabel">民族：</span></td>
                <td align="left"><select name="people" id="people" style="width:100%;">
                    <option value="汉族">汉族</option>
                    <option value="蒙古族">蒙古族</option>
                    <option value="回族">回族</option>
                    <option value="藏族">藏族</option>
                    <option value="维吾尔族">维吾尔族</option>
                    <option value="苗族">苗族</option>
                    <option value="彝族">彝族</option>
                    <option value="壮族">壮族</option>
                    <option value="布依族">布依族</option>
                    <option value="朝鲜族">朝鲜族</option>
                    <option value="满族">满族</option>
                    <option value="侗族">侗族</option>
                    <option value="瑶族">瑶族</option>
                    <option value="白族">白族</option>
                    <option value="土家族">土家族</option>
                    <option value="哈尼族">哈尼族</option>
                    <option value="哈萨克族">哈萨克族</option>
                    <option value="傣族">傣族</option>
                    <option value="黎族">黎族</option>
                    <option value="傈傈族">傈傈族</option>
                    <option value="佤族">佤族</option>
                    <option value="畲族">畲族</option>
                    <option value="高山族">高山族</option>
                    <option value="拉祜族">拉祜族</option>
                    <option value="水族">水族</option>
                    <option value="东乡族">东乡族</option>
                    <option value="纳西族">纳西族</option>
                    <option value="景颇族">景颇族</option>
                    <option value="柯尔克孜族">柯尔克孜族</option>
                    <option value="土族">土族</option>
                    <option value="达斡尔族">达斡尔族</option>
                    <option value="仫佬族">仫佬族</option>
                    <option value="羌族">羌族</option>
                    <option value="布朗族">布朗族</option>
                    <option value="撒拉族">撒拉族</option>
                    <option value="毛南族">毛南族</option>
                    <option value="仡佬族">仡佬族</option>
                    <option value="锡伯族">锡伯族</option>
                    <option value="阿昌族">阿昌族</option>
                    <option value="普米族">普米族</option>
                    <option value="塔吉克族">塔吉克族</option>
                    <option value="怒族">怒族</option>
                    <option value="乌孜别克族">乌孜别克族</option>
                    <option value="俄罗斯族">俄罗斯族</option>
                    <option value="鄂温克族">鄂温克族</option>
                    <option value="德昂族">德昂族</option>
                    <option value="保安族">保安族</option>
                    <option value="裕固族">裕固族</option>
                    <option value="京族">京族</option>
                    <option value="塔塔尔族">塔塔尔族</option>
                    <option value="独龙族">独龙族</option>
                    <option value="鄂伦春族">鄂伦春族</option>
                    <option value="赫哲族">赫哲族</option>
                    <option value="门巴族">门巴族</option>
                    <option value="珞巴族">珞巴族</option>
                    <option value="基诺族">基诺族</option>

                </select>
                </td>
            </tr>
            <tr>
                <td></td>
                <td><span style="font-size: 11px; color: #a52a2a;">籍贯格式:XX省XX市</span></td>
            </tr>
            <tr>
                <td align="right"><span id="identityLabel">证件类型：</span></td>
                <td align="left"><select name="identity" id="identity"
                                         style="width:100%;">
                    <option value="身份证">身份证</option>
                    <option value="军官证">军官证</option>

                </select></td>
                <td align="right"><span id="politicalLabel">政治面貌：</span></td>
                <td align="left"><select name="political" id="political" style="width:100%;">
                    <option value="中共党员">中共党员</option>
                    <option value="共青团员">共青团员</option>
                    <option value="中共预备党员">中共预备党员</option>
                    <option value="群众">群众</option>
                    <option value="其他">其他</option>

                </select>
                </td>
            </tr>
            <tr>
                <td align="right"><span id="identityNoLabel">证件号码：</span></td>
                <td align="left"><input name="identityNo" value="" id="identityNo"
                                        type="text" maxlength="18"></td>
                <td align="right"><span id="birthdayLabel">出生日期：</span></td>
                <td align="left"><input name="birthday" value="" id="birthday"
                                        type="text"></td>
            </tr>
            <tr>
                <td></td><td></td><td></td>
                <td><span style="font-size: 11px; color: #a52a2a;">日期格式:YYYY-MM-DD</span></td></tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="communicationInfoPanel" class="register">
    <fieldset>
        <legend>
            联系方式
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="right"><span id="phoneLabel">联系电话：</span></td>
                <td align="left"><input name="phone" value="" id="phone" type="text"></td>
                <td align="right"><span id="mobileLabel">手机号码：</span></td>
                <td align="left"><input name="mobile" value="" id="mobile" type="text"></td>
            </tr>
            <tr>
                <td></td><td align="left" colspan="3">
                    <span style="font-size: 11px;color: #a52a2a;">联系电话和手机号码必须正确，否则我们无法联系到你。</span>
                </td>
            </tr>
            <tr>
                <td align="right"><span id="emailLabel">电子邮箱：</span></td>
                <td align="left"><input name="email" value="" id="email"
                                        type="text"></td>
                <td align="right"><span id="postalCodeLabel">邮编：</span></td>
                <td align="left"><input name="postalCode" value="" id="postalCode" type="text"></td>
            </tr>
            <tr>
                <td align="right"><span id="addressLabel">通信地址：</span></td>
                <td colspan="3" align="left"><input name="address" value=""
                                                    id="address" style="width:97%;" type="text"></td>
            </tr>
            <tr>
                <td align="left"><span id="unitNameLabel">所在单位：</span></td>
                <td colspan="3" align="left"><input name="unitName" value="" id="unitName"
                                                    style="width:97%;" type="text"></td>
            </tr>
            </tbody>
        </table>
        <br>
    </fieldset>
</div>
<br>

<div id="otherInfoPanel" class="register">
    <fieldset>
        <legend>
            其他信息
        </legend>
        <br>
        <table>
            <tbody>
            <!--
                 If the user logs in again, password blank will not appear.
                 If the user log in again, the userInfo attribute will exist.
            -->
            <%
                if(request.getAttribute("userInfo") == null) {
            %>
            <tr>
                <td align="right"><span id="pwdLabel">密码：</span></td>
                <td align="left"><input name="pwd" id="pwd" value=""
                                        type="password"></td>
                <td align="right"><span id="confirmPwdLabel">确认密码：</span></td>
                <td align="left"><input name="confirmPwd" id="confirmPwd"
                                        value="" type="password"></td>
            </tr>
            <%
                }
            %>
            <tr>
                <td align="right"><span id="educationLabel">学历：</span></td>
                <td align="left"><select name="education" id="education"
                                         style="width:100%;">
                    <option value="本科">本科</option>
                    <option value="大专">大专</option></select>
                </td>
                <td align="right"><span id="newOrOldLabel">是否应届：</span></td>
                <td align="left"><select name="newOrOld" id="newOrOld" style="width:100%;">
                    <option value="应届">是</option>
                    <option value="其他">否</option>
                </select>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span id="commentLabel">备注：</span>
                </td>
                <td  align="left" colspan="3">
                <textarea name="comment" id="comment" rows="5" style="width: 100%;resize: none;" value=""></textarea>
            </td></tr>
            <tr>
                <td></td><td></td><td></td>
                <td align="right"><span style="font-size: 11px;color: #a52a2a;">（不多于200字）</span></td>
            </tr>
            </tbody>
        </table>
        <br>
    </fieldset>
</div>

<div>
<br>

<div id="firstChoiceInfoPanel" class="register">
    <fieldset>
        <legend>
            第一志愿报考信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="right">
                    <span id="admitCardNoLabel">准考证号：</span>
                </td>
                <td align="left">
                    <input name="admitCardNo" value="" id="admitCardNo" type="text">
                </td>
                <td align="right">
                    <span id="firstChoiceCollegeNameLabel">报考院校：</span>
                </td>
                <td align="left">
                    <input name="firstChoiceCollegeName" value="" id="firstChoiceCollegeName"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span id="firstChoiceSpecialityNameLabel">报考专业：</span>
                </td>
                <td align="left">
                    <input name="firstChoiceSpecialityName" value="" id="firstChoiceSpecialityName"
                           type="text">
                </td>
                <td align="right">
                    <span id="firstChoiceSpecialityCodeLabel">专业代码：</span>
                </td>
                <td align="left">
                    <input name="firstChoiceSpecialityCode" value="" id="firstChoiceSpecialityCode"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="right"><span id="examTypeLabel">考试类型：</span></td>
                <td align="left">
                    <select name="examType" id="examType"
                            style="width:100%;">
                        <option value="统考">全国统考</option>
                        <option value="联考">全国联考</option>
                        <option value="自主招生">自主招生</option>

                    </select>
                </td>
                <td align="right"><span id="allDayLabel">培养模式：</span></td>
                <td align="left"><select name="allDay" id="allDay"
                                         style="width:100%;">
                    <option value="全日制">全日制</option>
                    <option value="非全日制">非全日制</option>
                </select>
                </td>
            </tr>

            <!-- Newly added according to Qin lianying's requirement. -->
            <tr>
                <td align="right"><span id="masterTypeLabel">学位类型：</span></td>
                <td align="left"><select name="masterType" id="masterType"
                                         style="width:100%;">
                    <option value="学术型">学术型</option>
                    <option value="专业型">专业型</option></select>
                </td>
                <td align="right"><span id="weipeiLabel">是否委培：</span></td>
                <td align="left"><select name="weipeiType" id="weipeiType"
                                         style="width:100%;">
                    <option value="否">否</option>
                    <option value="国防生">国防生</option>
                    <option value="强军计划">强军计划</option></select>
                </td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="examResultPanel" class="register">
    <fieldset>
        <legend>
            考研成绩
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="right">
                    <span id="politicalPointLabel">政治：</span>
                </td>
                <td align="left">
                    <input name="politicalPoint" value="" id="politicalPoint"
                           type="text">
                </td>
                <td align="right">
                    <span id="englishPointLabel">英语：</span>
                </td>
                <td align="left">
                    <input name="englishPoint" value="" id="englishPoint"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span id="specialityOneNameLabel">专业一：</span>
                </td>
                <td align="left">
                    <input name="specialityOneName" value="" id="specialityOneName"
                           type="text">
                </td>
                <td align="right">
                    <span id="specialityOnePointLabel">专业一成绩：</span>
                </td>
                <td align="left">
                    <input name="specialityOnePoint" value="" id="specialityOnePoint"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span id="specialityTwoNameLabel">专业二：</span>
                </td>
                <td align="left">
                    <input name="specialityTwoName" value="" id="specialityTwoName"
                           type="text">
                </td>
                <td align="right">
                    <span id="specialityTwoPointLabel">专业二成绩：</span>
                </td>
                <td align="left">
                    <input name="specialityTwoPoint" value="" id="specialityTwoPoint"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span id="totalPointLabel">总分：</span>
                </td>
                <td align="left">
                    <input name="totalPoint" value="" id="totalPoint" type="text">
                </td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="bachelorPanel" class="register">
    <fieldset>
        <legend>
            本科毕业信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="right">
                    <span id="graduateSchoolNameLabel">毕业院校：</span>
                </td>
                <td align="left">
                    <input name="graduateSchoolName" value="" id="graduateSchoolName"
                           type="text">

                </td>
                <td align="right">
                    <span id="graduateSpecialityNameLabel">本科专业：</span>
                </td>
                <td align="left">
                    <input name="graduateSpecialityName" value="" id="graduateSpecialityName"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span id="bachelorTypeLabel">学位类型：</span>
                </td>
                <td align="left">
                    <input name="bachelorType" value="" id="bachelorType"
                           type="text">
                </td>
                <td align="right">
                    <span id="graduateTimeLabel">本科毕业时间：</span>
                </td>
                <td align="left">
                    <input name="graduateTime" value="" id="graduateTime"
                           type="text">
                </td>
            </tr>
            <tr>
                <td></td><td></td><td></td>
                <td><span style="font-size: 11px; color: #a52a2a;">日期格式:YYYY-MM-DD</span></td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="specialityPanel" class="register">
    <fieldset>
        <legend>
            申请专业方向
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="right">
                    <span id="adjustSpecialityLabel">志愿一：</span>
                </td>
                <td align="left">
                    <select name="adjustSpeciality"
                            id="adjustSpeciality" style="width:220px;">
                        <option value="软件工程">软件工程</option>
                        <option value="业务分析">业务分析</option>
                        <option value="金融信息工程">金融信息工程</option>
                        <option value="集成电路">集成电路</option>
                        <option value="移动云计算（苏州）">移动云计算（苏州）</option>
                    </select>
                </td>
                <td align="right">
                    <span id="adjustSpeciality2Label">志愿二：</span>
                </td>
                <td align="left">
                    <select name="adjustSpeciality2" id="adjustSpeciality2"
                            style="width:220px;">
                        <option value="软件工程">软件工程</option>
                        <option value="业务分析">业务分析</option>
                        <option value="金融信息工程">金融信息工程</option>
                        <option value="集成电路">集成电路</option>
                        <option value="移动云计算（苏州）">移动云计算（苏州）</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <span id="adjustSpeciality3Label">志愿三：</span>
                </td>
                <td align="left">
                    <select name="adjustSpeciality3" id="adjustSpeciality3"
                            style="width:220px;">
                        <option value="软件工程">软件工程</option>
                        <option value="业务分析">业务分析</option>
                        <option value="金融信息工程">金融信息工程</option>
                        <option value="集成电路">集成电路</option>
                        <option value="移动云计算（苏州）">移动云计算（苏州）</option>

                    </select>
                </td>
                <td align="right">
                    <span id="allowChangeSpecialityLabel">服从调剂：</span>
                </td>
                <td align="left">
                    <select name="allowChangeSpeciality" id="allowChangeSpeciality"
                            style="width:220px;">
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 5px;">
            </tr>
            </tbody>
        </table>
        <br>
    </fieldset>
</div>

<br>

<table align="center" style="width: 100%;">
    <tbody>
    <tr>
        <td><input value="完成注册" name="finish" id="finish"
                   onclick="return checkInputField();"
                   type="submit"></td>

    </tr>
    </tbody>
</table>

</div>
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
