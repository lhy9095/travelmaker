<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

</head>
<body>

	<c:if test="${result > 0 }">
		<script type="text/javascript">
		Swal.fire({
		  title: '수정되었습니다',
		  width: 600,
		  padding: '3em',
		  color: '#716add',
		  background: '#fff url(${path }/resources/images/alert.png)',
		  backdrop: 'rgba(40,23,100,0.1)',
		  closeOnClickOutside : false
		}).then(function() {
			location.href="bdList.do?pageNum=${pageNum}";	
		});
	</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
		alert("수정 실패 ㅠㅠ");
		history.back();
	</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script type="text/javascript">
		alert("암호도 모르면서!");
		history.back();
	</script>
	</c:if>

</body>
</html>