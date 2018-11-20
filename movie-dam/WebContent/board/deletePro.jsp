<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "moviedam.board.ArticleDBBean" %>
<%@ page import = "moviedam.board.RestaurantDBBean" %>
<%@ page import = "moviedam.member.MemberDBBean" %>
<%@ page import = "moviedam.member.MemberDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  	int article_id = Integer.parseInt(request.getParameter("article_id"));
  	int board_id = Integer.parseInt(request.getParameter("board_id"));
  	String pageNum = request.getParameter("pageNum");
  	String userid = (String)session.getAttribute("userid");

	if(board_id == 1) { //자유게시판
		ArticleDBBean dbPro = ArticleDBBean.getInstance(); 
		int check = dbPro.deleteArticle(article_id,userid);

  		if(check==1){
%>
			<meta http-equiv="Refresh" content="0;url=free_board.jsp?board_id=<%=board_id%>&category=all&pageNum=<%=pageNum%>">
<%		}else{%>
		    <script type="text/javascript">      
		       <!--      
		         alert("작성자만 삭제할 수 있습니다.");
		         history.go(-2);
		       -->
		   	</script>
<%
		} 
	} else if(board_id == 2) {
		RestaurantDBBean dbPro = RestaurantDBBean.getInstance();
		int check = dbPro.deleteArticle(article_id,userid);
		
		if(check==1){
%>
			<meta http-equiv="Refresh" content="0;url=cinema_restaurant.jsp?board_id=<%=board_id%>&theater=all&pageNum=<%=pageNum%>">
<% 
		} else {
%>
			<script type="text/javascript">      
		       <!--      
		         alert("작성자만 삭제할 수 있습니다.");
		         history.go(-2);
		       -->
		   	</script>
<%
		}
	}
%>