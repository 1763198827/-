<!--#include file="CONN.asp"-->
<%
Data.Admin()
If Data.IsAdmin=false then
	ErrMsg="<li> 您没有登陆或不是管理员。请<a href='admin_login.asp' target='_top'>登陆</a>。"
	response.Redirect("showerr.asp?action=AdminErr&ErrMsg="&ErrMsg&"")
	response.End()
end if
%>
<link href="admin_style.css" rel="stylesheet" type="text/css">
<style type=text/css>
body  { background:#799AE1; font:Verdana 12px; 
SCROLLBAR-FACE-COLOR: #799AE1; SCROLLBAR-HIGHLIGHT-COLOR: #799AE1; 
SCROLLBAR-SHADOW-COLOR: #799AE1; SCROLLBAR-DARKSHADOW-COLOR: #799AE1; 
SCROLLBAR-3DLIGHT-COLOR: #799AE1; SCROLLBAR-ARROW-COLOR: #FFFFFF;
SCROLLBAR-TRACK-COLOR: #AABFEC;
}
table  { border:0px; }
td  { font:normal 12px 宋体;}
img  { vertical-align:bottom; border:0px; }
a  { font:normal 12px 宋体; color:#000000; text-decoration:none; }
a:hover  { color:#428EFF;text-decoration:underline; }
.sec_menu  { border-left:1px solid white; border-right:1px solid white; border-bottom:1px solid white; overflow:hidden; background:#D6DFF7; }
.menu_title  { }
.menu_title span  { position:relative; top:0px; left:8px; color:#000000; font-weight:bold; }
.menu_title2  { }
.menu_title2 span  { position:relative; top:0px; left:8px; color:#999999; font-weight:bold; }
</style>
<SCRIPT language=javascript1.2>
function showmenu_item(sid)
{
	which = eval("menu_item" + sid);
	if (which.style.display == "none")
	{
		var i = 1
		while(i<6){
			eval("menu_item"+ i +".style.display=\"none\";");
			eval("menuTitle"+ i +".background=\"images/manage/title_bg_show.gif\";");
			i++;
		}
		eval("menu_item" + sid + ".style.display=\"\";");
		eval("menuTitle"+ sid + ".background=\"images/manage/title_bg_hide.gif\";")
	}else{
		eval("menu_item" + sid + ".style.display=\"none\";");
		eval("menuTitle"+ sid + ".background=\"images/manage/title_bg_show.gif\";")
	}
}
</SCRIPT>
  <table width="158" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="158" height="38" background="images/manage/title.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="151" height="16"></td>
        </tr>
        <tr>
          <td><div align="center"><font color="#FFFFFF"><strong>控制面版</strong></font></div></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      
    <td height="25" class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background=images/manage/title_bg_quit.gif bgcolor="#7898E0"><span>&nbsp;<a href="index.asp" target="_top"><strong>管理首页</strong></a> 
      | <a href="admin_logout.asp" target="_top"><strong>退出</strong></a></span></td>
    </tr>
  </table>
  <br>
  <table cellpadding=0 cellspacing=0 width=158>
    <tr>
      
    <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/manage/title_bg_show.gif" id=menuTitle1 onclick="showmenu_item(1)"><span>基本设置</span> 
    </td>
    </tr>
    <tr>
      <td style="display:none;" id='menu_item1'><div class=sec_menu style="width:158">
          <table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="4"></td>
            </tr>
            <tr>
              <td height="20"><img src="images/manage/bullet.gif" alt width="15" height="20" border="0" align="absmiddle"><a href="admin_admin.asp" target="mainFrame">修改密码</a></td>
            </tr>
            
          </table>
      </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=135>
              <tr>
                <td height=20></td>
              </tr>
            </table>
        </div></td>
    </tr>
  </table>
      <table cellpadding=0 cellspacing=0 width=158>
        <tr>
          
    <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/manage/title_bg_show.gif" id=menuTitle2 onclick="showmenu_item(2)"><span>住户资料管理</span> 
    </td>
        </tr>
        <tr>
          <td style="display:none" id='menu_item2'><div class=sec_menu style="width:158">
              <table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="4"></td>
                </tr>
                <tr>
                  <td height="20"><img src="images/manage/bullet.gif" alt width="15" height="20" border="0" align="absmiddle"><a href="admin_client.asp" target="mainFrame">添加</a> | <a href="admin_client.asp?action=admin" target="mainFrame">管理</a></td>
                </tr>
              </table>
          </div>
              <div  style="width:158">
                <table cellpadding=0 cellspacing=0 align=center width=135>
                  <tr>
                    <td height=20></td>
                  </tr>
                </table>
            </div></td>
        </tr>
      </table>
      <table cellpadding=0 cellspacing=0 width=158>
        <tr>
          
    <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/manage/title_bg_show.gif" id=menuTitle3 onclick="showmenu_item(3)"><span>投诉管理</span> 
    </td>
        </tr>
        <tr>
          <td style="display:none" id='menu_item3'><div class=sec_menu style="width:158">
              <table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="4"></td>
                </tr>
				<%
				If Session("Level")=0 and Session("Level")<>"" then
				%>
                <tr>
                  <td height="20"><img src="images/manage/bullet.gif" alt width="15" height="20" border="0" align="absmiddle"><a href="admin_toushu.asp" target="mainFrame">投诉添加</a> | <a href="admin_toushu.asp?action=admin" target="mainFrame">管理</a></td>
                </tr>
				<%
				Else
				%>
				<tr>
                  <td height="20">&nbsp;</td>
                </tr>
				<%End If%>
              </table>
          </div>
              <div  style="width:158">
                <table cellpadding=0 cellspacing=0 align=center width=135>
                  <tr>
                    <td height=20></td>
                  </tr>
                </table>
            </div></td>
        </tr>
      </table>
      <table cellpadding=0 cellspacing=0 width=158>
        <tr>
          
    <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/manage/title_bg_show.gif" id=menuTitle4 onclick="showmenu_item(4)"><span>报修管理</span> 
    </td>
        </tr>
        <tr>
          <td style="display:none" id='menu_item4'><div class=sec_menu style="width:158">
              <table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="4"></td>
                </tr>
                <tr>
                  <td height="20"><img src="images/manage/bullet.gif" width="15" height="20" align="absmiddle"><a href="admin_repair.asp" target="mainFrame">报修添加</a> | <a href="admin_repair.asp?action=admin" target="mainFrame">管理</a></td>
                </tr>
                <tr>
                  <td height="20">&nbsp;</td>
                </tr>
              </table>
          </div>
              <div  style="width:158">
                <table cellpadding=0 cellspacing=0 align=center width=135>
                  <tr>
                    <td height=20></td>
                  </tr>
                </table>
            </div></td>
        </tr>
      </table>
      <table cellpadding=0 cellspacing=0 width=158>
        <tr>
          
    <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/manage/title_bg_show.gif" id=menuTitle5 onclick="showmenu_item(5)"><span>缴费管理</span> 
    </td>
        </tr>
        <tr>
          <td style="display:none" id='menu_item5'><div class=sec_menu style="width:158">
              <table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="4"></td>
                </tr>
                <tr>
                  <td height="20"><img src="images/manage/bullet.gif" width="15" height="20" align="absmiddle"> <a href="admin_datamoney.asp" target="mainFrame">缴费添加</a>| <a href="admin_datamoney.asp?action=admin" target="mainFrame">管理</a> </td>
                </tr>
                <tr>
                  <td height="20">&nbsp;</td>
                </tr>
              </table>
            </div>
              <div  style="width:158">
                <table cellpadding=0 cellspacing=0 align=center width=135>
                  <tr>
                    <td height=20></td>
                  </tr>
                </table>
            </div></td>
        </tr>
      </table>
      
	  <table cellpadding=0 cellspacing=0 width=158>
        <tr>
          
    <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/manage/title_bg_show.gif" id=menuTitle15 onclick="showmenu_item(15)"><span>停车车位管理</span> 
    </td>
        </tr>
        <tr>
          <td style="display:none" id='menu_item15'><div class=sec_menu style="width:158">
              <table width="97%"  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="4"></td>
                </tr>
                <tr>
                  <td height="20"><img src="images/manage/bullet.gif" width="15" height="20" align="absmiddle"> <a href="admin_park.asp" target="mainFrame">添加</a>| <a href="admin_park.asp?action=admin" target="mainFrame">管理</a> </td>
                </tr>
                <tr>
                  <td height="20">&nbsp;</td>
                </tr>
              </table>
            </div>
              <div  style="width:158">
                <table cellpadding=0 cellspacing=0 align=center width=135>
                  <tr>
                    <td height=20></td>
                  </tr>
                </table>
            </div></td>
        </tr>
      </table>
	  
	  
	  
	  <br>            
