<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "moviedam.board.CommentDBBean" %>
<%@ page import = "moviedam.board.CommentDataBean" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="cmtdto" class="moviedam.board.CommentDataBean"/>
    <jsp:setProperty property="*" name="cmtdto"/>
<%
	int article_id = Integer.parseInt(request.getParameter("cmt_ref"));
	String pageNum = request.getParameter("pageNum");
	int board_id = Integer.parseInt(request.getParameter("board_id"));
	String category = request.getParameter("category");
	
	CommentDBBean dbPro = CommentDBBean.getInstance();
    int check = dbPro.updateComment(cmtdto); 

    if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=content.jsp?article_id=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>&category=<%=category%>">
<%}else{%>
    <script>      
		alert("수정을 실패하였습니다.");
		history.go(-1);
   </script>
<%} %>