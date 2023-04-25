<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url("${path}/resources/css/instagram.css");
</style>
<style type="text/css">
@import url("${path}/resources/css/likesList.css");
</style>
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript">
	// 좋아요 조회
	$(document)
			.ready(
					function() {
						<c:forEach var="board" items="${list }" varStatus="status">
						$
								.post(
										'../board/likesSelect.do?bno=${board.bno }&id=${sessionScope.id}',
										function(data) {
											$('#likeIcon${status.count}').attr(
													'src',
													'${path }/resources/images/'
															+ data);
										});
						$.post('../board/likesCount.do?bno=${board.bno }',
								function(data) {
									$('#likesTotal${status.count}').html(data);
								});
						</c:forEach>
					});

	//좋아요 기능
	<c:forEach var="board" items="${list }" varStatus="status">
	$(document)
			.ready(
					function() {
						$('#likeIcon${status.count}')
								.on(
										'click',
										function() {
											$
													.post(
															'../board/likesUpdate.do?bno=${board.bno }&id=${sessionScope.id}',
															function(data) {
																$(
																		'#likeIcon${status.count}')
																		.attr(
																				'src',
																				'${path }/resources/images/'
																						+ data);
																$
																		.post(
																				'../board/likesCount.do?bno=${board.bno }',
																				function(
																						data) {
																					$(
																							'#likesTotal${status.count}')
																							.html(
																									data);
																				});
															});
										});
					});
	</c:forEach>
</script>
<style type="text/css">
.li3 {
	background-color: #fafafa;
}
</style>
</head>
<body>
	<div class="headerSpace"></div>

	<div class="nav">
		<ul class="nav_ul">
			<li class="nav_li1 li1"><a href="myUpdateForm.do">마이페이지</a></li>
			<li class="nav_li2 li2"><a href="myUpdateForm.do">내 정보 수정</a></li>
			<li class="nav_li2 li3"><a
				href="myBoard.do?id=${sessionScope.id}">내가 쓴 글</a></li>
			<li class="nav_li2 li4"><a
				href="likesList.do?id=${sessionScope.id}">좋아요 목록</a></li>
		</ul>
	</div>

	<div class="likeslist">
		<section class="main">
			<c:if test="${not empty list }">
				<div class="hihi">
					<c:forEach var="board" items="${list }" varStatus="status">
						<c:choose>
							<c:when test="${board.del == 'n' }">
								<div class="wrapper">
									<div class="left-col">
										<div class="post">
											<div class="info">
												<div class="user">
													<div class="profile-pic">
														<img src="${path }/resources/images/logo.png" alt="">
													</div>
													<p class="username">${board.nickName }</p>
												</div>
											</div>
											<a
												href="../board/bdView.do?bno=${board.bno }&pageNum=${pb.currentPage}"><img
												src="${path }/resources/course/${board.courseImg }"
												class="post-image" alt=""></a>
											<div class="post-content">
												<div class="reaction-wrapper">
													<img src="${path }/resources/images//heart.png"
														class="likeIcon" id="likeIcon${status.count}"><span
														class="likesTotal" id="likesTotal${status.count}"></span>
													<img src="${path }/resources/images/readCntEye.png"
														class="readCntIcon">
													<p class="likes">${board.readcount }</p>
												</div>
												<p class="description">
													<span>${board.title }</span>
												</p>
												<p class="post-time">${board.reg_date }</p>
											</div>
										</div>
									</div>
								</div>
							</c:when>
							<c:when test="${board.del =='a'}">
								<div class="wrapper">
									<div class="left-col">
										<div class="post">관리자에&nbsp;의해&nbsp;삭제된&nbsp;게시글입니다.</div>
									</div>
								</div>
							</c:when>
						</c:choose>
					</c:forEach>
				</div>
			</c:if>
		</section>

		<div class="container" align="center">
			<div align="center">
				<ul class="pagination">
					<!-- 시작페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
					<c:if test="${pb.startPage > pb.pagePerBlock }">
						<li><a href="myBoard.do?id=${sessionScope.id}&pageNum=1"><img
								alt="처음으로" src="${path }/resources/images/doubleleft.png"></a></li>
						<li><a
							href="myBoard.do?id=${sessionScope.id}&pageNum=${pb.startPage - 1 }"><img
								alt="이전" src="${path }/resources/images/back.png"></a></li>
					</c:if>
					<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage}">
						<c:if test="${pb.currentPage == i }">
							<button
								onclick="location.href='myBoard.do?id=${sessionScope.id}&pageNum=${i }'"
								class="btn4Active">${i}</button>
						</c:if>
						<c:if test="${pb.currentPage != i }">
							<button
								onclick="location.href='myBoard.do?id=${sessionScope.id}&pageNum=${i }'"
								class="btn4">${i}</button>
						</c:if>
					</c:forEach>
					<!-- 보여줄 것이 남아 있으면 endPage보다 totalPage가 크다 -->
					<c:if test="${pb.endPage < pb.totalPage }">
						<li><a
							href="myBoard.do?id=${sessionScope.id}&pageNum=${pb.endPage + 1 }"><img
								alt="다음" src="${path }/resources/images/forward.png"></a></li>
						<li><a
							href="myBoard.do?id=${sessionScope.id}&pageNum=${pb.totalPage }"><img
								alt="마지막으로" src="${path }/resources/images/doubleright.png"></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>