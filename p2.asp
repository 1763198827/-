<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
Set UlI=Server.CreateObject("SoftArtisans.FileUp")
FSPath=GetFilePath(Server.mappath("upfile.asp"),"\")'取得当前文件在服务器路径
FSPath=FSPath&UpFlo
path = FSPath
UlI.SaveAs path&GetNewFileName()&"."&File(Item)

Public Function GetNewFileName()
	dim ranNum
	dim dtNow
	dtNow=Now()
	ranNum=int(90000*rnd)+10000
	'以下这段由webboy提供
	GetNewFileName=year(dtNow) & right("0" & month(dtNow),2) & right("0" & day(dtNow),2) & right("0" & hour(dtNow),2) & right("0" & minute(dtNow),2) & right("0" & second(dtNow),2) & ranNum
End Function

%>
