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
   		<option>${room.roomcode},${room.name},${room.type},${room.howmany},${room.howmuch}</option>
    </c:forEach>
</select>
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
<select>
    <option>Single Room</option>
    <option>Double Room</option>
    <option>Suite Room</option>
    <option>Family Room</option>
</select><br><br>
숙박인원&nbsp; <input type="number" min="1">명<br><br>

1박요금&nbsp; <input type="text">원<br><br>

<input type="button" value="등록" style="width: 80px;">
<input type="button" value="취소" style="width: 80px;" >
<input type="button" value="초기화" style="width: 80px;">

</div>
</body>
</html>