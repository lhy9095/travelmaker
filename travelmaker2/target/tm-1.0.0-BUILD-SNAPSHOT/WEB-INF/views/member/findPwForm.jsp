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
<h2>비밀번호 찾기</h2>
</div>
<div class="formDiv">
<form action="findPw.do" method="post">
	<input class="textBox" type="text" name="id" required="required" autofocus="autofocus"
		placeholder="아이디"><br>
	<input class="textBox" type="text" name="name" required="required" placeholder="이름"><br>
	<input class="submitBtn" type="submit" value="확인">
</form>
</div>
<div class="linkDiv">
<a class="link" href="findIdForm.do">아이디 찾기</a>
<a class="link" href="joinForm.do">회원가입</a>
<a class="link" href="loginForm.do">로그인</a>
</div>
</div>
</div>
</body>
</html>