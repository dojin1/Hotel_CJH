<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약관리</title>
</head>
  <style>
     @import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
     body,input,select {
       font-family: 'Gowun Batang', serif; 
       }
  </style>
<body>
 <div class="0" style="float: left;">
    <a href='/app/booking' id="roomReserve">예약관리</a>
    <a href='/app/room' id="roomControl">객실관리</a>
    <a href='/app/logout'>로그아웃</a>
<table style="border:1px solid;">
    <td>
    	숙박기간 <input type="date" id=checkin>~<input type="date" id=checkout><br>
        객실분류  <select name="classroom" id="classRoom">
        <option value='all'>전체</option>
         		<c:forEach items="${roomtype}" var="type">
					<option value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
		  		</c:forEach>
            </select>
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
객실이름&nbsp; <input type="text" name=room id=txtName readonly><input type=hidden id=bookcode><input type=hidden id=roomcode><br><br>
객실종류&nbsp;
<select size=1 style='width:150px;' id=txtType>
	<c:forEach items="${roomtype}" var="type" >
		<option  disabled="disabled" value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
	</c:forEach>
</select><br><br>
숙박인원&nbsp; <input type="number" min="1" dafault=1 id=txtNum>명<br><br>
최대인원&nbsp; <input type="number" min="1" dafault=1 id=maxNum readonly>명<br><br>
숙박기간&nbsp; <input type="date" id=checkin1 readonly>~<input type="date" id=checkout1 readonly><br><br>
1박요금&nbsp; <input type="number" min="1" dafault=1  id=txtPay readonly>원<br><br>
총숙박비&nbsp; <input type="number" id=price readonly>원<br><br>
예약자명   <input type="text" id=txtSub><br><br>
모바일번호 <input type="text" id=txtMobile><br><br>

<input type="button" value="예약완료" style="width: 80px;" id=btnAdd>
<input type="button" value="비우기" style="width: 80px;" id=btnEmpty>
<input type="button" value="예약취소" style="width: 80px;" id=btncancel>
</td>
</table>
</div>
<div class="3" style="float:left; margin-left: 50px;">
<table style="border:1px solid;">
<td>
	<input type="button" value="예약된 객실" ><br>
    <select size=10 style='width:600px; height:350px;' id=falseRoom onchange="getInfo(this.value)">
    </select>
</td>
</table>
</div>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>
$(document)
.on('click','#roomSearch',function(){
	$('#trueRoom').empty();
	$('#falseRoom').empty();
	let checkin = $('#checkin').val(); 
	let checkout = $('#checkout').val();
	//예약가능객실
   $.post("http://localhost:8079/app/searchAbleRoom",{checkin:checkin,checkout:checkout},function(result){
	  $('#trueRoom').empty();
      //console.log(result);
      $.each(result,function(ndx,value) {
         str='<option value="'+value['roomcode']+'">'+value['roomname']+' '+value['typename']+' '+value['max_howmany']+' '+value['howmuch']+'</option>';
         $('#trueRoom').append(str);
      })
   },'json');
   
	//예약된객실
   $.post("http://localhost:8079/app/searchRoom",{checkin:checkin,checkout:checkout},function(result){
	   console.log(checkin,checkout);
	   $.each(result,function(ndx,value){
		   str='<option value="'+value['bookcode']+'" >'+value['roomname']+' '+value['typename']+' '+value['howmany']+' '+value['booker']+' '+value['mobile']+' '+'['+value['checkin']+' ~ '+value['checkout']+']</option>'+
		   '<option id="a'+value['bookcode']+'" style="display:none;" >'+value['roomname']+','+value['typename']+','+value['howmany']+','+value['max_howmany']+','+value['checkin']+','+value['checkout']+','+value['howmuch']+','+value['booker']+','+value['mobile']+','+value['bookcode']+'</option>';
		   $('#falseRoom').append(str);
	   })
   },'json');
})

.on('click','#trueRoom option',function(){
	$('#txtName,#txtType,#txtNum,#txtSub,#txtMobile,#price,#bookcode').val('');
	$('#roomcode').val($(this).val()); 
	let str=$(this).text();
	let ar=str.split(' '); // ','를 기준으로 자름.
	$('#txtName').val(ar[0]);
	$('#txtType option:contains("'+ar[1]+'")').prop('selected',true);
	$('#maxNum').val(ar[2]);
	$('#txtPay').val(ar[3]); //1박요금
	let code=$(this).val();
	$('#checkin1').val($('#checkin').val());
	$('#checkout1').val($('#checkout').val());
	$('#checkin1,#checkout1').trigger('change');
	return false;
})

.on('click','#btnEmpty',function(){
	$('#txtName,#txtType,#txtNum,#maxNum,#checkin1,#checkout1,#txtPay,#txtSub,#txtMobile,#price,#bookcode').val('');
	return false;
})

.on('click','#btncancel',function(){
	$.post('http://localhost:8079/app/deleteBook',{bookcode:$('#bookcode').val()},
	      function(result){
	      console.log(result);
	      if(result=="ok"){
	    	  $('#btnEmpty').trigger('click'); //입력란 비우기.
	    	  $('#falseRoom option:selected').remove(); //room리스트에서 제거.
	      }
	   },'text');
	   return false;
})

.on('click','#btnAdd',function(){
	if($('#txtName').val()==''){
		alert('객실을 선택해주세요')
	}
	if($('#txtNum').val()==''|| isNaN($('#txtNum').val())){
		alert('숙박인원 입력해주세요');
		return false;
	}
	if($('#maxNum').val()==''||isNaN($('#maxNum').val())){
		alert('총숙박(가능)인원이 입력되어야 합니다.')
		return false;
	}
	if($('#checkin1').val()=='' || $('#checkout1').val()==''){
		alert('숙박기간이 입력되어야 합니다.')
		return false;
	}
	if($('#txtPay').val()==''){
		alert('총숙박비가 입력되어야 합니다.')
		return false;
	}
	if($('#txtSub').val()==''){
		alert('예약자명이 입력되어야 합니다.')
		return false;
	}
	if($('#txtMobile').val()==''){
		alert('예약자의 연락처가 입력되어야 합니다.')
		return false;
	}
	if($('#txtNum').val()>$('#maxNum').val()){
		alert('숙박인원이 최대인원을 넘을순 없어요!')
		return false;
	}
	if($('#checkout1').val()<=$('#checkin1').val()){
		alert('체크아웃 날짜는 체크인날짜 이후로 정해주세요!')
		return false;
	}
	//console.log($('#roomCode').val(),$('#txtNum').val(),$('#checkin1').val(),$('#checkout1').val(),$('#txtPay').val(),$('#txtSub').val(),$('#txtMobile').val());
	
	let howmany=$('#txtNum').val();
	let booker=$('#txtSub').val();
	let mobile=$('#txtMobile').val();
	if(howmany=='' || booker=='' || mobile==''){
		alert('누락된 값이 있습니다.');
		return false;
	}
	let bookcode=$('#bookcode').val();
	if(bookcode==''){ //bookcode에 값이 없으면 insert..
		console.log($('#roomcode').val(),$('#txtNum').val(),$('#checkin1').val(),$('#checkout1').val(),$('#price').val(),$('#txtSub').val(),$('#txtMobile').val());
		$.post('http://localhost:8079/app/Reserve',
				{roomcode:$('#roomcode').val(),howmany:$('#txtNum').val(),
				checkin:$('#checkin1').val(),checkout:$('#checkout1').val(),
				total:$('#price').val(),booker:$('#txtSub').val(),
				 mobile:$('#txtMobile').val()},
				 function(result){
					if(result=='ok'){
						$('#roomSearch').trigger('click'); //트리거 방아쇠 클릭하면 실행
						$('#btnEmpty').trigger('click');
					} else{
						alert('예약이 완료되지 않았습니다.(DB오류)');
					}
		},'text');
	} else { //bookcode에 값이 있으면 update
		$.post('http://localhost:8079/app/updateBook',{bookcode:bookcode,howmany:howmany,booker:booker,mobile:mobile},
			function(result){
			if(result=='ok'){
				$('#roomSearch').trigger('click');
				$('#btnEmpty').trigger('click');
			}
		},'text');
	}
	
	return false;
})
.on('change','#checkin1,#checkout1',function(){
	let checkin=$('#checkin1').val();
	let checkout=$('#checkout1').val();
	if(checkin==''|| checkout=='') return false;
	checkin=new Date(checkin);
	checkout=new Date(checkout);
	if(checkin > checkout){
		alert('체크아웃 날짜는 체크인 날짜 이후로 선택해주세요!'); return false;
	}
	let ms=Math.abs(checkout-checkin);
	let days=Math.ceil(ms/(1000*60*60*24));
	let total=days*parseInt($('#txtPay').val());
	$('#price').val(total);
	return false;
})
function getInfo(num) {
	let str=$("#a"+num).text();
	let ar=str.split(','); // ','를 기준으로 자름.
	
	$('#txtName').val(ar[0]);
	$('#txtType option:contains("'+ar[1]+'")').prop('selected',true);
	$('#txtNum').val(ar[2]);
	$('#maxNum').val(ar[3]);
	$('#checkin1').val(ar[4]);
	$('#checkout1').val(ar[5]);
	$('#txtPay').val(ar[6]); //1박요금
	$('#txtSub').val(ar[7]);
	$('#txtMobile').val(ar[8]);
	
	$('#checkin1,#checkout1').trigger('change');
	
	$('#bookcode').val(ar[9]);
	console.log($('#bookcode').val());
	return false;
}
</script>
</html>