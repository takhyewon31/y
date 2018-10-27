<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="moviedam.board.ArticleDBBean"%>
<%@ page import="moviedam.board.ArticleDataBean"%>
<%@ page import="moviedam.board.ArticlelikeDataBean"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="like" class="moviedam.board.ArticlelikeDataBean">
<jsp:setProperty property="*" name="like" />
</jsp:useBean>

<%
	int board_id = Integer.parseInt(request.getParameter("board_id"));
	int article_id = Integer.parseInt(request.getParameter("article_id"));
	String mem_id = request.getParameter("mem_id");
	String like_type = request.getParameter("currentLike");
	JSONObject jsonobj = new JSONObject();
	
	if(!mem_id.equals("")){ 
		like.setMem_id(mem_id);
		like.setLike_type(like_type);
		
		ArticleDBBean like_db = ArticleDBBean.getInstance();
		String ltype = like_db.insertLike(like);
		int lcount = like_db.getlikeCount(board_id, article_id);
		jsonobj.put("ltype", ltype);
		jsonobj.put("lcount", lcount);

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