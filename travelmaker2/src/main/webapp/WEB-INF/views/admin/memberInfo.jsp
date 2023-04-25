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
@import url("${path}/resources/css/memberInfo.css");
</style>
<script type="text/javascript"
	src="${path }/resources/bootstrap/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
// 회원 강제탈퇴 
function del() {
	Swal.fire({
		  title: '정말로 강제 탈퇴하시겠습니까?',
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
			var id = '${member.id}';
			location.href = "deleteMember.do?id=" + id;
		}
		else {
			Swal.fire({
						  title: '강제 탈퇴가 취소되었습니다.',
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
			<li class="nav_li1 li1"><a href="memberInfo.do?id=${member.id }">회원
					정보</a></li>
			<li class="nav_li2 li2"><a href="memberInfo.do?id=${member.id }">회원
					정보 </a></li>
			<li class="nav_li2 li3"><a
				href="memberBoard.do?id=${member.id }">작성한 게시글</a></li>
			<li class="nav_li2 li4"><a
				href="memberReview.do?id=${member.id }">작성한 댓글</a></li>
		</ul>
	</div>
	<div class="main">
		<div class="main_header">
			<h3>${member.id }님의회원 정보</h3>
		</div>
		<div class="info">
			<div>
				<span class="textBoxName">아이디</span><input type="text"
					class="textBox tb1" value="${member.id }" readonly="readonly">
			</div>
			<div>
				<span class="textBoxName">이름</span><input type="text"
					class="textBox tb2" value="${member.name }" readonly="readonly">
			</div>
			<div>
				<span class="textBoxName">별명</span><input type="text"
					class="textBox tb3" value="${member.nickName }" readonly="readonly">
			</div>
			<div>
				<span class="textBoxName">이메일</span><input type="text"
					class="textBox tb4" value="${member.email }" readonly="readonly">
			</div>
			<div>
				<span class="textBoxName">전화번호</span><input type="text"
					class="textBox tb5" value="${member.tel }" readonly="readonly">
			</div>
			<div>
				<span class="textBoxName">가입일</span><input type="text"
					class="textBox tb6" value="${member.reg_date }" readonly="readonly">
			</div>
			<div>
				<span class="textBoxName">탈퇴여부</span><input type="text"
					class="textBox tb7" readonly="readonly"
					<c:choose>
							<c:when test="${member.del == 'n'}">
								value="회원"
							</c:when>
							<c:when test="${member.del == 'y'}">
								value="탈퇴"
							</c:when>
							<c:otherwise>
								value="강제탈퇴"
							</c:otherwise>
						</c:choose>>
				<c:if test="${member.del == 'n'}">
					<input type="button" class="delBtn" value="강제 탈퇴" onclick="del()">
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>