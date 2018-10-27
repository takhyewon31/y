<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="moviedam.member.MemberDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
    String mem_userid = request.getParameter("mem_userid");
	String mem_pwd  = request.getParameter("mem_pwd"); 
	String saveId = request.getParameter("saveId"); //checkbox
	Cookie idCookie = null;
	
	MemberDBBean logon = MemberDBBean.getInstance();
    int check= logon.userCheck(mem_userid, mem_pwd); 

    if(check==1){
		if(saveId != null) { //체크박스 체크상태
			idCookie = new Cookie("userid", mem_userid);
			idCookie.setMaxAge(60*60*24);
		}
		else {
			idCookie = new Cookie("userid", "");
			idCookie.setMaxAge(0);
		}
		response.addCookie(idCookie);
		session.setAttribute("userid", mem_userid);
		response.sendRedirect("/movie-dam/main.jsp");
	} else {
%>
    <script> 
	  alert("아이디 혹은 비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%	} %>