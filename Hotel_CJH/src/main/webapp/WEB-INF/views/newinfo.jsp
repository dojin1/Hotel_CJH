<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>new information</title>
</head>
<body>
<form method="get" action="/app/">
<P>실명: ${realname}</P>
<p>아이디: ${loginid}</p>
<p>비밀번호: ${loginpw}</p>
<p>모바일: ${mobile}</p>
<input type="submit" value="돌아가기">
</form>
</body>
</html>