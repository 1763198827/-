<!--#include file="CONN.asp"-->
<!--#include file="inc/Md5.asp"-->
<!--#include file="inc/Char.asp"-->
<%
Head()
Data.Admin()
If Data.IsAdmin=false then
	ErrMsg="<li> 您没有登陆或不是管理员。请<a href='admin_login.asp' target='_top'>登陆</a>。"
	response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
	response.End()
end if

%>
  <%If Session("Level")=0 and Session("Level")<>"" Then%>
<table width="97%" border="0" align="center" cellpadding="3" cellspacing="1" class="tableBorder">
  <!--DWLayoutTable-->
    <tr>
      <td colspan="3" class="title"><div align="center" class="title"> 
        <div align="center">导航</div>
      </div></td>
  </tr>

    <tr>
      <td width="33%" class="items"><div align="center"><a href="admin_client.asp">添加住户</a></div></td>
      <td width="33%" class="items"><div align="center"><a href="admin_client.asp?action=admin">管理住户</a></div></td>
      <td width="33%">&nbsp;</td>
    </tr>

</table>
	<%
	End IF
	%>
<br>
<%
Select case request.QueryString("action")
	case "save" 		'保存新建
		call SaveSet()
	case "add"			'新建
		call add()
	case "admin"		'管理
		call admin()
	case "edit"			'修改
		call edit()
	case "SaveEdit"		'保存修改
		call SaveEdit()	
	case "del"			'删除
		call del()
	case else
		call add()
End Select
Footer()

sub SaveSet()
Data.chkAdmin(0)
	dim NewsTitle,article,txtSource,txtWriter
	Stname = replace(request.Form("Stname"),"'","''")
	StChairman = request.Form("StChairman")
	Stmanager = request.Form("Stmanager")
	StPassword = Request.Form("StPassword")
	StContect = Request.Form("Stcontect")
	StDepartment = Request.Form("StDepartment")
	StAbout=replace(request.Form("content"),"'","''")
	stIndate=replace(request.Form("indate"),"'","''")
	stRoomtype=replace(request.Form("roomtype"),"'","''")
	
	if Stname = "" then
		ErrMsg="<li> 名称不能为空，请填写住户名称"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		response.End()
	end if	
	Dim SaveSet,cmd
	cmd = "Insert into baseinfo(户主名称,联系电话,楼宇名称,楼层,房屋号,单元,备注,迁入日期,房型) Values('"&Stname&"','"&StDepartment&"','"&StChairman&"','"&Stmanager &"','"&StPassword&"','"&StContect&"','"&stAbout&"','"&stindate&"','"&stroomtype&"')"
	set SaveSet = Data.Execute (cmd)
	info="<li> 住户添加成功"	
	response.Redirect("showerr.asp?action=AdminSuc&info="&info&"")
	TempRs.Close	
	SaveSet.close
end Sub

sub SaveEdit()
	dim StName,StManager,id,StDepartment,StChairman,StContect
	id = replace(request.Form("id"),"'","''")
	Stname = replace(request.Form("Stname"),"'","''")
	StChairman = request.Form("StChairman")
	Stmanager = request.Form("Stmanager")
	StPassword = Request.Form("StPassword")
	StContect = Request.Form("Stcontect")
	StDepartment = Request.Form("StDepartment")
	StAbout=replace(request.Form("content"),"'","''")
	stIndate=replace(request.Form("indate"),"'","''")
	stRoomtype=replace(request.Form("roomtype"),"'","''")
	
	
	if Stname = "" then
		ErrMsg="<li> 名称不能为空，请填写住户名称"
		response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
		
	end if
	Dim SaveEdit,cmd
	
	cmd = "Update baseinfo set 户主名称='"&stname&"',房屋号='"&stPassword&"',备注='"&stAbout&"',迁入日期='"&stindate&"',房型='"&stroomtype&"',联系电话='"&StDepartment&"',楼宇名称='"&StChairman&"',楼层='"&Stmanager&"',单元='"&StContect&"' Where id = "&id&""
	response.write cmd
	
	
	set SaveEdit = Data.Execute (cmd)
	info="<li> 住户修改成功"
	response.Redirect("showerr.asp?action=AdminSuc&info="&info&"")	
	SaveEdit.close
end Sub

Sub del()
	dim id
	id = request.QueryString("id")
	dim del	
	Data.Execute("delete from baseinfo where id = "&id&"")

	info="<li> 住户删除成功"
	response.Redirect("showerr.asp?action=AdminSuc&info="&info&"")	
	del.close
end sub
sub add()
Data.chkAdmin(0)
%>
<table width="97%" border="0" align="center" cellpadding="3" cellspacing="1" class="tableBorder">
  <!--DWLayoutTable-->
<form action="admin_client.asp?action=save" method="post" onsubmit="javascript:submits();">
  <tr>
    <td height="19" colspan="2" class="title"><div align="center" class="title"> 新建住户信息</div></td>
  </tr>
  <tr>
    <td height="19" colspan="2" class="title2">&nbsp;用于添加住户，它将显示在首页上。</td>
  </tr>
  <tr>
    <td width="18%" height="22" class="table">户主名称</td>
    <td class="table"><input name="StName" type="text" size="40" class="lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' onblur='this.className="lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'></td>
  </tr>
  <tr>
    <td width="18%" height="22" class="table">&nbsp;联系电话</td>
    <td class="table"><input name="StDepartment" type="text" size="40" class="lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' onblur='this.className="lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'></td>
  </tr>
  <tr valign="top">
    <td height="22" class="table">&nbsp;楼宇名称</td>
    <td class="table"><input name="StChairman" type="text" size="40" class="lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' onblur='this.className="lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'></td>
  </tr>
  <tr valign="top">
    <td height="22" class="table">&nbsp;楼层</td>
    <td valign="top" class="table"><input name="Stmanager" type="text" class="lostfocus" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0">    </td>
  </tr>
    <tr>
    <td width="18%" height="22" class="table">&nbsp;房屋号</td>
    <td class="table"><input name="StPassword" type="text" size="40" class="lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' onblur='this.className="lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'></td>
  </tr>
  <tr valign="top">
    <td height="22" class="table">&nbsp;单元</td>
    <td class="table"><div align="left">
      <input name="StContect" type="text" class="lostfocus" id="" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0">
    </div></td>
  </tr>
    <tr>
    <td width="18%" height="22" class="table">&nbsp;迁入日期</td>
    <td class="table"><input name="indate" type="text" class="lostfocus" id="indate" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0"></td>
  </tr>
    <tr>
    <td width="18%" height="22" class="table">&nbsp;房型</td>
    <td class="table"><input name="roomtype" type="text" class="lostfocus" id="roomtype" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0"></td>
  </tr>
  
  
  
  <tr valign="top">
    <td height="370" class="table"><p align="left">&nbsp;备注</p></td>
    <td class="table">
	<!-- #include file = "edit.asp"--></td>
  </tr>
  <tr>
    <td height="27" colspan="4" class="table"><div align="center">
      <input type="submit" name="Submit" value="提交">
    </div></td>
  </tr>
</form>
</table>
<%End Sub

Sub admin()
If Session("Level")<>0 or Session("Level")="" then Response.Redirect("admin_client.asp?action=edit&id="&Session("Belong")&"")
%>

<br>
<table width="97%" border="0" align="center" cellpadding="3" cellspacing="1" class="tableBorder">
  <tr>
    <td colspan="9" class="title"><div align="center" class="title"> 修改住户列表</div></td>
  </tr>
  <tr>
    <td colspan="9" class="title2">&nbsp;选择您需要更改的住户。</td>
  </tr>
  <tr>
    <td width="6%" class="items">    <div align="center">序号</div></td>
    <td width="13%" class="items"><div align="center"><span class="Forumrow">&nbsp;户主名称</span></div></td>
    <td width="14%" class="items"><div align="center">楼宇名称</div></td>
    <td width="11%" class="items"><div align="center">房屋号</div></td>
    <td width="17%" class="items"><div align="center">迁入日期</div></td>
    <td width="17%" class="items"><div align="center">备注</div></td>
    <td width="16%" class="items"><div align="center">联系电话</div></td>

    <td width="6%" class="items"><div align="center">操作</div></td>
  </tr>
<%
'************分页部分*******************
'on error resume next
if request.querystring("page")="" then page=1:else:page=cint(request.querystring("page"))   '的到网址中的页数 page=?

set rs=Data.Execute("Select * from baseinfo order by id desc")

rs.pagesize=15 '每页显示的数量
if not rs.eof then
rs.AbsolutePage=page
end if
if page>rs.pagecount then
	response.Write("<tr>")
	response.Write("<td colspan='6'>")
	response.write "<center>当前还没有住户<center>"
	response.Write("</td>")
	response.Write("</tr>")
end if


for i=0 to rs.pagesize-1    '显示具体的数据内容了,i+(page*13-13)+1 这个解决分页后显示具体的编号
if rs.eof then exit for%>


<tr onmouseover=this.style.backgroundColor="#F2F2F2" onmouseout=this.style.backgroundColor=""  bgcolor="#FFFFFF">  
    <td><div align="center"><%=rs(0)%></div></td>
    <td>&nbsp;<a href="admin_client.asp?action=edit&id=<%=rs(0)%>"><%=rs("户主名称")%></a></td>
    <td><div align="center"><%=rs("楼宇名称")%>    </div></td>
    <td><div align="center"><%=rs("房屋号")%>    </div></td>
    <td><div align="center">
    <%=rs("迁入日期")%>    </div></td>
    <td><div align="center"><%=rs("备注")%>    </div></td>
    <td>&nbsp;<%=rs("联系电话")%></td>
    <td><div align="center"><a href="admin_client.asp?action=del&id=<%=rs(0)%>" onclick="{if(confirm('您确定要删除此住户吗?')){return true;}return false;}">删除</a></div></td>
  </tr>
  <%
  rs.movenext
	next%>
<tr>
  <td colspan="9" class="table"><div align="right">
 <% 
response.Write("分页： ")
if page>1 then response.write "[<A href='admin_client.asp?action=admin&page=1&item="&items&"'>首页</a>][<a href='admin_client.asp?action=admin&page=" & page-1 & "&item="&items&"'>上页</a>] ":else:response.write "[首页][上页] "
for i=1 to rs.pagecount
if i=page then response.write "<b><font color='#FF0000'>"& i & "</font></b> ":else:response.write "<A href='admin_client.asp?action=admin&page=" & i & "&item="&items&"'>" & i & "</a> "
next
if page<rs.pagecount then response.write "[<a href='admin_client.asp?action=admin&page=" & page+1 & "&item="&items&"'>下页</a>][<a href='admin_client.asp?action=admin&page=" & rs.pagecount & "&item="&items&"'>尾页</a>]":else:response.write "[下页][尾页] "
response.Write(" ["&page&"/"&rs.pagecount&"页]["&rs.pagesize&"条/页]")

rs.close         '关闭数据库
set rs=nothing
set link1=nothing
%>
  </div></td>
  </tr>
</table>
<%
End Sub

Sub edit
dim id,Edit_News
If Session("Level")=0 and Session("Level")<>"" Then
id = request.QueryString("id")
Else
Id=Session("Belong")
End If
set RS = Data.Execute("select * from baseinfo where id = "& id&"")
Edit_News = rs(6)
%>

<table width="97%" border="0" align="center" cellpadding="3" cellspacing="1" class="tableBorder">
<form action="admin_client.asp?action=SaveEdit" method="post" id="form_edit" name="form_edit" onsubmit="javascript:submits();">
  <tr>
    <td colspan="2" class="title"><div align="center" class="title"> 修改住户信息</div></td>
  </tr>
  <tr>
    <td colspan="2" class="title2">&nbsp;用于修改住户信息，它将更新原有住户。</td>
  </tr>
  <tr>
    <td width="18%" height="22" class="table">户主名称</td>
    <td colspan="2" class="table"><input name="StName" type="text" class="lostfocus" id="StName" onFocus='this.className="getfocus";this.gf="1"' onBlur='this.className="lostfocus";this.gf="0"' onMouseOver='this.className="getfocus"' onMouseOut='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0" value="<%=rs("户主名称")%>"></td>
  </tr>
  <tr>
    <td width="18%" height="22" class="table">&nbsp;联系电话</td>
    <td colspan="2" class="table"><input name="StDepartment" type="text" class="lostfocus" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"'size="40" gf="0" value="<%=rs("联系电话")%>"></td>
  </tr>
  <tr valign="top">
    <td height="22" class="table">&nbsp;楼宇名称</td>
    <td colspan="2" class="table"><input name="StChairman" type="text" class="lostfocus" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0" value="<%=rs("楼宇名称")%>"></td>
  </tr>
  <tr valign="top">
    <td height="22" class="table">&nbsp;楼层</td>
    <td colspan="2" valign="top" class="table"><input name="Stmanager" type="text" class="lostfocus" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0" value="<%=rs("楼层")%>">    </td>
  </tr>
    <tr>
    <td width="18%" height="22" class="table">&nbsp;房屋号</td>
    <td colspan="2" class="table"><input name="StPassword" type="text" class="lostfocus" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"'size="40" gf="0" value="<%=rs("房屋号")%>"></td>
  </tr>
  <tr valign="top">
    <td height="22" class="table">&nbsp;单元</td>
    <td colspan="2" class="table"><div align="left">
      <input name="StContect" type="text" class="lostfocus" id="" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0" value="<%=rs("单元")%>">
    </div></td>
  </tr>
    <tr>
    <td width="18%" height="22" class="table">&nbsp;迁入日期</td>
    <td colspan="2" class="table"><input name="indate" type="text" class="lostfocus" id="indate" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"'size="40" gf="0" value="<%=rs("迁入日期")%>"></td>
  </tr>
    <tr>
    <td width="18%" height="22" class="table">&nbsp;房型</td>
    <td colspan="2" class="table"><input name="roomtype" type="text" class="lostfocus" id="roomtype" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' size="40" gf="0" value="<%=rs("房型")%>">
      <input name="id" type="hidden" class="lostfocus" id="id" onFocus='this.className="getfocus";this.gf="1"' onBlur='this.className="lostfocus";this.gf="0"' onMouseOver='this.className="getfocus"' onMouseOut='if (this.gf=="0") this.className="lostfocus"' value="<%=id%>" size="40" gf="0"></td>
	
  </tr>
  <tr valign="top">
    <td class="table"><p align="left">&nbsp;说明</p></td>
    <td width="279" class="table"><input name="edit" id="edit" type="hidden" value="<%=Server.HTMLEncode(Edit_News)%>"></input>
	<!-- #include file = "edit.asp"-->
	  <script>
		IframeID.document.body.innerHTML=form_edit.edit.value;
	  </script></td>
	  
  </tr>
  <tr>
    <td colspan="3" class="table"><div align="center">
        <input type="submit" name="Submit" value="提交">
    </div></td>
  </tr>
</form>
</table>
<%
rs.close
End Sub%>
