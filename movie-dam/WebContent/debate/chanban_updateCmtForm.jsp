<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="moviedam.debate.ChanbanCommentDBBean"%>
<%@ page import="moviedam.debate.ChanbanCommentDataBean"%>
	
<% request.setCharacterEncoding("utf-8"); %>
<%

	String pageNum = request.getParameter("pageNum");
	int cb_id = Integer.parseInt(request.getParameter("cb_id"));
	int cb_cmt_id = Integer.parseInt(request.getParameter("cb_cmt_id"));

	ChanbanCommentDBBean dbPro = ChanbanCommentDBBean.getInstance(); 
	ChanbanCommentDataBean content = dbPro.getChanbanCmt(cb_cmt_id);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=charset=UTF-8">
<title>댓글 수정</title>
<!-- Summernote CSS -->
<link rel="stylesheet" href="/movie-dam/assets/css/summernote-0.8.9/summernote-lite.css" rel="stylesheet">
</head>
<body>
<div>
	<b><font color="blue">댓글 수정</font></b>
	<hr>
	
	<form name="updatecomment" method="post">
		<input type="hidden" name="cb_cmt_ref" value="<%=content.getCb_cmt_ref()%>">
		<div>
			<textarea class="form-control summernote" name="cb_cmt_content"><%=content.getCb_cmt_content() %></textarea>
		</div>
		<hr>
		<input type="button" value="취소" onclick="cancelUpdate()">
		<input type="submit" value="수정" onclick="saveUpdate()">
	</form>
</div>

<jsp:include page="/module/footer.jsp" flush="false" />

<script>
$(document).ready(function() {
	  $('.summernote').summernote({
		  height:150
	  });

});
 </script>

<script>
	function saveUpdate() {
		opener.name='updateCmt';
		document.updatecomment.target = opener.name;
		document.updatecomment.action = 'chanban_updateCmtPro.jsp?cb_cmt_id=<%=cb_cmt_id%>&cb_id=<%=cb_id%>&pageNum=<%=pageNum%>';
		document.updatecomment.submit();
		self.close();
	}
	function cancelUpdate() {
		self.close();
	}
</script>
</body>
</html>