<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "moviedam.debate.ChanbanDBBean" %>
<%@ page import = "moviedam.member.MemberDBBean" %>
<%@ page import = "moviedam.member.MemberDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  int cb_id = Integer.parseInt(request.getParameter("cb_id"));
  String pageNum = request.getParameter("pageNum");
  String userid = (String)session.getAttribute("userid");
  
  MemberDBBean member_db = MemberDBBean.getInstance();
  MemberDataBean profile = member_db.getProfile(userid);

  ChanbanDBBean cb_db = ChanbanDBBean.getInstance(); 
  int check = cb_db.deleteChanban(cb_id,userid);

  if(check==1){
%>
	<meta http-equiv="Refresh" content="0;url=debate_chanban.jsp?pageNum=<%=pageNum%>">
<%}else{%>
    <script type="text/javascript">      
       <!--      
         alert("작성자만 삭제할 수 있습니다.");
         history.go(-2);
       -->
   </script>
<%} %>