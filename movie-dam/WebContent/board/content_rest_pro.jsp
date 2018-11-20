<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "moviedam.board.CommentRestDBBean" %>
<%@ page import = "moviedam.board.CommentRestDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>
    
    
    <jsp:useBean id="cmtdto" class="moviedam.board.CommentRestDataBean"/>
    <jsp:setProperty property="*" name="cmtdto"/>
    
    
    <%
    	cmtdto.setCmt_date(new Timestamp(System.currentTimeMillis()) );
    		
        int article_id = Integer.parseInt(request.getParameter("cmt_ref"));
    	String pageNum = request.getParameter("pageNum");
    	int board_id = Integer.parseInt(request.getParameter("board_id"));
    	String theater = request.getParameter("theater");
    	
    	CommentRestDBBean cmt = CommentRestDBBean.getInstance();
    	cmt.insertComment(cmtdto);
    %>

<head>
<meta http-equiv="Refresh" content="0;url=content_rest.jsp?article_id=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>&theater=<%=theater%>">

</head>
<body>

</body>
</html>