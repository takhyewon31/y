<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "moviedam.debate.ChanbanCommentDBBean" %>
<%@ page import = "moviedam.debate.ChanbanCommentDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>
       
    <jsp:useBean id="cb_cmt" class="moviedam.debate.ChanbanCommentDataBean"/>
    <jsp:setProperty property="*" name="cb_cmt"/>
    
<%
    	cb_cmt.setCb_cmt_date(new Timestamp(System.currentTimeMillis()) );
    		
        int cb_id = Integer.parseInt(request.getParameter("cb_cmt_ref"));
    	String pageNum = request.getParameter("pageNum");
    	
    	
    	
    	ChanbanCommentDBBean cmt = ChanbanCommentDBBean.getInstance();
    	cmt.insertChanbanCmt(cb_cmt);
%>

<head>
<meta http-equiv="Refresh" content="0;url=chanban_content.jsp?cb_id=<%=cb_id%>&pageNum=<%=pageNum%>">
</head>
<body>

</body>
</html>