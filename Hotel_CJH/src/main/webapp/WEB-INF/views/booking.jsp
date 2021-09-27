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
   .tg  {border-collapse:collapse;border-color:#aabcfe;border-spacing:0;}
   .tg td{background-color:#FFE6EB;border-color:#aabcfe;border-style:solid;border-width:1px;color:#669;
     font-size:20px;overflow:hidden;word-break:normal;text-align: center;}
   .tg th{background-color:#b9c9fe;border-color:#aabcfe;border-style:solid;border-width:1px;color:#039;
     font-size:35px;font-weight:normal;overflow:hidden;word-break:normal;text-align: center;}
   .tg .tg-hmp3{background-color:#FFE6EB;vertical-align : middle;}
   .tg .tg-0lax{vertical-align : middle;}
</style>
<body>
 <div class="0">
    <a style="color:Red; margin-left:120px;" id="roomReserve">예약관리</a>
    <a href='/app/room' id="roomControl">객실관리</a>
    <a href='/app/logout'>로그아웃</a><br><br>
   <table class="tg" style="undefined;table-layout: fixed; width: 446px">
   <colgroup>
   <col style="width: 350px">
   <col style="width: 350px">
   <col style="width: 430px">
   </colgroup>
   <thead>
     <tr>
       <th class="tg-0lax" style="height: 70px; background-color:#657b83; color:white;">객실 조회</th>
       <th class="tg-0lax" style="background-color:#657b83; color:white;">예약관리</th>
       <th class="tg-0lax" style="background-color:#657b83; color:white;" >예약된 객실</th>
     </tr>
   </thead>
   <tbody>
     <tr>
       <td class="tg-0lax" style="height: 300px">
          <span style="font-weight:bold;">숙박기간</span><br>
          Check in &ensp;<input type="date" id=checkin style="width: 200px; height:30px"><br>
          Check out <input type="date" id=checkout style="width: 200px; height:30px"><br><br>
          <span style="font-weight:bold;">객실분류</span><br>
           <select name="classroom" id="classRoom" style="width: 200px; height:30px">
               <option value='all'>전체</option>
                <c:forEach items="${roomtype}" var="type">
            <option value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
              </c:forEach>
             </select>
         <input type="button" value="조회" id=roomSearch style="color:#DB631F;">
       </td>
       <td class="tg-hmp3" rowspan="2" style="height: 600px; line-height:100%;">
          <lable style="font-weight:bold;">객실이름</lable>&nbsp;&nbsp;
          <input type="text" name=room id=txtName style="width: 200px; height:30px" readonly><input type=hidden id=bookcode><input type=hidden id=roomcode><br><br>
         <lable style="font-weight:bold;">객실종류</lable>&nbsp;&nbsp;
         <select size=1 style="width: 200px; height:30px" id=txtType>
            <c:forEach items="${roomtype}" var="type" >
               <option  disabled="disabled" value='${type.typecode}'>${type.name}</option> <!-- val하면 value값 text()=${type.name}값을 가져옴 -->
            </c:forEach>
         </select><br><br>
         <lable style="font-weight:bold;">숙박인원</lable>&nbsp;&nbsp;
         <input type="number" min="1" dafault=1 id=txtNum style="width: 180px; height:30px">명<br><br>
         <lable style="font-weight:bold;">최대인원</lable>&nbsp;&nbsp;
         <input type="number" min="1" dafault=1 id=maxNum style="width: 180px; height:30px" readonly>명<br><br>
         <lable style="font-weight:bold;">숙박기간</lable>&nbsp;&nbsp;
         <input type="date" id=checkin1 style="width: 200px; height:30px" readonly><br>
         &emsp;&emsp;&emsp;&ensp;~ <input type="date" id=checkout1 style="width: 200px; height:30px" readonly><br><br>
         <lable style="font-weight:bold;">1박요금</lable>&nbsp;&nbsp;
         <input type="number" min="1" dafault=1  id=txtPay style="width: 180px; height:30px" readonly>원<br><br>
         <lable style="font-weight:bold;">총숙박비</lable>&nbsp;
         <input type="number" id=price style="width: 180px; height:30px" readonly>원<br><br>
         <lable style="font-weight:bold;">예약자명</lable>&nbsp;&nbsp;
         <input type="text" style="width: 200px; height:30px" id=txtSub><br><br>
         <lable style="font-weight:bold;">전화번호</lable>&nbsp;&nbsp;
         <input type="text" style="width: 200px; height:30px" id=txtMobile><br><br>
         
         <input type="button" value="예약완료" style="width: 100px; color:#0000FF;" id=btnAdd>
         <input type="button" value="비우기" style="width: 100px;" id=btnEmpty>
         <input type="button" value="예약취소" style="width: 100px; color:#CD1039;" id=btncancel>
       </td>
       <td class="tg-0lax" rowspan="2" style="height: 600px">
          <select size=10 style='width:650px; height:600px; background-color: #FFE6EB;' id=falseRoom onchange="getInfo(this.value)">
          </select>
       </td>
     </tr>
     <tr>
       <td class="tg-0lax" style="height: 300px">
          <span style="font-weight:bold;">예약가능 객실</span><br>
         <select size=10 style='width:340px; height:250px; background-color: #FFE6EB;' id=trueRoom>
         </select>
      </td>
     </tr>
   </tbody>
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
	$('#falseRoom option').prop('selected',false);
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
	$('select option').prop('selected',false);
	return false;
})

.on('click','#btncancel',function(){
	$.post('http://localhost:8079/app/deleteBook',{bookcode:$('#bookcode').val()},
	      function(result){
	      console.log(result);
	      if(result=="ok"){
	    	  $('#falseRoom option:selected').remove(); //room리스트에서 제거.
	    	  $('#btnEmpty').trigger('click'); //입력란 비우기.
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
	$('#trueRoom option').prop('selected',false);
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