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
	<c:if test="${result == 2 }">
		<script type="text/javascript">
			Swal.fire({
				title : '관리자 계정으로 \n로그인 되었습니다.',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				location.href = "../admin/adminMain.do";
			});
		</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			Swal.fire({
				title : '환영합니다',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				location.href = "../board/bdList.do";
			});
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			Swal.fire({
				title : '비밀번호가 다릅니다',
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
				title : '존재하지 않는 계정입니다.',
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
</body>
</html>