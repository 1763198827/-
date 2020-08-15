<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Class Cls_Database
	      Public Conn,Db,Connstr
		  Public Sub LoadData()
		  Db="Data/data.mdb"
		  Connstr="Provider=Microsoft.Jet.Oledb.4.0;Data Source="&Server.MapPath(db)
		  End Sub
		  Public Sub Connect()
    	      Set Conn=Server.CreateObject("Adodb.Connection")
			  Conn.Open Connstr
		  End Sub
		  Public Function Execute(Sql)
		  Set Rs=Server.CreateObject("Adodb.Recordset")
		      If Isobject(Conn)=false then
			     Connect()
				 Rs.Open Sql,conn,1,3
				 Else
				 'response.write sql
				  ' response.Flush()
				 'response.End()
				 Rs.Open Sql,conn,1,3
			  End If
			  Set Execute=Rs
		  End Function
		  Public Sub Disconnect()
		      Conn.Close
			  Set Conn=Nothing
		  End Sub
		  
		  
'起航内核
	Public Program_Version,software,Script_version,Http_version,ServerName,ServerIP,Path,URL,Database,DataTimes
	Public IsAdmin,Admin_name,Admin_type,P_Admin
	Public Browser,version,platform,IsSearch
	Public SiteSetting(37),Up_Max,re
Private Sub Class_Initialize()
		Startime=Timer()
		Program_Version = "5.0 SP1"
		software = request.ServerVariables("SERVER_Software")
		Script_version = ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion
		Http_version = request.ServerVariables("SERVER_Protocol")
		ServerName = request.ServerVariables("Server_Name")
		ServerIP = request.ServerVariables("Local_Addr")
		Path = request.ServerVariables("APPL_PHYSICAL_PATH")
		Dim Tmpstr,i,ScriptName
		Tmpstr = Request.ServerVariables("PATH_INFO")
		Tmpstr = Split(Tmpstr,"/")
		i = UBound(Tmpstr)
		ScriptName = Lcase(Tmpstr(i))
		URL = replace(Request.ServerVariables("PATH_INFO"),ScriptName,"")
		P_Admin=False
		If InStr(ScriptName,"showerr")>0 Or InStr(ScriptName,"admin_")>0 Then P_Admin=True
		Database = "Access"
		DataTimes = 0
		OnlineTime=20
		Set re = New RegExp
		re.IgnoreCase =True
		re.Global=True		
		System_chk()
	End Sub	
	Sub System_chk()
		Dim Agent,Tmpstr
		IsSearch = False
		Browser="unknown"
		version="unknown"
		platform="unknown"
		Agent=Request.ServerVariables("HTTP_USER_AGENT")
		'Agent="Opera/7.23 (X11; Linux i686; U)  [en]"	
		If Left(Agent,7) ="Mozilla" Then '有此标识为浏览器
			Agent=Split(Agent,";")
			If InStr(Agent(1),"MSIE")>0 Then
				Browser="MS IE "
				version=Trim(Left(Replace(Agent(1),"MSIE",""),6))
			ElseIf InStr(Agent(4),"Netscape")>0 Then 
				Browser="Netscape "
				tmpstr=Split(Agent(4),"/")
				version=tmpstr(UBound(tmpstr))
			ElseIf InStr(Agent(4),"rv:")>0 Then
				Browser="Mozilla "
				tmpstr=Split(Agent(4),":")
				version=tmpstr(UBound(tmpstr))
				If InStr(version,")") > 0 Then 
					tmpstr=Split(version,")")
					version=tmpstr(0)
				End If
			End If
		If InStr(Agent(2),"NT 5.2")>0 Then
					platform="Windows 2003"
			ElseIf InStr(Agent(2),"Windows CE")>0 Then
				platform="Windows CE"
			ElseIf InStr(Agent(2),"NT 5.1")>0 Then
				platform="Windows XP"
			ElseIf InStr(Agent(2),"NT 4.0")>0 Then
				platform="Windows NT"
			ElseIf InStr(Agent(2),"NT 5.0")>0 Then
				platform="Windows 2000"
			ElseIf InStr(Agent(2),"NT")>0 Then
				platform="Windows NT"
			ElseIf InStr(Agent(2),"9x")>0 Then
				platform="Windows ME"
			ElseIf InStr(Agent(2),"98")>0 Then
				platform="Windows 98"
			ElseIf InStr(Agent(2),"95")>0 Then
				platform="Windows 95"
			ElseIf InStr(Agent(2),"Win32")>0 Then
				platform="Win32"
			ElseIf InStr(Agent(2),"Linux")>0 Then
				platform="Linux"
			ElseIf InStr(Agent(2),"SunOS")>0 Then
				platform="SunOS"
			ElseIf InStr(Agent(2),"Mac")>0 Then
				platform="Mac"
			ElseIf UBound(Agent)>2 Then
				If InStr(Agent(3),"NT 5.1")>0 Then
					platform="Windows XP"
				End If 
				If InStr(Agent(3),"Linux")>0 Then
					platform="Linux"
				End If
			End If
			If InStr(Agent(2),"Windows")>0 And platform="unknown" Then
				platform="Windows"
			End If
		ElseIf Left(Agent,5) ="Opera" Then '有此标识为浏览器
			Agent=Split(Agent,"/")
			Browser="Mozilla "
			tmpstr=Split(Agent(1)," ")
			version=tmpstr(0)
			If InStr(Agent(1),"NT 5.2")>0 Then
				platform="Windows 2003"
			ElseIf InStr(Agent(1),"Windows CE")>0 Then
				platform="Windows CE"
			ElseIf InStr(Agent(1),"NT 5.1")>0 Then
				platform="Windows XP"
			ElseIf InStr(Agent(1),"NT 4.0")>0 Then
				platform="Windows NT"
			ElseIf InStr(Agent(1),"NT 5.0")>0 Then
				platform="Windows 2000"
			ElseIf InStr(Agent(1),"NT")>0 Then
				platform="Windows NT"
			ElseIf InStr(Agent(1),"9x")>0 Then
				platform="Windows ME"
			ElseIf InStr(Agent(1),"98")>0 Then
				platform="Windows 98"
			ElseIf InStr(Agent(1),"95")>0 Then
				platform="Windows 95"
			ElseIf InStr(Agent(1),"Win32")>0 Then
				platform="Win32"
			ElseIf InStr(Agent(1),"Linux")>0 Then
				platform="Linux"
			ElseIf InStr(Agent(1),"SunOS")>0 Then
				platform="SunOS"
			ElseIf InStr(Agent(1),"Mac")>0 Then
				platform="Mac"
			ElseIf UBound(Agent)>2 Then
				If InStr(Agent(3),"NT 5.1")>0 Then
					platform="Windows XP"
				End If 
				If InStr(Agent(3),"Linux")>0 Then
					platform="Linux"
				End If
			End If
		Else
			'识别搜索引擎
			Dim botlist,i
			Botlist="Google,Isaac,Webdup,SurveyBot,Baiduspider,ia_archiver,P.Arthur,FAST-WebCrawler,Java,Microsoft-ATL-Native,TurnitinBot,WebGather,Sleipnir"
			Botlist=split(Botlist,",")
			For i=0 to UBound(Botlist)
				If InStr(Agent,Botlist(i))>0  Then 
					platform=Botlist(i)&"搜索器"
					IsSearch=True
					Exit For
				End If
			Next 
		End If
	End sub	
		Public Sub Objects()
		dim installedObjects
		InstalledObjects = "Scripting.FileSystemObject"
		If IsObjInstalled(InstalledObjects) Then Response.Write "<font color=red><b>√</b>服务器支持!</font>" Else Response.Write "<b>×</b>服务器不支持!" 
	End Sub
		'以下为检查组件部分
	Function IsObjInstalled(strClassString)
		On Error Resume Next
		IsObjInstalled = False
		Err = 0
		Dim xTestObj
		Set xTestObj = Server.CreateObject(strClassString)
		If Err = 0 Then IsObjInstalled = True
		If Err = -2147352567 Then IsObjInstalled = True
		Set xTestObj = Nothing
		Err = 0
	End Function
	'管理员验证
	Public Sub Admin()
		if Session("IsAdmin")=empty then Session("IsAdmin")=0
		if Session("IsAdmin")=1 then
			dim sql,rs
			sql = "select * from admin where username='"&Session("Admin_name")&"'"
			set rs = Execute(sql)
			if rs.eof and rs.bof then
				Session("IsAdmin")=0
                Session("Admin_type")=Empty
                Session("Admin_name")=Empty
                Session("Belong")=Empty
                Session("Shetuan")=Empty
			else
			
				IsAdmin=true
				Admin_name=Session("Admin_name")
				Admin_type=Session("Admin_type")
				Session.Timeout=20
			end if
		else
			IsAdmin=false
			Admin_name=Empty
			Admin_type=Empty
		end if
	End Sub
	Public Sub chkAdmin(flag)
		if flag = 1 then flag = "协会管理员"
		if flag = "downloads" then flag = "下载管理员"
		if flag = "article" then flag = "文章管理员"
		if flag = "super" then flag = "超级管理员"		
		if flag = "picture" then flag = "图片管理员"		
		if flag = "music" then flag = "音乐管理员"
		if Admin_type <> flag and Admin_type <> "超级管理员" then
			ErrMsg="<li> 您没有相关管理权限。"
			response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
			response.End()
		end if
	End Sub
	Public Function GetMenu()
		dim pop		
		pop = "<DIV class=menuskin id=popmenu onmouseover=clearhidemenu();highlightmenu(event,'on') onmouseout=highlightmenu(event,'off');dynamichide(event) style='Z-index:100'></DIV>"
		pop = pop &"<script Language=Javascript src='inc/pop.js'></script>"&vbnewline
		pop = pop &"<script language=javascript>"&vbnewline
		'===========
		'文章菜单
		pop = pop &"linkset[0]=new Array()"&vbnewline
		Set rs_item = execute("Select * from item where type =1 order by id")
		dim i
		i = -1
		do while not rs_item.eof
			i=i+1
			pop = pop &"linkset[0]["&i&"]='<div class=menuitems><a href=article_list.asp?show="&rs_item(0)&">"&rs_item(1)&"</a></div>'"&vbnewline
		rs_item.movenext
		loop
		rs_item.close
		'===========
		'下载菜单
		pop = pop &"linkset[1]=new Array()"&vbnewline
		Set rs_item = execute("Select * from item where type =2 order by id")
		i = -1
		do while not rs_item.eof
			i=i+1
			pop = pop &"linkset[1]["&i&"]='<div class=menuitems><a href=downloads_list.asp?show="&rs_item(0)&">"&rs_item(1)&"</a></div>'"&vbnewline
		rs_item.movenext
		loop
		rs_item.close
		'===========
		'风格菜单
		dim x,y
		y = LCase(request.ServerVariables("QUERY_STRING"))		
		if y = "" then
			x = ""
		else
			if InStr(y,"skin") > 0 then
				x = replace(y,right(y,5+len(Skin)),"")
			else
				x = y & "&"
			end if
		end if
		pop = pop &"linkset[2]=new Array()"&vbnewline
		pop = pop &"linkset[2][0]='<div class=menuitems><a href=?"&x&"skin=0>恢复默认设置</a></div>'"&vbnewline
		Set rs_item = execute("Select * from style")
		i = 0
		do while not rs_item.eof
			i=i+1
			if Cint(Skin) = rs_item(0) then
				pop = pop &"linkset[2]["&i&"]='<div class=menuitems><a href=?"&x&"skin="&rs_item(0)&">├&nbsp;<font color=red>"&rs_item(1)&"</font></a></div>'"&vbnewline
			else
				pop = pop &"linkset[2]["&i&"]='<div class=menuitems><a href=?"&x&"skin="&rs_item(0)&">├&nbsp;"&rs_item(1)&"</a></div>'"&vbnewline
			end if
		rs_item.movenext
		loop
		rs_item.close		
		'===========
		'图片菜单
		pop = pop &"linkset[3]=new Array()"&vbnewline
		Set rs_item = execute("Select * from item where type =4 order by id")
		i = -1
		do while not rs_item.eof
			i=i+1
			pop = pop &"linkset[3]["&i&"]='<div class=menuitems><a href=pic_list.asp?show="&rs_item(0)&">"&rs_item(1)&"</a></div>'"&vbnewline
		rs_item.movenext
		loop
		rs_item.close
		'===========
		'音乐菜单
		pop = pop &"linkset[4]=new Array()"&vbnewline
		Set rs_item = execute("Select * from item where type =5 order by id")
		i = -1
		do while not rs_item.eof
			i=i+1
			pop = pop &"linkset[4]["&i&"]='<div class=menuitems><a href=music_list.asp?show="&rs_item(0)&">"&rs_item(1)&"</a></div>'"&vbnewline
		rs_item.movenext
		loop
		rs_item.close
		
		Dim sql,rs
		sql = "select * from menu where items=0 and shown=true order by order_num"
		set rs = Execute(sql)
		dim script,tmp,sql2,rs2
		j=4
		do while not rs.eof
			sql2 = "select * from menu where items="&rs(0)
			set rs2 = Execute(sql2)
			if rs2.bof and rs2.eof then
				if rs(0) = 5 then
				 	tmp = "<a href='"&rs(2)&"' target='"&rs(3)&"' title='"&rs(4)&"' onmouseover=showmenu(event,0,1,false) onmouseout=delayhidemenu()>"& rs(1) &"</a> | "
				elseif rs(0) =6 then
					tmp = "<a href='"&rs(2)&"' target='"&rs(3)&"' title='"&rs(4)&"' onmouseover=showmenu(event,1,1,false) onmouseout=delayhidemenu()>"& rs(1) &"</a> | "
				elseif rs(0) =10 then
					tmp = "<a title='"&rs(4)&"' onmouseover=showmenu(event,2,1,false) onmouseout=delayhidemenu()>"& rs(1) &"</a> | "
				elseif rs(0) =7 then
					tmp = "<a href='"&rs(2)&"' target='"&rs(3)&"' title='"&rs(4)&"' onmouseover=showmenu(event,3,1,false) onmouseout=delayhidemenu()>"& rs(1) &"</a> | "
				elseif rs(0) =8 then
					tmp = "<a href='"&rs(2)&"' target='"&rs(3)&"' title='"&rs(4)&"' onmouseover=showmenu(event,4,1,false) onmouseout=delayhidemenu()>"& rs(1) &"</a> | "
				else
					tmp = "<a href='"&rs(2)&"' target='"&rs(3)&"' title='"&rs(4)&"'>"& rs(1) &"</a> | "
				end if
				j=j
			else
				j=j+1
				id=j
				pop = pop &"linkset["&j&"]=new Array()"&vbnewline
				Set rs_item = Execute("Select * from menu where items="&rs(0))
				i = -1
				do while not rs_item.eof
					i=i+1
					pop = pop &"linkset["&j&"]["&i&"]='<div class=menuitems><a href="&rs_item(2)&" target="&rs_item(3)&" title="&rs_item(4)&">"&rs_item(1)&"</a></div>'"&vbnewline
				rs_item.movenext
				loop
				rs_item.close
				tmp = "<a href='"&rs(2)&"' target='"&rs(3)&"' title='"&rs(4)&"' onmouseover=showmenu(event,"&id&",1,false) onmouseout=delayhidemenu()>"& rs(1) &"</a> | "
			end if
			rs2.close
			script = script & tmp
		rs.movenext
		loop
		rs.close
		response.Write pop &"</script>"
		Getmenu = Left(script,len(script)-3)
	End function	
	Property Get Get_Url()
		If request.servervariables("SERVER_PORT")="80" Then
			Get_Url="http://" & request.servervariables("server_name")&URL
		Else
			Get_Url="http://" & request.servervariables("server_name")&":"&request.servervariables("SERVER_PORT")&URL
		End If
	End Property
	Public Function ChangeEmot(content)
		dim i,j
		For i = 1 to 49
			j = i
			if len(i) = 1 then j = 0&i
			content = replace(content,"[em"&j&"]","<img src=images/post/emot/em"&j&".gif>")
		Next
		ChangeEmot = content
	End Function
	Public Function Lenth(content)
		dim lent
		lent = 18
		if len(content) > lent then
			content = left(content,lent-1) &"..."
		End if
		Lenth = content
	End Function
	
	
	End Class
	Set Data=New Cls_Database	
	Data.LoadData
	%>
