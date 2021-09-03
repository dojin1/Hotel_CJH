<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약관리</title>
</head>
<%-- <%
	String loginid=(String)session.getAttribute("loginid");
	if(!loginid.equals("juno")){
		response.sendRedirect("/app/login");
	}
%> --%>
<body>
 <div class="0" style="float: left;">
    <a href='/app/booking' id="roomReserve">예약관리</a>
    <a href='/app/room' id="roomControl">객실관리</a>
    <a href='/app/logout'>로그아웃</a>
<table style="border:1px solid;">
    <td>숙박기간 <input type="date">~<input type="date"><br>
        객실분류  <select name="classroom" id="classroom">
            <option>Single Room</option>
            <option>Double Room</option>
            <option>Suite Room</option>
            <option>Family Room</option></select><br>
<input type="button" value="예약가능 객실"><br>
<select size=10 style='width:250px;' id=possible>
    <option>백두산 Single Room 3 100000 </option>
    <option>한라산</option>
    <option>금강산</option>
    <option>내장산</option>
</select><br><br>
    </td>
</table><br>
</div>
<br>
<div class="2" style="float: left; margin-left: 50px;">
<table style="border:1px solid;">
<td>객실이름&nbsp; <input type="text" name=room ><br><br>
객실종류&nbsp; <input type="text"><br><br>
예약인원&nbsp; <input type="number" min="1">명<br><br>
최대인원&nbsp; <input type="text">원<br><br>
예약기관&nbsp; <input type="date">~<input type="date"><br><br>
예약자명   <input type="text"><br><br>
모바일번호 <input type="text"><br><br>
<input type="button" value="예약완료" style="width: 80px;">
<input type="button" value="비우기" style="width: 80px;" >
<input type="button" value="예약취소" style="width: 80px;">
	</td>
</table>
</div>
<div class="3" style="float:left; margin-left: 50px;">
<table style="border:1px solid;">
<td>
	<input type="button" value="예약된 객실"><br>
    <select size=10 style='width:250px;' id=impossible>
        <option>강천산</option>
        <option>태조산</option>
        <option>광덕산</option>
    </select>
</td>
</div>


</body>
</html>