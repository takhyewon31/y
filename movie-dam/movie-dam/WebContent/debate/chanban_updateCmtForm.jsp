<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "moviedam.board.CommentDBBean" %>
<%@ page import = "moviedam.board.CommentDataBean" %>
	
<% request.setCharacterEncoding("utf-8"); %>
<%

	String pageNum = request.getParameter("pageNum");
	int article_id = Integer.parseInt(request.getParameter("article_id"));
	int cmt_id = Integer.parseInt(request.getParameter("cmt_id"));
	int board_id = Integer.parseInt(request.getParameter("board_id"));
	String category = request.getParameter("category");

	CommentDBBean dbPro = CommentDBBean.getInstance(); 
	CommentDataBean content = dbPro.getComment(cmt_id);
%>
<div>
	<b><font color="blue">댓글 수정</font></b>
	<hr>
	
	<form name="updatecomment" method="post">
		<input type="hidden" name="cmt_ref" value="<%=content.getCmt_ref()%>">
		<div>
			<textarea rows="2" cols="40" class="form-control" name="cmt_content" maxlength="100"><%=content.getCmt_content() %></textarea>
		</div>
		<hr>
		<input type="button" value="취소" onclick="cancelUpdate()">
		<input type="submit" value="수정" onclick="saveUpdate()">
	</form>
</div>

<script>
	function saveUpdate() {
		opener.name='updateCmt';
		document.updatecomment.target = opener.name;
		document.updatecomment.action = 'updateCommentPro.jsp?cmt_id=<%=cmt_id%>&article_id=<%=article_id%>&pageNum=<%=pageNum%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>&category=<%=category%>';
		document.updatecomment.submit();
		self.close();
	}
	function cancelUpdate() {
		self.close();
	}
</script>