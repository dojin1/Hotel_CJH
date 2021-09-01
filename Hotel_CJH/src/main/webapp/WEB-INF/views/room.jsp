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
<select size=10 style='width:250px;' id=selRoom>
	<c:forEach items="${list}" var="room">
   		<option value= ${room.roomcode}>${room.roomname},${room.typename},${room.howmany},${room.howmuch}</option>
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
객실이름&nbsp; <input type="text" name=roomname id=textName><input type=hidden id=roomcode><br><br>
객실분류
<select size=5 style='width:150px;' id=textType>
	<c:forEach items="${roomtype}" var="type">
		<option value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
	</c:forEach>
</select><br><br>
숙박인원&nbsp; <input type="number" min="1" id=textNum>명<br><br>

1박요금&nbsp; <input type="text" id=textPay>원<br><br>

<input type="button" value="등록" id=btnAdd style="width: 80px;">
<input type="button" value="취소" id=btnDelete style="width: 80px;" >
<input type="button" value="초기화" id=btnClear style="width: 80px;">

</div>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>
$(document)
.ready(function(){
	$.post("http://localhost:8079/app/getRoomList",{},function(result){
		
	})
})
$(document)
.on('click','#selRoom option',function(){
	let str=$(this).text();
	let ar=str.split(','); // ','를 기준으로 자름.
	$('#textName').val(ar[0]);
	$('#textType option:contains("'+ar[1]+'")').prop('selected',true);
	$('#textNum').val(ar[2]);
	$('#textPay').val(ar[3]);
	let code=$(this).val();
	$('#roomcode').val(code);
	return false;
})
.on('click','#btnClear',function(){
	$('#textName,#textType,#textNum,#textPay').val('');
	return false;
})
</script>
</html>