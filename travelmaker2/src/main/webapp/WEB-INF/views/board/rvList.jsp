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
@import url("${path}/resources/css/view.css");
</style>
<script type="text/javascript"
	src="${path}/resources/bootstrap/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<script type="text/javascript">
	function rDelete(bno, rno) {
		var sendData = "bno="+bno+"&rno="+rno;
		$.post("rDelete.do", sendData, function(data) {
			Swal.fire({
				  title: '삭제되었습니다',
				  width: 600,
				  padding: '3em',
				  color: '#716add',
				  background: '#fff url(${path }/resources/images/alert.png)',
				  backdrop: 'rgba(40,23,100,0.1)',
				  closeOnClickOutside : false
			});
			$("#rvListDisp").html(data);
		});
	}
	function rUpdate(bno, rno) {
	/*  input에 있는 데이터를 읽어서 textarea에 넣어서 변경할 수 있게 만들어야 한다
		input, textarea, select에 데이터를 읽을 때는 jquery에서 val()
		td, div, span등에서 데이터를 읽을 때는 jquery에서 text() */
		var txt = $('#td_'+rno).text();
		/* 읽은 데이터를 textarea에 넣어서 수정할 수 있게 만든다 */
		$('#td_'+rno).html('<textarea rows="5" cols="38" id="rt">'+txt+'</textarea>');
		/* 버튼 처리를 확인과 취소로 변경 */
		$('#btn_'+rno).html("<input type='button' onclick='lst("+bno+")' class='btn5' value='취소'>"+
			"<input type='button' onclick='up("+bno+","+rno+")' class='btn5' value='확인'> ");
	}
	function lst(bno) {
		$('#rvListDisp').load("rvList.do", "bno=${board.bno}");
	}
	function up(bno, rno) {
		var sendData = "reply_content="+$('#rt').val()+"&bno="+bno+"&rno="+rno;
		$.post('rUpdate.do', sendData, function(data) {
			Swal.fire({
				  title: '수정되었습니다',
				  width: 600,
				  padding: '3em',
				  color: '#716add',
				  background: '#fff url(${path }/resources/images/alert.png)',
				  backdrop: 'rgba(40,23,100,0.1)',
				  closeOnClickOutside : false
			});
			$('#rvListDisp').html(data);
		});
	}
</script>
</head>
<body>
	<c:if test="${not empty rvList }">
		<c:forEach var="rv" items="${rvList }">
			<c:choose>
				<c:when test="${rv.del == 'n' }">
					<div class="border_gray">
						<table class="rvTable" style="table-layout: fixed;">
							<tr>
								<td width="20%" class="nickNameTd">${rv.nickName }</td>
								<td class="btnTd" id="btn_${rv.rno }" colspan="2">
									<!-- 댓글 작성자와 로그인한 사람의 닉네임 비교해서 같으면 수정/삭제 권한 제공 --> <c:if
										test="${rv.nickName==member.nickName }">
										<input type="button" value="삭제" class="btn5"
											onclick="rDelete(${rv.bno},${rv.rno })">
										<input type="button" value="수정" class="btn5"
											onclick="rUpdate(${rv.bno},${rv.rno })">
									</c:if>
								</td>
								<td class="post-time">${rv.update_date}</td>
							</tr>
							<tr>
								<td></td>
								<td id="td_${rv.rno }" height="100" colspan="2" class="td1"><pre>${rv.reply_content }</pre></td>
							</tr>
						</table>
						<c:forEach var="reviewphoto" items="${rpList }">
							<c:if test="${reviewphoto.rno==rv.rno }">
								<img alt="${reviewphoto.imgName }"
									src="${path }/resources/upload/${reviewphoto.imgName }"
									width="130" height="130">
							</c:if>
						</c:forEach>
					</div>
				</c:when>
				<c:when test="${rv.del == 'a'}">
					<div class="border_gray">
						<table style="table-layout: fixed;">
							<tr>
								<td><span>관리자에&nbsp;의해&nbsp;삭제된&nbsp;리뷰입니다.</span></td>
							</tr>
						</table>
					</div>
				</c:when>
			</c:choose>
		</c:forEach>

	</c:if>
</body>
</html>