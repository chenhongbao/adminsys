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
        <%
          if(request.getAttribute("userInfo") != null) {
          %>

        var userInfo = {
            <%
            Map<String, String> m =(Map<String, String>)request.getAttribute("userInfo");
            Set<Map.Entry<String, String>> s = m.entrySet();
            Iterator<Map.Entry<String, String>> it = s.iterator();

            while (it.hasNext()) {
            Map.Entry<String, String> e = it.next();
            out.print(e.getKey() + ":" + "\"" + e.getValue() + "\"");
            if(it.hasNext()) {
            out.print(",");
            }
            }
            %>
        };

        <%
        it = s.iterator();
        %>
        var infoNames = [
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

    </script>
</head>
<body>

<script type="text/javascript" defer="defer">
    /**
     * When user logs in, set all the values registered by him formerly.
     */
    function setDefaultView() {
        /* If the userInfo and infoNames have not been set, show the registering
        * form as blank.*/
        if(!userInfo || !infoNames) {
             return;
        }

        for(var i = 0; i < infoNames.length; i = i+1) {
            var tagname = infoNames[i];
            var value = userInfo[tagname];
            var elem = document.getElementById(tagname);
            if(elem) {
                if(elem.tagName.toUpperCase() == "SELECT") {
                    var nodes = elem.childNodes;
                    for(var j=0; j<nodes.length; j = j+1) {
                        if(nodes[j].value == value) {
                            nodes[j].setAttribute("selected", "selected");
                        }
                    }
                } else if(elem.tagName.toUpperCase() == "INPUT") {
                    elem.value = value;
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
    if ((navigator.userAgent.indexOf('MSIE') >= 0) && (navigator.userAgent.indexOf('Opera') < 0)) {
        setDefaultView();
    } else if (navigator.userAgent.indexOf('Firefox') >= 0){
        window.onload = setDefaultView;
    }

</script>

<div style="float: left;">
    <!-- This span is preserved for notice. -->
    <span id="notice" name="notice"></span>
</div>

<form name="register_all" method="post" action="register.se" id="form1">
<br>

<div id="personalInfoPanel">
    <fieldset>
        <legend>
            个人信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left"><span id="nameLabel">姓名</span></td>
                <td align="left"><input name="name" value="" id="name" type="text">
                </td>
                <td align="left"><span id="sexLabel">性别</span></td>
                <td align="left"><select name="sex" id="sex" style="width:100%;">
                    <option value="男">男</option>
                    <option value="女">女</option>

                </select>
                </td>
            </tr>
            <tr>
                <td align="left"><span id="birthdayLabel">出生日期</span></td>
                <td align="left"><input name="birthday" value="" id="birthday"
                                        type="text"></td>
                <td align="left"><span id="peopleLabel">民族</span></td>
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
                <td align="left"><span id="identityLabel">证件类型</span></td>
                <td align="left"><select name="identity" id="identity"
                                         style="width:100%;">
                    <option value="身份证">身份证</option>
                    <option value="学生证">学生证</option>
                    <option value="军官证">军官证</option>

                </select></td>
                <td align="left"><span id="politicalLabel">政治面貌</span></td>
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
                <td align="left"><span id="identityNoLabel">证件号码</span></td>
                <td align="left"><input name="identityNo" value="" id="identityNo" type="text"></td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="communicationInfoPanel">
    <fieldset>
        <legend>
            联系方式
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left"><span id="phoneLabel">联系电话</span></td>
                <td align="left"><input name="phone" value="" id="phone" type="text"></td>
                <td align="left"><span id="mobileLabel">手机号码</span></td>
                <td align="left"><input name="mobile" value="" id="mobile" type="text"></td>
            </tr>
            <tr>
                <td align="left"><span id="emailLabel">电子邮箱</span></td>
                <td align="left"><input name="email" value="" id="email"
                                        type="text"></td>
                <td align="left"><span id="postalCodeLabel">邮编</span></td>
                <td align="left"><input name="postalCode" value="" id="postalCode" type="text"></td>
            </tr>
            <tr>
                <td align="left"><span id="addressLabel">通信地址</span></td>
                <td colspan="3" align="left"><input name="address" value=""
                                                    id="address" style="width:97%;" type="text"></td>
            </tr>
            </tbody>
        </table>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left"><span id="unitNameLabel">人事档案管理单位名称</span></td>
                <td colspan="3" align="left"><input name="unitName" value="" id="unitName"
                                                    style="width:97%;" type="text"></td>
            </tr>
            <tr>
                <td align="left"><span id="unitAddressLabel">人事档案管理单位地址</span></td>
                <td colspan="3" align="left"><input name="unitAddress" value=""
                                                    id="unitAddress" style="width:97%;" type="text"></td>
            </tr>
            <tr>
                <td align="left"><span id="unitPhoneLabel">联系电话</span></td>
                <td colspan="1" align="left"><input name="unitPhone" value="" id="unitPhone"
                                                    type="text"></td>
                <td align="left"><span id="unitPostalCodeLabel">邮编</span></td>
                <td colspan="1" align="left"><input name="unitPostalCode" value=""
                                                    id="unitPostalCode" type="text"></td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="otherInfoPanel">
    <fieldset>
        <legend>
            其他信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left"><span id="pwdLabel">密码</span></td>
                <td align="left"><input name="pwd" id="pwd" value=""
                                        type="password"></td>
                <td align="left"><span id="confirmPwdLabel">确认密码</span></td>
                <td align="left"><input name="confirmPwd" id="confirmPwd"
                                        value="" type="password"></td>
            </tr>
            <tr>
                <td align="left"><span id="newOrOldLabel">是否应届生</span></td>
                <td align="left"><select name="newOrOld" id="newOrOld" style="width:100%;">
                    <option value="0">否</option>
                    <option value="1">是</option>

                </select>
                </td>
                <td align="left"><span id="allDayLabel">培养模式</span></td>
                <td align="left"><select name="allDay" id="allDay"
                                         style="width:100%;">
                    <option value="0">非全日制</option>
                    <option value="1">全日制</option>

                </select>
                </td>
            </tr>
            <tr>
                <td align="left"><span id="examTypeLabel">考试类型</span></td>
                <td align="left">
                    <select name="examType" id="examType"
                            style="width:100%;">
                        <option value="1">全国统考</option>
                        <option value="2">全国联考</option>
                        <option value="3">自主招生</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td align="left"><span id="commentLabel">备注和自我评价</span></td>
                <td align="left"></td>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            <tr><td  align="left" colspan="4">
                <textarea name="comment" id="comment" rows="5" style="width: 100%;resize: none;" value=""></textarea>
            </td></tr>
            </tbody>
        </table>
        <br>
    </fieldset>
</div>

<div>
<br>

<div id="firstChoiceCollegePanel">
    <fieldset>
        <legend>
            报考院校信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left">
                    <span id="admitCardNoLabel">准考证号</span>
                </td>
                <td align="left">
                    <input name="admitCardNo" value="" id="admitCardNo" type="text">
                </td>
                <td align="left">
                    <span id="firstChoiceCollegeNameLabel">第一志愿报考院校名称</span>
                </td>
                <td align="left">
                    <input name="firstChoiceCollegeName" value="" id="firstChoiceCollegeName"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="firstChoiceCollegePostalCodeLabel">第一志愿报考院校邮编</span>
                </td>
                <td align="left">
                    <input name="firstChoiceCollegePostalCode" value=""
                           id="firstChoiceCollegePostalCode" type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="firstChoiceCollegeAddressLabel">第一志愿报考院校地址</span>
                </td>
                <td colspan="3" align="left">
                    <input name="firstChoiceCollegeAddress" value=""
                           id="firstChoiceCollegeAddress" style="width:97%;" type="text">
                </td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="firstChoiceSpecialityPanel">
    <fieldset>
        <legend>
            报考专业信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left">
                    <span id="firstChoiceSpecialityNameLabel">第一志愿报考专业名称</span>
                </td>
                <td align="left">
                    <input name="firstChoiceSpecialityName" value="" id="firstChoiceSpecialityName"
                           type="text">
                </td>
                <td align="left">
                    <span id="firstChoiceSpecialityCodeLabel">第一志愿报考专业代码</span>
                </td>
                <td align="left">
                    <input name="firstChoiceSpecialityCode" value="" id="firstChoiceSpecialityCode"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="firstChoiceSchSpecialityTypeNameLabel">第一志愿专业类别名称</span>
                </td>
                <td align="left">
                    <input name="firstChoiceSpecialityTypeName" value=""
                           id="firstChoiceSpecialityTypeName"
                           type="text">
                </td>
                <td align="left">
                    <span id="firstChoiceSpecialityTypeCodeLabel">第一志愿专业类别代码</span>
                </td>
                <td align="left">
                    <input name="firstChoiceSpecialityTypeCode" value=""
                           id="firstChoiceSpecialityTypeCode"
                           type="text">
                </td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="examResultPanel">
    <fieldset>
        <legend>
            考研成绩
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left">
                    <span id="politicalPointLabel">政治成绩</span>
                </td>
                <td align="left">
                    <input name="politicalPoint" value="" id="politicalPoint"
                           type="text">
                </td>
                <td align="left">
                    <span id="zzcodeLabel">政治科目代码</span>
                </td>
                <td align="left">
                    <input name="zzcode" value="" id="zzcode" type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="englishPointLabel">英语成绩</span>
                </td>
                <td align="left">
                    <input name="englishPoint" value="" id="englishPoint"
                           type="text">
                </td>
                <td align="left">
                    <span id="yycodeLabel">英语科目代码</span>
                </td>
                <td align="left">
                    <input name="yycode" value="" id="yycode" type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="specialityOneNameLabel">专业一名称</span>
                </td>
                <td align="left">
                    <input name="specialityOneName" value="" id="specialityOneName"
                           type="text">
                </td>
                <td align="left">
                    <span id="specialityOnePointLabel">专业一成绩</span>
                </td>
                <td align="left">
                    <input name="specialityOnePoint" value="" id="specialityOnePoint"
                           type="text">
                </td>
                <td align="left">
                    <span id="zyycodeLabel">专业一科目代码</span>
                </td>
                <td align="left">
                    <input name="zyycode" value="" id="zyycode" type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="specialityTwoNameLabel">专业二名称</span>
                </td>
                <td align="left">
                    <input name="specialityTwoName" value="" id="specialityTwoName"
                           type="text">
                </td>
                <td align="left">
                    <span id="specialityTwoPointLabel">专业二成绩</span>
                </td>
                <td align="left">
                    <input name="specialityTwoPoint" value="" id="specialityTwoPoint"
                           type="text">
                </td>
                <td align="left">
                    <span id="zyecodeLabel">专业二科目代码</span>
                </td>
                <td align="left">
                    <input name="zyecode" value="" id="zyecode" type="text">
                </td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="bachelorPanel">
    <fieldset>
        <legend>
            本科信息
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left">
                    <span id="graduateSchoolNameLabel">本科院校名称</span>
                </td>
                <td align="left">
                    <input name="graduateSchoolName" value="" id="graduateSchoolName"
                           type="text">

                </td>
                <td align="left">
                    <span id="graduateSpecialityNameLabel">本科专业名称</span>
                </td>
                <td align="left">
                    <input name="graduateSpecialityName" value="" id="graduateSpecialityName"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="graduateSpecialityTypeLabel">本科专业类别名称</span>
                </td>
                <td align="left">
                    <input name="graduateSpecialityType" value="" id="graduateSpecialityType"
                           type="text">

                </td>
                <td align="left">
                    <span id="graduateTimeLabel">本科毕业时间</span>
                </td>
                <td align="left">
                    <input name="graduateTime" value="" id="graduateTime"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="bachelorTypeLabel">所获学位类别</span>
                </td>
                <td align="left">
                    <input name="bachelorType" value="" id="bachelorType"
                           type="text">
                </td>
                <td align="left">
                    <span id="getBachelorTimeLabel">获得学位时间</span>
                </td>
                <td align="left">
                    <input name="getBachelorTime" value="" id="getBachelorTime"
                           type="text">
                </td>
            </tr>
            <tr>
                <td align="left"></td>
                <td align="left"></td>
            </tr>
            </tbody>
        </table>
        <br>

    </fieldset>
</div>
<br>

<div id="specialityPanel">
    <fieldset>
        <legend>
            申请专业方向
        </legend>
        <br>
        <table>
            <tbody>
            <tr>
                <td align="left">
                    <span id="adjustSpecialityLabel">志愿一</span>
                </td>
                <td align="left">
                    <select name="adjustSpeciality"
                            id="adjustSpeciality" style="width:220px;">
                        <option value="20001">软件工程(苏州)</option>
                        <option value="20002">集成电路设计(西安)</option>
                        <option value="20003">电信软件工程(苏州)</option>
                        <option value="20004">信息安全工程(苏州)</option>
                        <option value="20005">软件系统设计(合肥)</option>
                        <option value="20006">系统芯片设计(苏州)</option>
                        <option value="20007">项目管理(特色实验班)(合肥)</option>
                        <option value="20008">联合培养项目(苏州或合肥)</option>

                    </select>
                </td>
                <td align="left">
                    <span id="adjustSpeciality2Label">志愿二</span>
                </td>
                <td align="left">
                    <select name="adjustSpeciality2" id="adjustSpeciality2"
                            style="width:220px;">
                        <option value="20001">软件系统设计(苏州)</option>
                        <option value="20002">嵌入式系统设计(苏州)</option>
                        <option value="20003">电信软件工程(苏州)</option>
                        <option value="20004">信息安全工程(苏州)</option>
                        <option value="20005">软件系统设计(合肥)</option>
                        <option value="20006">系统芯片设计(苏州)</option>
                        <option value="20007">项目管理(特色实验班)(合肥)</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="adjustSpeciality3Label">志愿三</span>
                </td>
                <td align="left">
                    <select name="adjustSpeciality3" id="adjustSpeciality3"
                            style="width:220px;">
                        <option value="20001">软件系统设计(苏州)</option>
                        <option value="20002">嵌入式系统设计(苏州)</option>
                        <option value="20003">电信软件工程(苏州)</option>
                        <option value="20004">信息安全工程(苏州)</option>
                        <option value="20005">软件系统设计(合肥)</option>
                        <option value="20006">系统芯片设计(苏州)</option>
                        <option value="20007">项目管理(特色实验班)(合肥)</option>

                    </select>
                </td>
                <td align="left">
                    <span id="allowChangeSpecialityLabel">是否服从调剂</span>
                </td>
                <td align="left">
                    <select name="allowChangeSpeciality" id="allowChangeSpeciality"
                            style="width:220px;">
                        <option value="0">否</option>
                        <option value="1">是</option>

                    </select>
                </td>
            </tr>
            <tr style="height: 5px;">
            </tr>
            <tr>
                <td style="width: 20%" align="left">
                    联合培养单位志愿
                </td>
                <td style="width: 30%" align="left">
                </td>
            </tr>
            <tr>
                <td style="width: 20%" align="left">
                    <span id="ddllUnionTrainUnitLabel">联合培养志愿一</span>
                </td>
                <td style="width: 30%" align="left">
                    <select name="ddllUnionTrainUnit" id="ddllUnionTrainUnit" style="width:220px;">
                        <option value="深圳先进院">深圳先进院</option>
                        <option value="龙芯中科">龙芯中科</option>
                        <option value="广州海格">广州海格</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 20%" align="left">
                    <span id="ddllUnionTrainUnit2Label">联合培养志愿二</span>
                </td>
                <td style="width: 30%" align="left">
                    <select name="ddllUnionTrainUnit2" id="ddllUnionTrainUnit2" style="width:220px;">
                        <option value="深圳先进院">深圳先进院</option>
                        <option value="龙芯中科">龙芯中科</option>
                        <option value="广州海格">广州海格</option>

                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 20%" align="left">
                    <span id="ddllUnionTrainUnit3Label">联合培养志愿三</span>
                </td>
                <td style="width: 30%" align="left">
                    <select name="ddllUnionTrainUnit3" id="ddllUnionTrainUnit3" style="width:220px;">
                        <option value="深圳先进院">深圳先进院</option>
                        <option value="龙芯中科">龙芯中科</option>
                        <option value="广州海格">广州海格</option>

                    </select>
                </td>
            </tr>
            </tbody>
        </table>
        <br>
    </fieldset>
</div>

<br>

<table align="center">
    <tbody>
    <tr>
        <td><input value="完成注册" name="finish" id="finish" type="submit"></td>
                  <!-- onclick="return checkInputField();" -->
    </tr>
    </tbody>
</table>

</div>
</form>


</body>
</html>