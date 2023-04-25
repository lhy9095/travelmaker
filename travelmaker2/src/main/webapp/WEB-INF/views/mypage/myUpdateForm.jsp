<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url("${path}/resources/css/myUpdateForm.css");
</style>
<script type="text/javascript"
	src="${path }/resources/bootstrap/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">	
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
			Swal.fire({
						  title: '비밀번호와 비밀번호 확인이\n다릅니다',
						  width: 600,
						  padding: '3em',
						  confirmButtonColor: '#5D9FFF',
						  background: '#fff url(${path }/resources/images/alert.png)',
						  backdrop: 'rgba(40,23,100,0.1)',  
						  allowOutsideClick : true
					}); 
			frm.password.focus();
			frm.password.value = "";
			frm.password2.value = "";
			return false;
		}
		if (pw.length < 4 || pw.length > 16) {
			Swal.fire({
						  title: '비밀번호는 최소 4자 이상\n최대 16자 이하',
						  width: 600,
						  padding: '3em',
						  confirmButtonColor: '#5D9FFF',
						  background: '#fff url(${path }/resources/images/alert.png)',
						  backdrop: 'rgba(40,23,100,0.1)',  
						  allowOutsideClick : true
					}); 
			frm.password.focus();
			return false;
		}			
	}
	
	//별명 중복 검사
	function nickNameChk() {
		if (!frm.nickName.value) {
			Swal.fire({
						  title: '별명을 입력한 후에 체크하세요',
						  width: 600,
						  padding: '3em',
						  confirmButtonColor: '#5D9FFF',
						  background: '#fff url(${path }/resources/images/alert.png)',
						  backdrop: 'rgba(40,23,100,0.1)',  
						  allowOutsideClick : true
					}); 
			frm.nickName.focus();
			return false;
		}
		$.post('../member/nickNameChk.do', "nickName="+frm.nickName.value, function(data) {
			$('#nickNameChk1').html(data);
			frm.nickName.focus();
		});
	}
	
	// 별명  중복 검사 후 수정하면 확인 결과 지우기  
	function nickNameChk2() {
		document.getElementById("nickNameChk1").innerHTML = "";
	}
	
	// 회원탈퇴 
	function del() {
		/* var con = confirm("정말로 탈퇴하시겠습니까?");
		if (con) {
			pwChk3();
		} */
		Swal.fire({
			  title: '정말로 탈퇴하시겠습니까?',
			  showCancelButton: true,
			  confirmButtonText: '확인', 
			  cancelButtonText: '취소', 
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '##D0D0D0',
			  cancelButtonColor: '#5D9FFF',
			  background: '#fff url(${path }/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)'  
		}).then(result => {
			if (result.isConfirmed) {
				pwChk3();
			}
			else {
				Swal.fire({
							  title: '탈퇴가 취소 되었습니다',
							  width: 600,
							  padding: '3em',
							  confirmButtonColor: '#5D9FFF',
							  background: '#fff url(${path }/resources/images/alert.png)',
							  backdrop: 'rgba(40,23,100,0.1)',  
							  allowOutsideClick : true
						}); 
				return;
			}
		}); 
	}
	
	// 회원탈퇴 전 비밀번호 확인
	function pwChk3() {
		var pw1 = frm.password.value;
		var pw2 = frm.password2.value;
		
		if (pw1.length && pw2.length) {			
			if (frm.password.value != frm.password2.value) {
				Swal.fire({
						  title: '비밀번호와 비밀번호 확인이\n다릅니다',
						  width: 600,
						  padding: '3em',
						  confirmButtonColor: '#5D9FFF',
						  background: '#fff url(${path }/resources/images/alert.png)',
						  backdrop: 'rgba(40,23,100,0.1)',  
						  allowOutsideClick : true
					}); 
				frm.password.focus();
				frm.password.value = "";
				frm.password2.value = "";
				return false;
			} location.href = "delete.do";
		} else {
			Swal.fire({
						  title: '비밀번호와 비밀번호 확인을\n입력하세요',
						  width: 600,
						  padding: '3em',
						  confirmButtonColor: '#5D9FFF',
						  background: '#fff url(${path }/resources/images/alert.png)',
						  backdrop: 'rgba(40,23,100,0.1)',  
						  allowOutsideClick : true
					}); 
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
<style type="text/css">
.li2 {
	background-color: #fafafa;
}
</style>
</head>
<body>
	<div class="headerSpace"></div>
	<div class="nav">
		<ul class="nav_ul">
			<li class="nav_li1 li1"><a href="myUpdateForm.do">마이페이지</a></li>
			<li class="nav_li2 li2"><a href="myUpdateForm.do">내 정보 수정</a></li>
			<li class="nav_li2 li3"><a
				href="myBoard.do?id=${sessionScope.id}">내가 쓴 글</a></li>
			<li class="nav_li2 li4"><a
				href="likesList.do?id=${sessionScope.id}">좋아요 목록</a></li>
		</ul>
	</div>
	<div class="main">
		<div class="main_header">
			<h3>내 정보 수정</h3>
		</div>
		<div class="formDiv">
			<form action="myUpdate.do" method="post" name="frm"
				onsubmit="return chk()">
				<input type="hidden" name="id" value="${member.id }"> <input
					type="hidden" name="name" value="${member.name }">
				<div>
					<span>아이디</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					${member.id }
				</div>
				<div class="chk">
					<span>비밀번호</span> <input class="textBox tb1" type="password"
						name="password" id="password" required="required"
						autofocus="autofocus" onKeyup="pwChk(this)"
						style="ime-mode: disabled;"> <img class="chkIcon"
						src="${path }/resources/images/gray_eye.png"></img>
					<div class="chkDiv" id="pwChk1"></div>
				</div>
				<div class="chk">
					<span>비밀번호 확인</span> <input class="textBox tb2" type="password"
						name="password2" required="required" onKeyup="pwChk2()">
					<div class="chkDiv" id="pwChk2"></div>
				</div>
				<div>
					<span>이름</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					${member.name }
				</div>
				<div>
					<span>이메일</span> <input class="textBox tb3" type="email"
						name="email" required="required" value="${member.email }">
				</div>
				<div>
					<span>전화번호</span> <input class="textBox tb4" type="text" name="tel"
						required="required" pattern="\d{3}-\d{3,4}-\d{4}"
						placeholder="000-0000-0000" value="${member.tel }">
				</div>
				<div class="chk">
					<span>별명</span> <input class="textBox tb5" type="text"
						name="nickName" required="required" value="${member.nickName }"
						onKeyup="nickNameChk2()"> <input class="chkBtn"
						type="button" value="중복체크" onclick="nickNameChk()">
					<div class="chkDiv" id="nickNameChk1"></div>
				</div>
				<input class="submitBtn" type="submit" value="수정완료"> <input
					class="deleteBtn" type="button" onclick="del()" value="회원 탈퇴">
			</form>
		</div>
	</div>
</body>
</html>