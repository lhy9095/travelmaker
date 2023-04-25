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
	<c:if test="${result == 2}">
		<script type="text/javascript">
			Swal.fire({
				title : '강제 탈퇴 되었습니다.',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				location.href = "memberList.do";
			});
		</script>
	</c:if>
	<c:if test="${result == 1}">
		<script type="text/javascript">
			Swal.fire({
				title : '강제 탈퇴 되었습니다.',
				width : 600,
				padding : '3em',
				confirmButtonColor : '#5D9FFF',
				background : '#fff url(${path }/resources/images/alert.png)',
				backdrop : 'rgba(40,23,100,0.1)',
				allowOutsideClick : true
			}).then(function() {
				var id = '${member.id}';
				location.href = "memberInfo.do?id=" + id;
			});
		</script>
	</c:if>
	<c:if test="${result == 0}">
		<script type="text/javascript">
			Swal.fire({
				title : '강제 탈퇴  실패했습니다.',
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