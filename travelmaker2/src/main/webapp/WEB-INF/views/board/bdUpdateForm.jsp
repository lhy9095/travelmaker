<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<%-- ${path }를 사용하면 경로가 절대경로로 변경됨 --%>
<style type="text/css">
@import url("${path}/resources/css/view.css");
</style>
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/jquery.js"></script>

</head>
<body>

	<div class="headerSpace"></div>
	<div align="center" style="margin-bottom: 500px;">
		<h2>게시글 수정</h2>
		<form action="bdUpdate.do" method="post" name="frm">
			<input type="hidden" name="bno" value="${board.bno }"> <input
				type="hidden" name="pageNum" value="${pageNum }">
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" required="required"
						autofocus="autofocus" value="${board.title }"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="10" cols="70" name="content"
							required="required">${board.content }</textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="확인"
						class="btn2">
			</table>
		</form>
	</div>

</body>
</html>