<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<style type="text/css">@import url("${path}/resources/css/findForm.css");</style>
</head>
<body>
<div class="wrap">
<div class="findForm">
<div>
<h2>아이디 찾기</h2>
</div>
<div class="formDiv">
<form action="findId.do" method="post">
	<input class="textBox" type="text" name="name" required="required" autofocus="autofocus"
		placeholder="이름"><br>
	<input class="textBox" type="text" name="tel" required="required" pattern="\d{3}-\d{4}-\d{4}" 
		placeholder="전화번호"><br>
	<input class="submitBtn" type="submit" value="확인">
</form>
</div>
<div class="linkDiv">
<a class="link" href="findPwForm.do">비밀번호 찾기</a>
<a class="link" href="joinForm.do">회원가입</a>
<a class="link" href="loginForm.do">로그인</a>
</div>
</div>
</div>
</body>
</html>