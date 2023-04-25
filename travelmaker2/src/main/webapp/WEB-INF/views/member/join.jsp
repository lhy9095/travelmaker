<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
</head>
<body>
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			Swal.fire({
				title : '회원 가입을 축하합니다',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				location.href = "loginForm.do";
			});
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			Swal.fire({
				title : '회원 가입에 실패했습니다',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				history.back();
			});
		</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script type="text/javascript">
			Swal.fire({
				title : '이미 가입된 아이디입니다',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				history.go(-1);
			});
		</script>
	</c:if>
	<c:if test="${result == -2 }">
		<script type="text/javascript">
			Swal.fire({
				title : '이미 가입된 닉네임입니다',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				history.go(-1);
			});
		</script>
	</c:if>
</body>
</html>