<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<html>
<head>
    <title>예약관리</title>
</head>
<style type="text/css">
    @import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
    body,input,select {
      font-family: 'Gowun Batang', serif; 
      }
    body{ 
       background-color: #F0F8FF;
    } 
   table {
       margin-left:auto; 
       margin-right:auto;
   }
   .tg  {border-collapse:collapse;border-color:#93a1a1;border-spacing:0;}
   .tg td{background-color:#F0F8FF;border-color:#93a1a1;border-style:solid;border-width:1px;color:#002b36;
      font-size:20px;overflow:hidden;padding:10px 5px;word-break:normal;}
   .tg th{background-color:#657b83;border-color:#93a1a1;border-style:solid;border-width:1px;color:#fdf6e3;
     font-size:35px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
   .tg .tg-5j00{background-color:#ffdcb1;border-color:#fff3cb;text-align:center;vertical-align:middle}
   .tg .tg-wgpo{background-color:#ffc899;border-color:#fff3cb;text-align:center;vertical-align:middle}
   .tg .tg-3nqb{background-color:#ffdcb1;border-color:#fff3cb;text-align:center;vertical-align:middle}
</style>
<body>
 <div class="0">
    <a href='/app/booking' style="margin-left:120px;" id="roomReserve">예약관리</a>
    <a style="color:Blue;" id="roomControl">객실관리</a>
    <a href='/app/logout'>로그아웃</a><br><br>
   <table class="tg" style="undefined;table-layout: fixed; width: 446px">
   <colgroup>
   <col style="width: 350px">
   <col style="width: 350px">
   <col style="width: 350px">
   </colgroup>
   <thead>
     <tr>
       <th class="tg-0lax" style="height: 70px">객실목록</th>
       <th class="tg-0lax">객실관리</th>
     </tr>
   </thead>
   <tbody>
        <tr>
       <td class="tg-0lax" style="height: 300px">
         <select size=10 style='width:340px; height:280px; background-color: #F0F8FF;' id=selRoom>
         </select>
      </td>
      <td class="tg-0lax" style="height: 300px">
      
        객실이름&nbsp; <input type="text" name=roomname id=textName><input type=hidden id=roomcode><br><br>
   객실분류&nbsp; 
            <select size=1 style='width:150px;' id=textType>
               <c:forEach items="${roomtype}" var="type">
                  <option value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
               </c:forEach>
            </select><br><br>
   숙박인원&nbsp; <input type="number" min="1" id=textNum>명<br><br>

   일박요금&nbsp; <input type="text" id=textPay>원<br><br>
         <input type="button" value="등록" style="width: 100px; color:#0000FF;" id=btnAdd>
        <input type="button" value="비우기" style="width: 100px;" id=btnClear>
        <input type="button" value="삭제" style="width: 100px; color:#CD1039;" id=btnDelete>
      </td>

     </tr>
   </tbody>
   
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