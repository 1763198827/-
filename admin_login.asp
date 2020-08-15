<!--#include file="CONN.ASP" -->
<!--#include file="inc/md5.asp" -->


<link href="admin_style.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>系统登陆</title>
<style>
	.menuover { border: 1px #08246B solid; background-image:url(images/manage/tbover.gif); cursor:default;}
	.menuUp {  border: 1px #333333 Dashed; background-color: #ffffff; font-size: 12px; font-family: Arial; filter:progid:DXImageTransform.Microsoft.Alpha(opacity=50);cursor:default;}
	.menudown { border: 1px #08246B solid; background-image:url(images/manage/tbdown.gif);cursor:default;}
</style>
<%
Data.Admin()
	if request.QueryString("action")="chk" then
		call chk()   
	end if
	if request.QueryString("action")="" then
		if Data.IsAdmin then
			response.Redirect("index.asp")
			response.end()
		else
			call login()
		end if
	end if
Sub login()
	On Error Resume Next
	Dim Ados,GetCode
	Set Ados=Server.CreateObject("Adodb.Stream")
	If Err Then
		GetCode=9999
	End If
%>
<br>
<br>
<table width="465" border="3" align="center" cellpadding="1" cellspacing="0">
  <tr>
    <td height="26" bordercolor="#FFFFFF" background="images/manage/admin_bg_1.gif"><div align="center"><font color="#FFFFFF"><strong><span class="title3"><%=Data.SiteSetting(0)%></span> - 管 理 登 录</strong></font></div></td>
  </tr>
  <tr valign="top">
    <td width="455" height="254" bordercolor="#FFFFFF" background="images/manage/login2.jpg"><div align="center">
      <table width="337" border="0" align="right" cellpadding="0" cellspacing="0">
	  <form action="admin_login.asp?action=chk" method="post" name="login">
        <tr>
          <td width="229" rowspan="2">&nbsp;</td>
          <td width="108" height="93">&nbsp;</td>
        </tr>
        <tr>
          <td height="18"><div align="right">&nbsp;&nbsp;</div></td>
        </tr>
        <tr>
          <td height="18"><input name="username" type="text" size="20" height="18"  class="login_lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="login_lostfocus"' onblur='this.className="login_lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'></td>
          <td width="108" rowspan="5">&nbsp;</td>
        </tr>
        <tr>
          <td height="8"></td>
          </tr>
        <tr>
          <td height="21"><input name="password" type="password" size="20" height="18" class="login_lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="login_lostfocus"' onblur='this.className="login_lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'></td>
          </tr>
        <tr>
          <td height="8"></td>
          </tr>
        <tr>
          <td height="21"><input name="code" type="text" size="4" maxlength="4"  height="18" class="login_lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="login_lostfocus"' onblur='this.className="login_lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'>            　
            　<img src="Code.asp" width="40" height="10">&nbsp;&nbsp;
            <input name="登录" type="submit" class="menuUp" onMouseDown='this.className="menudown"' onMouseOver='this.className="menuover"' onMouseOut='this.className="menuUp"' value="登录" width="35"></td>
          </tr></form>
      </table>
    </div></td>
  </tr>
  <tr>
    <td bordercolor="#FFFFFF" bgcolor="#F0F0F0">    <div align="right"> </div></td>
  </tr>
</table>
<%end sub

sub chk()
	dim username,password,code
	username=trim(request.form("username"))
	password=trim(request.form("password"))
	code=trim(request.Form("code"))
	if code="" then
		ErrMsg="<li> 请返回输入确认码。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		Exit Sub
	elseif session("getcode")="" then
		ErrMsg="<li> 请不要重复提交，如需重新登录请返回登录页面。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		Exit Sub
	elseif cstr(session("getcode"))<>cstr(trim(code)) then
		ErrMsg="<li> 您输入的确认码和系统产生的不一致，请重新输入。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		Exit Sub
	end if
		session("getcode")=""
	if username="" or password="" then
		ErrMsg="<li> 请输入您的用户名或密码。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		Exit Sub
	end if
		
	dim rs	
	password = md5(password)
	set rs = Data.Execute("select * from admin where Username='"&username&"'")
	if rs.eof and rs.bof then 
		ErrMsg="<li> 您输入的用户名不正确或者您不是系统管理员。请<a href=admin_login.asp>重新输入</a>您的用户名。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		exit sub
	else
	Response.Write(Password&"&nbsp;"&rs(1))
		if password=rs(2) then
			Session("IsAdmin")=1
			Session("Admin_name")=username
			Session("Belong")=rs(4)
			Set TempRs=Data.Execute("Select Name,StId from Shetuan Where StId = "&Session("Belong")&";")
			Session("Shetuan")=TempRs("Name")
			TempRs.close
			Session("Level")=rs(3)
			Select Case rs(3)
				Case 0
					Session("Admin_type")="超级管理员"
				Case 1
					Session("Admin_type")="协会管理员"
				Case "新闻管理员"
					Session("Admin_type")="新闻管理员"
				Case "下载管理员"
					Session("Admin_type")="下载管理员"
				Case "图片管理员"
					Session("Admin_type")="图片管理员"
				Case "音乐管理员"
					Session("Admin_type")="音乐管理员"
				End Select
			response.Redirect("index.asp")
		else
			ErrMsg="<li> 您输入的密码不正确或者您不是系统管理员。请<a href=admin_login.asp>重新输入</a>您的密码。"
			response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
			exit sub
		end if
	end if
	rs.close
end sub
%>
