<!--#include file="CONN.ASP"-->
<!--#include file="inc/Char.asp"-->

<%Head()
Data.Admin()
If Data.IsAdmin=false then
	ErrMsg="<li> 您没有登陆或不是管理员。请<a href='admin_login.asp' target='_top'>登陆</a>。"
	response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
	response.End()
end if

if request.QueryString("action")="search" then
	dim word,engine
	word = request.Form("word")
	engine = request.Form("search")
	Select case engine
		case "3721"
			response.Redirect("http://cns.3721.com/cns.dll?name="&word)
			response.End()
		case "google"
			response.Redirect("http://www.google.com/search?q="&word&"&hl=zh-CN&lr=lang_zh-CN&ie=gb2312")
			response.End()
		case "baidu"
			response.Redirect("http://www.baidu.com/baidu?word="&word)
			response.End()
		case "sina"
			response.Redirect("http://search.sina.com.cn/cgi-bin/search/search.cgi?ss=sina&_searchkey="&word)
			response.End()
	end select
end if
	%>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

