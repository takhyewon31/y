<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="moviedam.member.MemberDBBean" %>

<% request.setCharacterEncoding("utf-8");%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "회원 가입 완료";
	String mem_year = request.getParameter("mem_year");
	String mem_month = request.getParameter("mem_month");
	String mem_day = request.getParameter("mem_day");
%>

<jsp:useBean id="member" class="moviedam.member.MemberDataBean">
     <jsp:setProperty name="member" property="*"/>
</jsp:useBean>

<%
	member.setMem_status(0); //0:회원, 1:탈퇴회원
	member.setMem_birth(mem_year+mem_month+mem_day);
	member.setJoin_date(new Timestamp(System.currentTimeMillis()));
	member.setMem_type(0); //0:회원, 1:관리자
	
	MemberDBBean mem_insert = MemberDBBean.getInstance();
	mem_insert.insertMember(member);
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

<div class="container">
	<h3>
		<%=title %>
		<small class="text-muted">Sign Up Complete</small>
	</h3>
	<div class="alert alert-dismissible alert-info">
		<strong><%=member.getMem_name() %></strong>님 회원 가입이 완료되었습니다.
	</div>
	<div class="form-group col">
		<div class="input-group mb-3">
			<a href="../main.jsp" type="button" class="btn btn-primary">메인페이지로 이동</a>
			<a href="./login_form.jsp" type="button" class="btn btn-info">로그인</a>
		</div>
		<div class="col-sm-2 col-xs-4"></div>
	</div>
</div>
		
		
<jsp:include page="/module/footer.jsp" flush="false"/>

</body>
</html>
	