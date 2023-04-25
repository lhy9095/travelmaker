<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<%-- ${path }를 사용하면 경로가 절대경로로 변경됨 --%>
<style type="text/css">@import url("${path}/resources/css/instagram.css");</style>
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>

</head><body>

<section class="main">
	<c:if test="${not empty list }">
	<div class="hihi">
		<c:forEach var="board" items="${list }">
			<c:if test="${board.del != 'y' }">
			    <div class="wrapper">
			        <div class="left-col">
			            <div class="post">
			                <div class="info">
			                    <div class="user">
			                        <div class="profile-pic"><img src="${path }/resources/images/logo.png" alt=""></div>
			                        <p class="username">${board.nickName }</p>
			                    </div>
			                </div>
			                <a href="bdView.do?bno=${board.bno }&pageNum=${pb.currentPage}"><img src="${path }/resources/course/${board.courseImg }" class="post-image" alt=""></a>
			                <div class="post-content">
			                    <div class="reaction-wrapper">
			                        <!-- <img src="resources/images/img/like.PNG" class="icon" alt=""> -->
			                        <img src="${path }/resources/images/img/comment.PNG" class="icon" alt=""><p class="likes">1,012 likes</p>
			                        <img src="${path }/resources/images/img/send.PNG" class="icon" alt=""><p class="likes">${board.readcount } readcount</p>
			                    </div>
			                    <p class="description"><span>${board.title }</span></p>
			                    <p class="post-time">${board.reg_date }</p>
			                </div>
			            </div>
			        </div>
			    </div>
		    </c:if>
    	</c:forEach>
    	</div>
	</c:if>
</section>

<div class="container" align="center">
	<div align="center">
		<ul class="pagination">
			<!-- 시작페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li><a href="bdList.do?pageNum=1"><img alt="처음으로" src="${path }/resources/images/doubleleft.png"></a></li>
				<li><a href="bdList.do?pageNum=${pb.startPage - 1 }"><img alt="이전" src="${path }/resources/images/back.png"></a></li>			
			</c:if>
			<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage}">
				<c:if test="${pb.currentPage == i }">
					<li class="active"><a href="bdList.do?pageNum=${i }">${i }</a></li>
				</c:if>
				<c:if test="${pb.currentPage != i }">
					<li><a href="bdList.do?pageNum=${i }">${i }</a></li>
				</c:if>
			</c:forEach>
			<!-- 보여줄 것이 남아 있으면 endPage보다 totalPage가 크다 -->
			<c:if test="${pb.endPage < pb.totalPage }">
				<li><a href="bdList.do?pageNum=${pb.endPage + 1 }"><img alt="다음" src="${path }/resources/images/forward.png"></a></li>
				<li><a href="bdList.do?pageNum=${pb.totalPage }"><img alt="마지막으로" src="${path }/resources/images/doubleright.png"></a></li>
			</c:if>
		</ul>
	</div>
</div>

<div align="center" style="position: fixed; top: 30%; left: 10px">
	<form action="bdList.do?pageNum=1">
		<select name="search">
			<c:forTokens var="sh" items="content" delims="," varStatus="i">
				<c:if test="${sh==board.search }">
					<option value="${sh }" selected="selected">${title[i.index] }</option>
				</c:if>
				<c:if test="${sh!=board.search }">
					<option value="${sh }">${title[i.index] }</option>
				</c:if>
			</c:forTokens>
		</select>
		<input type="text" name="keyword" value="${board.keyword }">
		<input type="submit" value="검색">
	</form>
	<div align="center"><a href="bdInsertForm2.do?bno=0&pageNum=1">게시글 입력</a></div>
</div>

</body>
</html>