<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result > 0 }">
		<c:choose>
			<c:when test="${sessionScope.id eq 'master'}">
				<script type="text/javascript">
					location.href = "adminMain.do?pageNum=${pageNum}";
				</script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					location.href = "bdList.do?pageNum=${pageNum}";
				</script>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("입력 실패했습니다.");
			history.back();
		</script>
	</c:if>

</body>
</html>