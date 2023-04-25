<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
</head><body>

<c:if test="${result > 0 }">
	<script type="text/javascript">
		alert("수정 되었습니다");
		location.href="bdList.do?pageNum=${pageNum}";
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