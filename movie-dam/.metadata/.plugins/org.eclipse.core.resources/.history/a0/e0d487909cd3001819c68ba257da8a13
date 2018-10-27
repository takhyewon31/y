<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="moviedam.member.FollowDataBean"%>
<%@ page import="moviedam.member.FollowDBBean"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="follow" class="moviedam.member.FollowDataBean">
<jsp:setProperty property="*" name="follow" />
</jsp:useBean>

<%
	String mem_id = request.getParameter("mem_id");
	String target_mem_id = request.getParameter("target_mem_id");
	String fol_type = request.getParameter("currentFolType");
	JSONObject jsonobj = new JSONObject();
	
	if(!mem_id.equals("") || mem_id.length() != 0) {
		follow.setMem_id(mem_id);
		follow.setTarget_mem_id(target_mem_id);
		follow.setFol_type(fol_type);
		
		FollowDBBean fol_db = FollowDBBean.getInstance();
		String ftype = fol_db.following(follow);
		int follower_cnt = fol_db.getFollowerCount(target_mem_id);
		jsonobj.put("ftype", ftype);
		jsonobj.put("follower_cnt", follower_cnt);
		
		response.setContentType("application/json");
    	response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonobj);
	} else {
%>
	<script>
		alert('로그인을 해주세요.');
		location.href = '/movie-dam/member/login_form.jsp';
	</script>
<%
	}
	
%>