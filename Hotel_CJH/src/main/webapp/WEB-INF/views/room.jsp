<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실관리</title>
</head>
 <style>
     @import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
     body,input,select {
       font-family: 'Gowun Batang', serif; 
       }
  </style>
<body>
<div class="1" style="float: left;">
    <a href='/app/booking' id="roomReserve">예약관리</a>
    <a href='/app/room' id="roomControl">객실관리</a>
    <a href='/app/logout'>로그아웃</a><br>
<table style="border:1px solid;">
<td>
<select size=10 style='width:250px;' id=selRoom>
</select><br><br>
<input type="button" id="btnlist" value="객실목록"><br>
<select id="roomlist" size="10" style='width:240px; height:250px;' >
    <option>백두산</option>
    <option>한라산</option>
    <option>금강산</option>
    <option>내장산</option>
</select><br><br>
</td>
</table>
</div>

<div class="2" style="float:left; margin-left: 100px; margin-top: 20px;">
<table style="border:1px solid;">
<td>
객실이름&nbsp; <input type="text" name=roomname id=textName><input type=hidden id=roomcode><br><br>
객실분류&nbsp; 
<select size=1 style='width:150px;' id=textType>
	<c:forEach items="${roomtype}" var="type">
		<option value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
	</c:forEach>
</select><br><br>
숙박인원&nbsp; <input type="number" min="1" id=textNum>명<br><br>

1박요금&nbsp; <input type="text" id=textPay>원<br><br>

<input type="button" value="등록" id=btnAdd style="width: 80px;">
<input type="button" value="삭제" id=btnDelete style="width: 80px;" >
<input type="button" value="초기화" id=btnClear style="width: 80px;">
</td>
</table>
</div>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>
$(document)
.ready(function(){
   $.post("http://localhost:8079/app/getRoomList",{},function(result){
      console.log(result);
      $.each(result,function(ndx,value) {
         str='<option value="'+value['roomcode']+'">'+value['roomname']+','+value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
         $('#selRoom').append(str);
      })
   },'json');
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
.on('click','#btnDelete',function(){
   $.post('http://localhost:8079/app/deleteRoom',{roomcode:$('#roomcode').val()},
         function(result){
      console.log(result);
      if(result=="ok"){
    	  $('#btnClear').trigger('click'); //입력란 비우기.
    	  $('#selRoom option:selected').remove(); //room리스트에서 제거.
      }
   },'text');
   return false;
})
.on('click','#btnAdd',function(){
	let roomname=$('#textName').val();
	let roomtype=$('#textType').val();
	let howmany=$('#textNum').val();
	let howmuch=$('#textPay').val();
	// validation (유효성검사)
	if( roomname=='' || roomtype=='' || howmany=='' || howmuch==''){
		alert('누락된 값이 있습니다.');
		return false;
	}
	let roomcode=$('#roomcode').val();
	if(roomcode==''){ // roomcode 에 값이없으면 insert 하는상황 
		$.post('http://localhost:8079/app/addRoom',{roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
					if(result=='ok'){
						location.reload();
					}
				},'text');
	} else { // roomcode에 값이 있으면 update. => 선택하면 roomcode값이 잡히기 때문.
		$.post('http://localhost:8079/app/updateRoom',{roomcode:roomcode,roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
					if(result=='ok'){
						location.reload();
					}
				},'text');
	}
	
/* 	$.post('http://localhost:8079/app/addRoom',{roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
	function(result){
		if(result=='ok'){
			location.reload();
		}
	},'text'); */
})
</script>
</html>