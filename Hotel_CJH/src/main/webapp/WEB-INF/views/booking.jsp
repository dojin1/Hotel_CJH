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
    <td>
    	숙박기간 <input type="date" id=checkin>~<input type="date" id=checkout><br>
        객실분류  <select name="classroom" id="classroom">
            <option>Single Room</option>
            <option>Double Room</option>
            <option>Suite Room</option>
            <option>Family Room</option></select>
<input type="button" value="조회" id=roomSearch><br><br><br>
<input type="button" value="예약가능 객실" ><br>
<select size=10 style='width:365px; height:242px;' id=trueRoom>
</select><br><br>
 </td>
 </table>
</div>
<br>
<div class="2" style="float: left; margin-left: 50px;">
<table style="border:1px solid;">
<td>
객실이름&nbsp; <input type="text" name=room id=txtName><input type=hidden id=roomCode><br><br>
객실종류&nbsp;
<select size=1 style='width:150px;' id=txtType>
	<c:forEach items="${roomtype}" var="type">
		<option value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
	</c:forEach>
</select><br><br>
숙박인원&nbsp; <input type="number" min="1" id=txtNum>명<br><br>
최대인원&nbsp; <input type="number" min="1" id=maxNum>명<br><br>
숙박기간&nbsp; <input type="date" id=txtDate1>~<input type="date" id=txtDate2><br><br>
총숙박비&nbsp; <input type="text" id=txtPay>원<br><br><input type=hidden id=price>
예약자명   <input type="text" id=txtSub><br><br>
모바일번호 <input type="text" id=txtMobile><br><br>

<input type="button" value="예약완료" style="width: 80px;" id=btnAdd>
<input type="button" value="예약취소" style="width: 80px;" id=btncancel>
<input type="button" value="비우기" style="width: 80px;" id=btnEmpty>
</td>
</table>
</div>
<div class="3" style="float:left; margin-left: 50px;">
<table style="border:1px solid;">
<td>
	<input type="button" value="예약된 객실" ><br>
    <select size=10 style='width:600px; height:350px;' id=falseRoom>
    </select>
</td>
</table>
</div>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>
$(document)
.on('click','#roomSearch',function(){
   $.post("http://localhost:8079/app/getRoomList",{},function(result){
	  $('trueRoom').empty();
      console.log(result);
      $.each(result,function(ndx,value) {
         str='<option value="'+value['roomcode']+'">'+value['roomname']+','+value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
         $('#trueRoom').append(str);
      })
   },'json');
})
.on('click','#trueRoom option',function(){
	let str=$(this).text();
	let ar=str.split(','); // ','를 기준으로 자름.
	$('#txtName').val(ar[0]);
	$('#txtType option:contains("'+ar[1]+'")').prop('selected',true);
	$('#maxNum').val(ar[2]);
	$('#txtPay').val(ar[3]);
	let code=$(this).val();
	$('#txtDate1').val($('#checkin').val());
	$('#txtDate2').val($('#checkout').val());
	$('#roomCode').val(code);
	return false;
})
.on('click','#btnEmpty',function(){
	$('#txtName,#txtType,#txtNum,#maxNum,#txtDate1,#txtDate2,#txtPay,#txtSub,#txtMobile').val('');
	return false;
})
.on('click','#btnAdd',function(){

	
})
</script>
</html>