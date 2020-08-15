<!--#include file="CONN.ASP" -->
<%
Session("IsAdmin")=0
Session("Admin_type")=Empty
Session("Admin_name")=Empty
Session("Belong")=Empty
Session("Shetuan")=Empty
Session("Level")=Empty
response.Redirect("index.asp")
%>
