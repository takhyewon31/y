<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="moviedam.debate.ChanbanCommentDBBean"%>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>


<% 
String pageNum = request.getParameter("pageNum");

int cb_id = Integer.parseInt(request.getParameter("cb_cmt_ref"));
int cb_cmt_id = Integer.parseInt(request.getParameter("cb_cmt_id"));
String id = request.getParameter("userid");

ChanbanCommentDBBean dbPro = ChanbanCommentDBBean.getInstance(); 
int check = dbPro.deleteChanbanCmt(cb_cmt_id, id);
	
%>
<head>
	<meta http-equiv="Refresh" content="0;url=chanban_content.jsp?cb_id=<%=cb_id%>&pageNum=<%=pageNum%>">
</head>
<body>

</body>
</html>