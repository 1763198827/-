<!--#include file="CONN.ASP"-->
<%
If request.QueryString("action")="AdminErr" then
	ErrMsg = request.QueryString("ErrMsg")
	call AdminErr()
End if
If request.QueryString("action")="AdminSuc" then
	info = request.QueryString("info")
	call AdminSuc()
End if
If request.QueryString("action")="stop" then
	call stop_info()
End if
If request.QueryString("action")="Err_info" then
	ErrMsg = request.QueryString("ErrMsg")
	call Err_info()
End if

Sub AdminSuc()
	response.Write("<link href=""admin_style.css"" rel=""stylesheet"" type=""text/css"">")
	Response.Write"<br>"
	Response.Write"<table width='97%' border='0' align='center' cellpadding='3' cellspacing='1' class='tableBorder'>"
	Response.Write"<tr align=center bordercolor='#FFFFFF'>"
	Response.Write"<td width=""100%"" class=""title"" height=25 colspan=2>成功信息"
	Response.Write"</td>"
	Response.Write"</tr>"
	Response.Write"<tr bordercolor='#FFFFFF'>"
	Response.Write"<td width=""100%"" class=""table"" colspan=2 height=25>"
	Response.Write Encode(info)
	Response.Write"</td></tr>"
	Response.Write"<tr bordercolor='#FFFFFF'>"
	Response.Write"<td class=""table"" valign=middle colspan=2 align=center><a href="&Request.ServerVariables("HTTP_REFERER")&" ><<返回上一页</a></td></tr>"
	Response.Write"</table>"
End Sub

Sub AdminErr()
	response.Write("<link href=""admin_style.css"" rel=""stylesheet"" type=""text/css"">")
	Response.Write"<br>"
	Response.Write"<table width='97%' border='0' align='center' cellpadding='3' cellspacing='1' class='tableBorder'>"
	Response.Write"<tr align=center bordercolor='#FFFFFF'>"
	Response.Write"<td width=""100%"" class=""title"" height=25 colspan=2>错误信息"
	Response.Write"</td>"
	Response.Write"</tr>"
	Response.Write"<tr bordercolor='#FFFFFF'>"
	Response.Write"<td width=""100%"" class=""table"" colspan=2 height=25>"
	Response.Write Encode(ErrMsg)
	Response.Write"</td></tr>"
	Response.Write"<tr bordercolor='#FFFFFF'>"
	Response.Write"<td class=""table"" valign=middle colspan=2 align=center><a href=""javascript:history.go(-1)""><<返回上一页</a></td></tr>"
	Response.Write"</table>"
End Sub

Sub Err_info()
	response.Write("<title>"&Sailing.SiteSetting(0)&" - 错误信息</title>")
	response.Write(template.css)
	response.Write(replace(replace(template.error_info,"{$info}",Encode(ErrMsg)),"{$history}",Request.ServerVariables("HTTP_REFERER")))
End Sub

Sub stop_info()
	response.Write("<title>"&Sailing.SiteSetting(0)&" - 暂停服务</title>")
	response.Write(template.css)
	response.Write(replace(template.stop_info,"{$info}",Sailing.SiteSetting(6)))
	if Sailing.SiteSetting(5) = 0 then
		response.Redirect("index.asp")
	end if
End sub
Function Encode(content)
	dim tmp
	tmp = content
	tmp = replace(tmp,"<script>","&lt;script&gt;")
	tmp = replace(tmp,"</script>","&lt;/script&gt;")
	tmp = replace(tmp,"<iframe>","&lt;iframe&gt;")
	tmp = replace(tmp,"</iframe>","&lt;/iframe&gt;")
	tmp = replace(tmp,"<meta","&lt;meta")
	Encode = tmp
End Function
%>