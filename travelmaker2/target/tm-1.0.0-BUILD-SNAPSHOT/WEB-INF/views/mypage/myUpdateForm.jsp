<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${path }/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript">
	//별명 중복 검사
	function nickNameChk() {
		if (!frm.nickName.value) {
			alert("별명을 입력한 후에 체크하세요");
			frm.nickName.focus();
			return false;
		}
		$.post('nickNameChk.do', "nickName="+frm.nickName.value, function(data) {
			$('#nickNameChk1').html(data);
		});
	}
	
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
			msg = "비밀번호를 입력해 주세요";
		}
		document.getElementById("pwChk1").innerHTML = msg;
	} 
	
	// 암호와 암호확인 일치 검사
	function pwChk2(str) {
		if (frm.password.value != frm.password2.value) {
			document.getElementById("pwChk2").innerHTML = "비밀번호와 비밀번호 확인이 다릅니다";
		} else {
			document.getElementById("pwChk2").innerHTML = "비밀번호와 비밀번호 확인이 일치합니다";
		}
	}

	// submit할 때 암호와 암호확인 일치 검사
	function chk() {
		var pw = frm.password.value;
		
		if (frm.password.value != frm.password2.value) {
			alert("비밀번호와 비밀번호 확인이 다릅니다");
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
		$('.btn').on('click', function() {
			$('#password').toggleClass('active');
			if($('#password').hasClass('active')){
				$(this).prev('input').attr('type', 'text');
			} else {
				$(this).prev('input').attr('type', 'password');
			}
		});
	});
	
	// 회원탈퇴 
	function del() {
		var con = confirm("정말로 탈퇴하시겠습니까?");
		if (con) {
			pwChk3();
		}
		else {
			alert("탈퇴가 취소 되었습니다");
			return;
		}
	}
	
	// 회원탈퇴 전 비밀번호 확인
	function pwChk3() {
		var pw1 = frm.password.value;
		var pw2 = frm.password2.value;
		
		if (pw1.length && pw2.length) {			
			if (frm.password.value != frm.password2.value) {
				alert("비밀번호와 비밀번호 확인이 다릅니다");
				frm.password.focus();
				frm.password.value = "";
				frm.password2.value = "";
				return false;
			} location.href = "delete.do";
		} else {
			alert("비밀번호와 비밀번호 확인을 입력하세요");
			return false;
		}
	}
	
</script>
</head>
<body>
<h3>내 정보 수정</h3>
<form action="myUpdate.do" method="post" name="frm"
	onsubmit="return chk()">
	<input type="hidden" name="id" value="${member.id }">
	<input type="hidden" name="name" value="${member.name }">
	아이디 ${member.id }<br>
	비밀번호<input type="password" name="password" id="password" required="required"
		autofocus="autofocus" onKeyup="pwChk(this)" style="ime-mode:disabled;">
	<input type="button" class="btn" value="**" >
	<div id="pwChk1"></div>	
	비밀번호 확인<input type="password" name="password2" required="required"
		onKeyup="pwChk2()"><br>
	<div id="pwChk2"></div>
	이름 ${member.name }<br>
	이메일<input type="email" name="email" required="required"
		value="${member.email }"><br>
	전화번호<input type="text" name="tel" required="required"
		pattern="\d{3}-\d{4}-\d{4}" placeholder="000-0000-0000"
		value="${member.tel }"><br>
	별명<input type="text" name="nickName" required="required"
		value="${member.nickName }">
	<input type="button" value="중복체크" onclick="nickNameChk()">
	<div id="nickNameChk1"></div>
	<input type="submit" value="수정">	
	<input type="button" onclick="del()" value="회원 탈퇴">
</form>
</body>
</html>