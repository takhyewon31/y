<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="moviedam.debate.ChanbanCommentDBBean"%>
<%@ page import="moviedam.debate.ChanbanCommentDataBean"%>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="cb_cmt" class="moviedam.debate.ChanbanCommentDataBean"/>
    <jsp:setProperty property="*" name="cb_cmt"/>
<%
	int cb_id = Integer.parseInt(request.getParameter("cb_id"));
	String pageNum = request.getParameter("pageNum");

	ChanbanCommentDBBean dbPro = ChanbanCommentDBBean.getInstance();
    int check = dbPro.updateChanbanCmt(cb_cmt);

    if(check==1){
%>

<meta http-equiv="Refresh" content="0;url=chanban_content.jsp?cb_id=<%=cb_id%>&pageNum=<%=pageNum%>">
<%}else{%>
    <script>      
		alert("수정을 실패하였습니다.");
		history.go(-1);
   </script>
<%} %>