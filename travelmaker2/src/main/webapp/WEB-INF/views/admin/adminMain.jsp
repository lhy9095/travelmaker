<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<%-- ${path }를 사용하면 경로가 절대경로로 변경됨 --%>
<style type="text/css">
@import url("${path}/resources/css/instagram.css");
</style>
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
$(document).ready(function() {
	<c:forEach var="board" items="${list }" varStatus="status">
		//좋아요 조회
		$.post('../board/likesSelect.do?bno=${board.bno }&id=${sessionScope.id}', function(data) {
			$('#likeIcon${status.count}').attr('src', '${path }/resources/images/'+data);
		});
		$.post('../board/likesCount.do?bno=${board.bno }', function(data) {
			$('#likesTotal${status.count}').html(data);
		});	
		
		// 댓글 수 조회
		$.post('../board/reviewCount.do?bno=${board.bno }', function(data) {
			$('#reviewTotal${status.count}').html(data);
		});	
		
		// 좋아요 기능
		$('#likeIcon${status.count}').on('click', function() {	
			$.post('../board/likesUpdate.do?bno=${board.bno }&id=${sessionScope.id}', function(data) {
				$('#likeIcon${status.count}').attr('src', '${path }/resources/images/'+data);
				$.post('../board/likesCount.do?bno=${board.bno }', function(data) {
					$('#likesTotal${status.count}').html(data);
				});
			});
		});
		
		// 관리자의 게시글별 삭제 버튼 클릭을 통한 게시글 삭제 기능
		$('.delete_${board.bno }_btn').on('click',function() {
			 Swal.fire({
					title: '정말로 삭제하시겠습니까?',
					width: 600,
					padding: '3em',
					color: '#716add',
					background: '#fff url(${path }/resources/images/alert.png)',
					backdrop: 'rgba(40,23,100,0.1)',
					closeOnClickOutside : false,
					showCancelButton : true,
					confirmButtonText : "예",
					cancelButtonText : "아니오"
				}).then(result => {
					   if (result.isConfirmed) {
						   const urlParams = new URL(location.href).searchParams;
						   const pageNum = urlParams.get('pageNum');
						   var checkArr = new Array();
						   
						   checkArr.push($(this).attr("data-boardNum"));
						   
						   $.ajax({
							   url : "adminBdDelete.do",
							   type : "post",
							   data : { chkbox : checkArr, pageNum : pageNum },
							   success : function(data){
								   var result = data.result;
								   var pageNum = data.pageNum;
								   if(result > 0) {
									   Swal.fire({
											  title: '삭제되었습니다',
											  width: 600,
											  padding: '3em',
											  color: '#716add',
											  background: '#fff url(${path }/resources/images/alert.png)',
											  backdrop: 'rgba(40,23,100,0.1)', 
											  closeOnClickOutside : false
											}).then(function() {
												location.href="adminMain.do?pageNum=" + pageNum;	
											});
								   } else {
									   Swal.fire({
											  title: '삭제 실패했습니다',
											  width: 600,
											  padding: '3em',
											  color: '#716add',
											  background: '#fff url(${path }/resources/images/alert.png)',
											  backdrop: 'rgba(40,23,100,0.1)', 
											  closeOnClickOutside : false
											}).then(function() {
												history.back();
											});
								   }
							   }
						   });
					   } else Swal.fire({
							 	title: '삭제가 취소되었습니다',
							  	width: 600,
							  	padding: '3em',
							  	color: '#716add',
							  	background: '#fff url(${path }/resources/images/alert.png)',
							  	backdrop: 'rgba(40,23,100,0.1)',
								closeOnClickOutside : false,
								confirmButtonText : "예"
					   });  
				});
			});
	</c:forEach>
});

// 관리자의 선택삭제 버튼 클릭을 통한 게시글 삭제 기능 
$(document).ready(function() {
	$('.selectDelBtn').on('click',function() {
		Swal.fire({
			title: '정말로 삭제하시겠습니까?',
			width: 600,
			padding: '3em',
			color: '#716add',
			background: '#fff url(${path }/resources/images/alert.png)',
			backdrop: 'rgba(40,23,100,0.1)',
			closeOnClickOutside : false,
			showCancelButton : true,
			confirmButtonText : "예",
			cancelButtonText : "아니오"
		}).then(result => {
			   if (result.isConfirmed) {
				   const urlParams = new URL(location.href).searchParams;
				   const pageNum = urlParams.get('pageNum');
				   var checkArr = new Array();
				   
				   $("input[class='chkBox']:checked").each(function(){
					    checkArr.push($(this).attr("data-boardNum"));
					   });
				   
				   $.ajax({
					   url : "adminBdDelete.do",
					   type : "post",
					   data : { chkbox : checkArr, pageNum : pageNum },
					   success : function(data){
						   var result = data.result;
						   var pageNum = data.pageNum;
						   if(result > 0) {
							   Swal.fire({
									  title: '삭제되었습니다',
									  width: 600,
									  padding: '3em',
									  color: '#716add',
									  background: '#fff url(${path }/resources/images/alert.png)',
									  backdrop: 'rgba(40,23,100,0.1)', 
									  closeOnClickOutside : false
									}).then(function() {
										location.href="adminMain.do?pageNum=" + pageNum;	
									});
						   } else {
							   Swal.fire({
									  title: '삭제 실패했습니다',
									  width: 600,
									  padding: '3em',
									  color: '#716add',
									  background: '#fff url(${path }/resources/images/alert.png)',
									  backdrop: 'rgba(40,23,100,0.1)', 
									  closeOnClickOutside : false
									}).then(function() {
										history.back();
									});
						   }
					   }
				   });
			   } else Swal.fire({
					 	title: '삭제가 취소되었습니다',
					  	width: 600,
					  	padding: '3em',
					  	color: '#716add',
					  	background: '#fff url(${path }/resources/images/alert.png)',
					  	backdrop: 'rgba(40,23,100,0.1)',
						closeOnClickOutside : false,
						confirmButtonText : "예"
			   });  
		});	
	});
});
</script>
</head>
<body>
	<section class="main">
		<c:if test="${not empty list }">
			<div class="hihi">
				<div class="deleteDiv">
					<div class="allCheck">
						<input type="checkbox" name="allChk" id="allChk" class="allChk">
						<label for="allChk">모두 선택</label>

						<!-- 체크박스 전체선택 및 선택해제 -->
						<script type="text/javascript">
					$("#allChk").click(function(){
						 var chk = $("#allChk").prop("checked");
						 if(chk) {
					 		 $(".chkBox").prop("checked", true);
						 } else {
							 $(".chkBox").prop("checked", false);
						 }
					});
					</script>

					</div>
					<div class="selectDelBtnDiv">
						<button type="button" class="selectDelBtn">선택 삭제</button>
					</div>
				</div>

				<c:forEach var="board" items="${list }" varStatus="status">
					<c:choose>
						<c:when test="${board.del == 'n' }">
							<div class="wrapper">
								<div class="left-col">
									<div class="chkBoxSpace">
										<input type="checkbox" name="chkBox" class="chkBox"
											data-boardNum="${board.bno }">

										<script type="text/javascript">
									$(".chkBox").click(function(){
										  $("#allChk").prop("checked", false);
									});
									</script>

									</div>
									<div class="post">
										<div class="info">
											<div class="user">
												<div class="profile-pic">
													<img src="${path }/resources/images/logo.png" alt="">
												</div>
												<p class="username">${board.nickName }</p>
											</div>
											<div class="deletePost">
												<button type="button"
													class="delete_${board.bno }_btn deleteBtn"
													data-boardNum="${board.bno }">삭제</button>
											</div>
										</div>
										<a
											href="../board/bdView.do?bno=${board.bno }&pageNum=${pb.currentPage}"><img
											src="${path }/resources/course/${board.courseImg }"
											class="post-image" alt=""></a>
										<div class="post-content">
											<div class="reaction-wrapper">
												<img src="${path }/resources/images//heart.png"
													class="likeIcon" id="likeIcon${status.count}"> <span
													class="likesTotal" id="likesTotal${status.count}"></span> <img
													src="${path }/resources/images/readCntEye.png"
													class="readCntIcon"> <span class="likes readCntTotal">${board.readcount }</span>
												<img src="${path }/resources/images/review.png"
													class="reviewIcon"> <span class="reviewTotal"
													id="reviewTotal${status.count}"></span>
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
									<div class="post">
										<a
											href="../board/bdView.do?bno=${board.bno }&pageNum=${pb.currentPage}">
											관리자에&nbsp;의해&nbsp;삭제된&nbsp;게시글입니다.</a>
									</div>
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
					<li><a
						href="adminMain.do?pageNum=1&search=${board.search}&keyword=${board.keyword}"><img
							alt="처음으로" src="${path }/resources/images/doubleleft.png"></a></li>
					<li><a
						href="adminMain.do?pageNum=${pb.startPage - 1 }&search=${board.search}&keyword=${board.keyword}"><img
							alt="이전" src="${path }/resources/images/back.png"></a></li>
				</c:if>
				<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage}">
					<c:if test="${pb.currentPage == i }">
						<button
							onclick="location.href='adminMain.do?pageNum=${i}&search=${board.search}&keyword=${board.keyword}'"
							class="btn4Active">${i}</button>
					</c:if>
					<c:if test="${pb.currentPage != i }">
						<button
							onclick="location.href='adminMain.do?pageNum=${i}&search=${board.search}&keyword=${board.keyword}'"
							class="btn4">${i}</button>
					</c:if>
				</c:forEach>
				<!-- 보여줄 것이 남아 있으면 endPage보다 totalPage가 크다 -->
				<c:if test="${pb.endPage < pb.totalPage }">
					<li><a
						href="adminMain.do?pageNum=${pb.endPage + 1 }&search=${board.search}&keyword=${board.keyword}"><img
							alt="다음" src="${path }/resources/images/forward.png"></a></li>
					<li><a
						href="adminMain.do?pageNum=${pb.totalPage }&search=${board.search}&keyword=${board.keyword}"><img
							alt="마지막으로" src="${path }/resources/images/doubleright.png"></a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<div align="center" style="position: fixed; top: 30%; left: 10px">
		<select name="loc" onchange="window.location.href = value;">
			<option value="지역">지역</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=서울">서울</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=경기도">경기도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=강원도">강원도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=충청북도">충청북도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=충청남도">충청남도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=전라북도">전라북도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=전라남도">전라남도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMaint.do?search=loc&keyword=경상북도">경상북도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=경상남도">경상남도</option>
			<option
				value="http://localhost:8080/tm/admin/adminMain.do?search=loc&keyword=제주도">제주도</option>
		</select>
		<form action="bdList.do?pageNum=1">
			<select name="search">
				<c:forTokens var="sh" items="content,m.nickName" delims=","
					varStatus="i">
					<c:if test="${sh==board.search }">
						<option value="${sh }" selected="selected">${title[i.index] }</option>
					</c:if>
					<c:if test="${sh!=board.search }">
						<option value="${sh }">${title[i.index] }</option>
					</c:if>
				</c:forTokens>
			</select> <input type="text" name="keyword"> <input type="submit"
				value="검색">
		</form>
		<div align="center">
			<a href="../board/bdInsertForm.do?bno=0&pageNum=1" class="btn">게시글
				입력</a>
		</div>
	</div>
	<div style="display: none;">
		<form action="bdList2.do?pageNum=1">
			<select name="search">
				<c:forTokens var="sh" items="loc" delims="," varStatus="i">
					<c:if test="${sh==board.search }">
						<option value="${sh }" selected="selected">${title[i.index] }</option>
					</c:if>
					<c:if test="${sh!=board.search }">
						<option value="${sh }">${title[i.index] }</option>
					</c:if>
				</c:forTokens>
			</select> <input type="text" name="keyword" value="${board.keyword }">
			<input type="submit" value="검색">
		</form>
	</div>

</body>
</html>