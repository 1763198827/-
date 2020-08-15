<!--#include file="CONN.asp"-->
<!--#include file="inc/Char.asp"-->
<!--#include file="inc/md5.asp" -->
<%
Head()

Data.Admin()
If Data.IsAdmin=false then
	ErrMsg="<li> 您没有登陆或不是管理员。请<a href='admin_login.asp' target='_top'>登陆</a>。"
	response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
	response.End()
end if

if request.QueryString("action")="update_info" then
	call update_info()	
else
	call main()
end if

Footer()
Sub Update_info()
	dim Username,Password_org,Password,Password2,code
	Username = trim(request.Form("Username"))
	Password_org = trim(request.Form("Password_org"))
	Password = trim(request.Form("Password_new"))
	Password2 = trim(request.Form("Password_new2"))
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
	if password_org="" or password="" or password2="" then
		ErrMsg="<li> 请您完整输入信息。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		Exit Sub
	end if
	if Password<>Password2 then
		ErrMsg="<li> 您两次输入的密码不一致，请重新输入。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		Exit Sub
	End if
	
	dim rs	
	password_org = md5 (password_org)
	set rs = Data.Execute("select * from admin where Username='"&username&"'")
	if rs.eof and rs.bof then 
		ErrMsg="<li> 用户名不正确。"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		exit sub
	else		
		if password_org = rs(2) then
			Dim SaveSet,cmd,Md5_code
			Md5_code=md5(Password)
			cmd = "Update Admin set pwd = '"&Md5_code&"' where username = '"&username&"'"
			Data.Execute(cmd)
			info="<li> 管理员密码更新成功。"
			response.Redirect("showerr.asp?action=AdminSuc&info="&info&"")
		else
			ErrMsg="<li> 您输入的密码不正确。"
			response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
			exit sub
		end if
	end if
	rs.close	
end Sub
Sub Main()
	dim username,Admin_type
	username = Session("Admin_name")
%>
  <br>
  <table width="97%" border="0" align="center" cellpadding="3" cellspacing="1" class="tableBorder">
	<form action="admin_admin.asp?action=update_info" method="post">
    <tr>
      <td colspan="3" class="title"><div align="center" class="title"> 管理员密码修改</div></td>
    </tr>
    <tr>
      <td colspan="3" class="title2">&nbsp;用于添加网站的管理员，管理员可以修改网站的设置。</td>
    </tr>
    <tr>
      <td width="16%" class="table">&nbsp;管理员用户名</td>
      <td width="84%" colspan="2" class="table"><input name="Username" type="text" id="UserName3">
      &nbsp;<font class="alert">不可修改</font></td>
    </tr>
    <tr>
      <td class="table">&nbsp;输入旧密码</td>
      <td colspan="2" class="table"><input name="Password_org" type="password" id="Password_org"></td>
    </tr>
    <tr>
      <td class="table">&nbsp;输入新密码</td>
      <td colspan="2" class="table"><input name="Password_new" type="password" id="Password_new"></td>
    </tr>
    <tr valign="top">
      <td class="table"><p align="left">&nbsp;重新输入新密码</p></td>
      <td colspan="2" class="table"><input name="Password_new2" type="password" id="Password_new2"></td>
    </tr>
    <tr valign="top">
      <td class="table"><p align="left"> &nbsp;验证码</p></td>
      <td colspan="2" class="table"><input name="code" type="text" id="code3" maxlength="4">
&nbsp; 请输入：<img src="Code.asp"></td>
    </tr>
    <tr>
      <td colspan="3" class="table"><div align="center">
          <input type="submit" name="Submit3" value="提交">
&nbsp;
          <input type="reset" name="Submit22" value="重置">
      </div></td>
    </tr>
</form>
</table>
  <%End Sub%>

