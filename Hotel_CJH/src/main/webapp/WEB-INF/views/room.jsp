<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실관리</title>
</head>
<body>
<div class="1" style="float: left; margin-top: 10px;"  >
    <a href='/app/booking' id="roomReserve">예약관리</a>
    <a href='/app/room' id="roomControl">객실관리</a>
    <a href='/app/logout'>로그아웃</a><br>
<select size=10 style='width:250px;'>
	<c:forEach items="${list}" var="room">
   		<option>${room.roomcode},${room.roomname},${room.typename},${room.howmany},${room.howmuch}</option>
    </c:forEach>
</select><br>
<input type="button" id="btnlist" value="객실목록"><br>
<select id="roomselect" size="10">
    <option>백두산</option>
    <option>한라산</option>
    <option>금강산</option>
    <option>내장산</option>
</select><br><br>
</div>

<div class="2" style="float:left; margin-left: 100px;">
객실이름&nbsp; <input type="text" name=roomname ><br><br>
객실분류
<select size=5 style='width:150px;'>
	<c:forEach items="${roomtype}" var="type">
		<option>${type.typecode},${type.name}</option>
	</c:forEach>
</select><br><br>
숙박인원&nbsp; <input type="number" min="1">명<br><br>

1박요금&nbsp; <input type="text">원<br><br>

<input type="button" value="등록" id=btnAdd style="width: 80px;">
<input type="button" value="취소" id=btnDelete style="width: 80px;" >
<input type="button" value="초기화" id=btnClear style="width: 80px;">

</div>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>

</script>
</html>