<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login page</title>
</head>
<body>
<form method="get" action="/app/info">
	아이디: <input type=text name=userid><br>
	비밀번호: <input type=text name=userpw><br><br>
 <input type=submit value="확인"></form>
<form method="get" action="/app/">
<input type=submit value="취소">
</form>

<table border=1>
<%
	int k=1;
	for(int i=0;i<5;i++){
		out.println("<tr>");
		for(int j=0;j<4;j++){
			out.println("<td align=center>"+k+"</td>");
			k++;
		}
		out.print("</tr>");
	}
%>
<%
	for(int i=0;i<5;i++){
%>
<td align=center><%=k %></td>
<%
			k++;
	}
	out.println("</tr>");
%>
</table>
</body>
</html>