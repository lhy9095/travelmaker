<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<style type="text/css">
@import url("${path}/resources/css/memberList.css");
</style>
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
// 회원 강제탈퇴 
<c:forEach var="member" items="${list }">
$(document).ready(function() {
	$('.delete_${member.id }_btn').on('click',function() {
	Swal.fire({
		  title: '정말로 강제 탈퇴하시겠습니까?',
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
			var id = $(this).attr("data-id");
			location.href = "deleteMember2.do?id=" + id;
		}
		else {
			Swal.fire({
						  title: '강제 탈퇴가 취소되었습니다.',
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
</c:forEach>
</script>
</head>
<body>
	<div class="memberListDiv">
		<table class="memberList">
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>별명</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>가입일</th>
				<th>게시글수</th>
				<th>댓글수</th>
				<th colspan="2">탈퇴여부</th>
			</tr>
			<c:if test="${not empty list }">
				<c:forEach var="member" items="${list }">
					<tr>
						<td>${member.mno }</td>
						<td class="idTd"><input type="button" class="idBtn"
							onClick="location.href='memberInfo.do?id=${member.id }'"
							value="${member.id }"></td>
						<td>${member.name }</td>
						<td>${member.nickName }</td>
						<td>${member.email }</td>
						<td>${member.tel }</td>
						<td>${member.reg_date }</td>
						<td>${member.boardCnt }</td>
						<td>${member.reviewCnt }</td>
						<c:choose>
							<c:when test="${member.del == 'n'}">
								<td>회원</td>
							</c:when>
							<c:when test="${member.del == 'y'}">
								<td colspan="2">탈퇴</td>
							</c:when>
							<c:otherwise>
								<td colspan="2">강제탈퇴</td>
							</c:otherwise>
						</c:choose>
						<c:if test="${member.del == 'n'}">
							<td><input type="button"
								class="delete_${member.id }_btn delBtn" value="강제 탈퇴"
								data-id="${member.id }"></td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>

	<div class="container" align="center">
		<div align="center">
			<ul class="pagination">
				<!-- 시작페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
				<c:if test="${pb.startPage > pb.pagePerBlock }">
					<li><a href="memberList.do?id=${sessionScope.id}&pageNum=1"><img
							alt="처음으로" src="${path }/resources/images/doubleleft.png"></a></li>
					<li><a
						href="memberList.do?id=${sessionScope.id}&pageNum=${pb.startPage - 1 }"><img
							alt="이전" src="${path }/resources/images/back.png"></a></li>
				</c:if>
				<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage}">
					<c:if test="${pb.currentPage == i }">
						<button
							onclick="location.href='memberList.do?id=${sessionScope.id}&pageNum=${i }'"
							class="btn4Active">${i}</button>
					</c:if>
					<c:if test="${pb.currentPage != i }">
						<button
							onclick="location.href='memberList.do?id=${sessionScope.id}&pageNum=${i }'"
							class="btn4">${i}</button>
					</c:if>
				</c:forEach>
				<!-- 보여줄 것이 남아 있으면 endPage보다 totalPage가 크다 -->
				<c:if test="${pb.endPage < pb.totalPage }">
					<li><a
						href="memberList.do?id=${sessionScope.id}&pageNum=${pb.endPage + 1 }"><img
							alt="다음" src="${path }/resources/images/forward.png"></a></li>
					<li><a
						href="memberList.do?id=${sessionScope.id}&pageNum=${pb.totalPage }"><img
							alt="마지막으로" src="${path }/resources/images/doubleright.png"></a></li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>