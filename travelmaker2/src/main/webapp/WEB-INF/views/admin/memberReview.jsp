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
@import url("${path}/resources/css/memberReview.css");
</style>
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
// 리뷰 삭제
<c:forEach var="rv" items="${rvList }">
$(document).ready(function() {
	$('.delete_${rv.rno }_btn').on('click',function() {
		Swal.fire({
			  title: '정말로 삭제하시겠습니까?',
			  showCancelButton: true,
			  confirmButtonText: '확인', 
			  cancelButtonText: '취소', 
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '##D0D0D0',
			  cancelButtonColor: '#5D9FFF',
			  background: '#fff url(${path }/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)'  
		}).then(result => {
			if (result.isConfirmed) {
				var rno = $(this).attr("data-rno");
				location.href = "rvDelete.do?id=${member.id}&rno=" + rno;
			}
			else {
				Swal.fire({
							  title: '삭제가 취소되었습니다.',
							  width: 600,
							  padding: '3em',
							  confirmButtonColor: '#5D9FFF',
							  background: '#fff url(${path }/resources/images/alert.png)',
							  backdrop: 'rgba(40,23,100,0.1)',  
							  allowOutsideClick : true
						}); 
				return;
			}
		}); 
	});
	});

// 관리자에 의해 삭제된 리뷰 보기/닫기
$(document).ready(function() {
	$(".hideReview").hide();
	
	$(".open_${rv.rno }").on("click", function() {
		  $(".hide_${rv.rno }").show();
		});
	
	$(".close_${rv.rno }").on("click", function() {
		  $(".hide_${rv.rno }").hide();
		});
	
});
</c:forEach>

</script>
<style type="text/css">
.li4 {
	background-color: #fafafa;
}
</style>
</head>
<body>
	<div class="headerSpace"></div>

	<div class="nav">
		<ul class="nav_ul">
			<li class="nav_li1 li1"><a href="memberInfo.do?id=${member.id }">회원
					정보</a></li>
			<li class="nav_li2 li2"><a href="memberInfo.do?id=${member.id }">회원
					정보 </a></li>
			<li class="nav_li2 li3"><a
				href="memberBoard.do?id=${member.id }">작성한 게시글</a></li>
			<li class="nav_li2 li4"><a
				href="memberReview.do?id=${member.id }">작성한 댓글</a></li>
		</ul>
	</div>
	<div class="main">
		<h2>${member.id }님의댓글</h2>
		<c:if test="${not empty rvList }">
			<c:forEach var="rv" items="${rvList }">
				<c:choose>
					<c:when test="${rv.del == 'n' }">
						<div class="border_gray">
							<table style="table-layout: fixed;">
								<tr>
									<td class="nickNameTd">${rv.nickName }</td>
									<td id="btn_${rv.rno }"><input type="button" value="삭제"
										class="btn5 delete_${rv.rno }_btn" data-rno="${rv.rno }"></td>
									<td class="post-time">${rv.update_date}</td>
								</tr>
								<tr>
									<td id="td_${rv.rno }" height="100" colspan="3" class="td1"><pre>${rv.reply_content }</pre></td>
								</tr>
							</table>
							<div class="imgDiv">
								<c:forEach var="reviewphoto" items="${rpList }">
									<c:if test="${reviewphoto.rno==rv.rno }">
										<img alt="${reviewphoto.imgName }"
											src="${path }/resources/upload/${reviewphoto.imgName }"
											width="130" height="130">
									</c:if>
								</c:forEach>
							</div>
						</div>
					</c:when>
					<c:when test="${rv.del == 'a'}">
						<div class="border_gray">
							<table style="table-layout: fixed;">
								<tr>
									<td><span class="openReview open_${rv.rno }">관리자에&nbsp;의해&nbsp;삭제된&nbsp;댓글입니다.</span></td>
								</tr>
							</table>
							<div class="hideReview hide_${rv.rno }">
								<button class="closeReviewBtn close_${rv.rno }">닫기</button>
								<table class="hideTable" style="table-layout: fixed;">
									<tr>
										<td width="20%">${rv.nickName }</td>
										<td></td>
										<td></td>
										<td class="post-time">${rv.update_date}</td>
									</tr>
									<tr>
										<td></td>
										<td id="td_${rv.rno }" height="100" colspan="2" class="td1"><pre>${rv.reply_content }</pre></td>
									</tr>
								</table>
								<div class="imgDiv">
									<c:forEach var="reviewphoto" items="${rpList }">
										<c:if test="${reviewphoto.rno==rv.rno }">
											<img alt="${reviewphoto.imgName }"
												src="${path }/resources/upload/${reviewphoto.imgName }"
												width="130" height="130">
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</c:when>
				</c:choose>
			</c:forEach>
		</c:if>
	</div>
</body>
</html>