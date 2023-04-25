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

<script type="text/javascript">
	$(function() {
		$('#rvListDisp').load("rvList.do","bno=${board.bno}");
		$('#rInsert').click(function() {
			var uploadfiles = [];
			var formData = new FormData();
			formData.append('reply_content', frm1.reply_content.value);
			formData.append('mno', frm1.mno.value);
			formData.append('nickName', frm1.nickName.value);
			formData.append('bno', frm1.bno.value);
			var inputFile = $("input[name='file']");
			var files = inputFile[0].files;
			for (var i = 0; i < files.length; i++) {
				var file = files[i];
				uploadfiles.push(file);  // 업로드 파일 목록배열에 추가
//				preview(file, size - 1); // 미리보기
			}
			$.each(uploadfiles, function(idx, file) {
				formData.append('file', file, file.name);
			});
			$.ajax({
				url:'rInsert.do', data:formData, type:'post',contentType:false,
				processData:false, enctype:'multipart/form-data',
				success: function(data) {
					alert("댓글이 작성되었습니다");
					// $('form').hide();
					// $('#disp').html(data);
				}
			});
		});
	});
	function del() {
		// 확인을 check하면 true이고 취소를 체크하면 false;
		var ch = confirm("정말로 삭제하시겠습니까 ?");
		if (ch) location.href="bdDelete.do?bno=${board.bno }&pageNum=${pageNum}";
		else alert("삭제가 취소 되었습니다");
	}
</script>

</head><body>

<section class="main" style="size: 1000px;">
	<div class="wrapper">
		<div class="left-col">
			<div class="post">
				<div class="info">
			    	<div class="user" style="flex-direction: column;">
				    	<h2>여행게시판</h2>
						<p>${board.loc }</p>
			            <p class="username">${board.title }</p>
			            <div class="reaction-wrapper">
	                    	<img src="${path }/resources/images/img/comment.PNG" class="icon" alt=""><p class="likes">1,012 likes</p>
                        	<img src="${path }/resources/images/img/send.PNG" class="icon" alt=""><p class="likes">${board.readcount } readcount</p>
                    	</div>
                    	<div>
                    		<p class="username">${board.nickName }</p>
                    		<p class="post-time">${board.reg_date }</p>
                    	</div>
			        </div>
			    </div>
			    <a href="bdView.do?bno=${board.bno }&pageNum=${pb.currentPage}"><img src="${path }/resources/course/${board.courseImg }" class="post-image" alt=""></a>
			    <div class="post-content">
                    <p class="description"><span>${board.title }</span></p>
                    
                    <div class="comment-wrapper">
                    	<p class="username"><span>${board.content }</span>
                </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="container" align="center">
	<h2 class="text-primary">게시글 상세 내역</h2>
	<table class="table table-bordered table-striped">
		<tr><td>제목</td><td>${board.title }</td>
			<td>조회수</td><td>${board.readcount }</td></tr>
		<tr><td>작성자</td><td>${board.nickName }</td>
			<td>작성일</td><td>${board.reg_date }</td></tr>
		<tr><td>내용</td><td colspan="3"><pre>${board.content }</pre></td></tr>
		<tr><td colspan="4" align="center">
			<a href="bdList.do?pageNum=${pageNum }" class="btn btn-info">게시글 목록</a>
			<c:if test="${board.id == id}">
				<a href="bdUpdateForm.do?bno=${board.bno }&pageNum=${pageNum}" class="btn btn-warning">수정</a>
			</c:if>
			<c:if test="${board.id == id}">
				<a class="btn btn-danger" onclick="del()">삭제</a>
			</c:if>
	</table>
	<h2 class="text-primary">댓글 작성</h2>
	<!-- submit할 때 action에 값이 없으면 자신(view.do)을 한번 더 수행 -->
	<form action="" method="post" enctype="multipart/form-data" name="frm1" id="frm1">
		<input type="hidden" name="bno" value="${board.bno }">
		<input type="hidden" name="mno" value="${member.mno }">
		<input type="hidden" name="nickName" value="${member.nickName }">
		<table class="table table-hover">
			 	<tr><th>작성자</th><td>${member.nickName }</td>
				<td>댓글</td><td><textarea rows="3" cols="30" name="reply_content"></textarea></td></tr>
				<tr><td>사진 <span class="glyphicon glyphicon-picture"></span></td>
					<td><input type="file" name="file" multiple="multiple"></td></tr>
				<tr><td><input type="button" value="댓글 입력" id="rInsert"></td></tr>		
		</table>
	</form>
	
	<div id="rvListDisp"></div>
</div>

</body>
</html>