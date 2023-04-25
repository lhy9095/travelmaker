<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("${path}/resources/css/joinForm.css");</style>
<script type="text/javascript" src="${path }/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript">
	// 아이디 중복 검사
	function idChk() {
		if (!frm.id.value) {
			alert("아이디를 입력한 후에 체크하세요.");
			frm.id.focus();
			return false;
		}
		$.post('idChk.do', "id="+frm.id.value, function(data) {
			$('#idChk1').html(data);
		});
	}
	
	// 별명 중복 검사
	function nickNameChk() {
		if (!frm.nickName.value) {
			alert("별명을 입력한 후에 체크하세요.");
			frm.nickName.focus();
			return false;
		}
		$.post('nickNameChk.do', "nickName="+frm.nickName.value, function(data) {
			$('#nickNameChk1').html(data);
		});
	}
	
	/* 서버단에서 처리해보기
	// 비밀번호 유효성 검사
	function pwChk() {
		$.post('pwChk.do', "password="+frm.password.value, function(data) {
			$('#pwChk1').html(data);
		});
	} */
	
	// 비밀번호 유효성 검사
	function pwChk(str) {
		var pw = str.value;
		var msg = "";
		var checkPoint = 0;
		
		// 입력값이 있을 경우에만 실행
		if (pw.length) {
			if (pw.length < 4 || pw.length > 16) {
				msg = "최소 4자 이상, 최대 16자 이하";
			// 비밀번호 문자열의 길이가 4 ~ 16자인 경우
			} else {
				// 비밀번호에 숫자 존재 여부 검사
				var pattern1 = /[0-9]/;  
				if (!pattern1.test(pw)) {
					checkPoint = checkPoint + 1;
				}
				// 비밀번호에 영문 소문자 존재 여부 검사
				var pattern2 = /[a-z]/;
				if (!pattern2.test(pw)) {
					checkPoint = checkPoint + 1;
				}
				// 비밀번호에 영문 대문자 존재 여부 검사
				var pattern3 = /[A-Z]/;
				if (!pattern3.test(pw)) {
					checkPoint = checkPoint + 1;
				}
				// 비밀번호에 특수문자 존재 여부 검사
				var pattern4 = /[~!@#$%^&*()_+|<>?:{}]/;
				if (!pattern4.test(pw)) {
					checkPoint = checkPoint + 1;
				}
				if (checkPoint >= 3) {
					msg = "보안성이 취약한 비밀번호";
				} else if (checkPoint == 2) {
					msg = "보안성이 낮은 비밀번호";
				} else if (checkPoint == 1) {
					msg = "보안성이 보통인 비밀번호";
				} else {
					msg = "보안성이 강력한 비밀번호";
				}
			}
		} else {
			msg = "비밀번호를 입력해 주세요.";
		}
		document.getElementById("pwChk1").innerHTML = msg;
	} 
	
	// 암호와 암호확인 일치 검사
	function pwChk2(str) {
		if (frm.password.value != frm.password2.value) {
			document.getElementById("pwChk2").innerHTML = "비밀번호와 비밀번호 확인이 다릅니다.";
		} else {
			document.getElementById("pwChk2").innerHTML = "비밀번호와 비밀번호 확인이 일치합니다.";
		}
	}

	// submit할 때 암호와 암호확인 일치 검사
	function chk() {
		var pw = frm.password.value;
		
		if (frm.password.value != frm.password2.value) {
			alert("비밀번호와 비밀번호 확인이 다릅니다.");
			frm.password.focus();
			frm.password.value = "";
			frm.password2.value = "";
			return false;
		}
		if (pw.length < 4 || pw.length > 16) {
			alert("비밀번호는 최소 4자 이상 최대 16자 이하");
			frm.password.focus();
			return false;
		}			
	}
	
	// 비밀번호 보기/숨기기
	$(document).ready(function() {
		$('.chkIcon').on('click', function() {
			$('#password').toggleClass('active');
			if($('#password').hasClass('active')){
				$(this).prev('input').attr('type', 'text');
				$('.chkIcon').attr('src','${path }/resources/images/blue_eye.png');
			} else {
				$(this).prev('input').attr('type', 'password');
				$('.chkIcon').attr('src','${path }/resources/images/gray_eye.png');
			}
		});
	});	
	
</script>
</head>
<body>
<div class="wrap">
<div class="joinForm">
<div>
	<h2>회원가입</h2>
</div>
<div class="formDiv">
<form action="join.do" method="post" name="frm" onsubmit="return chk()">
	<p class="p_space">아이디</p>
	<input class="textBox" type="text" name="id" required="required" autofocus="autofocus">
	<input class="chkBtn" type="button" value="중복확인" onclick="idChk()">
	<div class="chkDiv" id="idChk1"></div>
	<p class="p_space">비밀번호</p>
	<input class="textBox" type="password" name="password" id="password" required="required"
		onKeyup="pwChk(this)" style="ime-mode:disabled;">
	<img class="chkIcon" src="${path }/resources/images/gray_eye.png"></img>
	<!-- <input class="chkBtn" type="button" class="btn" value="**" > -->
	<div class="chkDiv" id="pwChk1"></div>	
	<p class="p_space">비밀번호 확인</p>
	<input class="textBox" type="password" name="password2" required="required"
		onKeyup="pwChk2()"><br>
	<div class="chkDiv" id="pwChk2"></div>
	<p class="p_space">이름</p>
	<input class="textBox" type="text" name="name" required="required"><br>
	<p class="p_space">이메일</p>
	<input class="textBox" type="email" name="email" required="required"><br>
	<p class="p_space">전화번호</p>
	<input class="textBox" type="text" name="tel" required="required"
		pattern="\d{3}-\d{3,4}-\d{4}" placeholder="000-0000-0000"><br>
	<p class="p_space">별명</p>
	<input class="textBox" type="text" name="nickName" required="required">
	<input class="chkBtn" type="button" value="중복확인" onclick="nickNameChk()">
	<div class="chkDiv" id="nickNameChk1"></div>
	<input class="submitBtn" type="submit" value="회원가입">
</form>
<p class="p_space2" >계정이 있으신가요?</p>
<input class="link" type="button" onclick="location.href='loginForm.do';" value="로그인">
</div>
</div>
</div>
</body>
</html>