<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <style>

fieldset#member{
    text-align: center;
    margin-bottom: 6vh;
}

</style>
</head>
<body>
	<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
<div>
<article >
<h1>회원가입</h1>
<form  class="basic-form" name="frm" action="/member/join" method="post" onsubmit="return check();">
<fieldset id="member">
	<legend>기본인포</legend>
	<label>아이디</label> <input type="text" name="id" id="id" class="id"/> <br />
	<%-- <input type="button" value="아이디 중복확인" class="dup" onclick="winOpen();"> --%>
	<span id="id-message"></span><br>
	
	<label>비밀번호</label> <input type="password" name="passwd" id="passwd" class="passwd"> <br>
	<label>패스워드 중복확인</label> <input type="password" name="passwd2" id="passwd2"class="passwd2"/> <br>
	<span id="passwd-message"></span><br>
	
	<label>이름</label> <input type="text" name="name" id="name" class="name"/><br>
	<span id="name-message"></span><br>
	
	<label>나이</label> <input type="number" name="age" /><br>
	<label>이메일</label><input type="text" name="email" /> <br/>
	<label>이메일 중복확인</label><input type="text" name="email2" /> <br/>
	<label>성별</label><input id="G" type="radio" name="gender" value="남"/>남
			<input id="G" type="radio" name="gender" value="여"/>여<br>
	
</fieldset>

<fieldset id="member">
	<legend>옵션</legend>
	<label>휴대폰 번호</label> <input type="tel" name="mtel" /><br />
	<label>집전화 번호</label> <input type="tel" name="tel" />
</fieldset>
<input class="BB" type="submit" value="회원가입" />
<input class="BB" type="button" value="뒤로가기" onclick="history.back();"  />
</form>
</article>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
var isGoodId =false;
var isGoodPasswd = false;
$('#id').keyup(function () {
	var id = $(this).val();
	console.log(id);
	
	$.ajax({
		url: '/member/joinIdDupCheckJson',
		data: {id: id},
		success: function (data) {
			console.log(typeof data);
			console.log(data);
			
			idDupMessage(data);
		}
	});
});
function idDupMessage(isIdDup) {
	if (isIdDup) { // 중복 true
		$('span#id-message').html('마! 중복이다.').css('color', 'red');
		isGoodId=false;
	}else if(frm.id.value.length < 3){
		$('span#id-message').html('아이디는 세글자 이상 사용가능합니다.').css('color', 'red');
		isGoodId=false;
	} else { // 중복아님 false
		$('span#id-message').html('마! 괘안타 써라.').css('color', 'green');
		isGoodId = true;
	}
}


$('#passwd'&&'#passwd2').keyup(
	function passwdDupMessage() {
		if (frm.passwd.value == frm.passwd2.value) { // 중복 true
			$('span#passwd-message').html('마! 괘안타 써라.').css('color', 'green');
			isGoodPasswd = true;
		} else { // 중복아님 false
			$('span#passwd-message').html('마! 틀릿다!').css('color', 'red');
			isGoodPasswd=false;
		}
	});

$('#name').keyup(
function nameDupMessage() {
	if (frm.name.value.length<1) {
		$('span#name-message').html('이름 쓰세욜').css('color', 'red');
		isGoodName=false;
	} else { 
		$('span#name-message').html('잘했다잉').css('color', 'green');
		isGoodName = true;
	}
});
function check() {
	if(!isGoodId){
		frm.id.select();
		alert('아이디를 확인하세요');
		return false;
	}
	if(!isGoodPasswd){
		frm.passwd2.select();
		alert('패스워드를 확인하세요');
		return false;
	}
	if(!isGoodName){
		frm.name.select();
		alert('이름을 확인하세요');
		return false;
	}
	
}

/*
	function check() {
	if(frm.id.value.length < 3){
		alert('아이디는 세글자 이상 사용가능합니다.');
		frm.id.select();
		return false;
	} 
	if(frm.passwd.value.length == 0){
		alert('비밀번호는 필수입력사항입니다.')
		frm.passwd.select();
		return false;
	}
	if(frm.name.value.length == 0){
		alert('이름은 필수입력사항입니다.')
		frm.name.select();
		return false;
	}
	if(frm.email.value.legth == 0){
		alert('이메일은 필수입력사항입니다.')
		frm.name.select();
		return false;
	}
	if(document.frm.passwd.value != document.frm.passwd2.value){
		alert('패스워드 입력값이 서로 다릅니다.')
		document.frm.passwd.select();
		return false;
	}
	if(frm.email.value != frm.email2.value){
		alert('이메일 입력값이 서로 다릅니다.')
		document.frm.passwd.select();
		return false;
	}
	
	
	return true;
} */

// 새로운 브라우저를 띄우고 아이디 중복확인
function winOpen() {
	//var inputId = document.getElementById('id').value
	var inputId = document.frm.id.value;
	// id입력값이 공백이면 '아이디입력하세요' 포커스주기
	if(inputId == ''){// inputId.length == 0
		alert('아이디를 입력하세요.');
		document.frm.id.focus();
		return;
	}
	// 새로운 자식창 열기
	// open() 호출한쪽은 부모창
	//open() 에 의해 새로열린 창은 자식창
	//부모 - 자식 관계가 있음.
	//자식창의 데이터를 부모창으로 가져올수 있음.
	var childWindow = window.open('joinIdDupCheck.jsp?userid=' + inputId, '', 'width=400,height=300');
	// childWindow.document.write('입력한 아이디:' +inputId + '<br>');
}

</script>
	<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</body>
</html>