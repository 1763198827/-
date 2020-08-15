<%
If Session("IsAdmin")<>1 then Response.Redirect("Admin_login.asp")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title> 控制面版</title>
<link href="admin_style.css" rel="stylesheet" type="text/css">
<meta name="keywords" content=",">
</head>
<frameset rows='*' id='M_Frame' cols='185,*' framespacing='0' frameborder='no' border='0'>
<frame src='admin_menu.asp' scrolling='auto' id='leftFrame' name='leftFrame' noresize marginwidth='5' marginheight='5'>
<frame src='admin_main.asp' name='mainFrame' id='mainFrame' scrolling='auto' noresize marginwidth='0' marginheight='0'></frameset><noframes></noframes>
</html>
<script>
if(self!=top){top.location=self.location;}
</script>
