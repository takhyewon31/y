<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "moviedam.board.CommentDBBean" %>
<%@ page import = "moviedam.board.CommentDataBean" %>
<%@ page import = "moviedam.board.CommentRestDBBean" %>
<%@ page import = "moviedam.board.CommentRestDataBean" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="cmtdto" class="moviedam.board.CommentDataBean"/>
    <jsp:setProperty property="*" name="cmtdto"/>
<jsp:useBean id="cmtrestdto" class="moviedam.board.CommentRestDataBean"/>
    <jsp:setProperty property="*" name="cmtrestdto"/>
<%
	int article_id = Integer.parseInt(request.getParameter("cmt_ref"));
	String pageNum = request.getParameter("pageNum");
	int board_id = Integer.parseInt(request.getParameter("board_id"));
	String category = request.getParameter("category")==null ? "" : request.getParameter("category");
	int check = 0;
	
	if(category.equals("") || category == null) {
		CommentRestDBBean dbPro = CommentRestDBBean.getInstance();
	    check = dbPro.updateComment(cmtrestdto); 
	} else {
		CommentDBBean dbPro = CommentDBBean.getInstance();
	    check = dbPro.updateComment(cmtdto); 
	}

    if(check==1){
    	if(category.equals("") || category == null) {
%>
    		<meta http-equiv="Refresh" content="0;url=content_rest.jsp?article_id=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>">
<%		} else { %>
    		<meta http-equiv="Refresh" content="0;url=content.jsp?article_id=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>&category=<%=category%>">
<%  	} 
 	} else { %>
    	<script>      
			alert("수정을 실패하였습니다.");
			history.go(-1);
   		</script>
<%	} %>