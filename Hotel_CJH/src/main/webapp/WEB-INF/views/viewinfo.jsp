<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login information</title>
</head>
<body>
<form method="get" action="/app/">
<p>로그인한 아이디: ${loginid}</p>
<p>비밀번호: ${loginpw}</p>
<input type="submit" value=돌아가기>
</form>
</body>
</html>