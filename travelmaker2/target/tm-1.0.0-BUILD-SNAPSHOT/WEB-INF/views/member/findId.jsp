<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<style type="text/css">@import url("${path}/resources/css/findId.css");</style>
</head>
<body>
<div class="wrap">
<div class="findId">
<div>
<h2>아이디 찾기</h2>
</div>
<c:if test="${result == 1 }">
	<p class="p_space">회원님의 아이디는 '${member.id }'입니다.</p>
</c:if>
<c:if test="${result == 0 }">
	<script type="text/javascript">
		alert("아이디 찾기에 실패했습니다");
		history.back();
	</script>
</c:if>
<c:if test="${result == -1 }">
	<script type="text/javascript">
		alert("존재하지 않는 계정입니다.");
		history.back();
	</script>
</c:if>
<div class="linkDiv">
<input class="link" type="button" onclick="location.href='findPwForm.do';" value="비밀번호 찾기">
<input class="link" type="button" onclick="location.href='loginForm.do';" value="로그인">
<input class="link" type="button" onclick="location.href='joinForm.do';" value="회원가입">
<!-- <a class="link" href="findPwForm.do">비밀번호 찾기</a>
<a class="link" href="loginForm.do">로그인</a>
<a class="link" href="joinForm.do">회원가입</a> -->
</div>
</div>
</div>
</body>
</html>