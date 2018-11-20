<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "moviedam.board.ArticleDBBean" %>
<%@ page import = "moviedam.board.RestaurantDBBean" %>
<%@ page import = "moviedam.member.MemberDBBean" %>
<%@ page import = "moviedam.member.MemberDataBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
	MultipartRequest multi = null;
	//게시판 구분
	int board_id = Integer.parseInt(request.getParameter("board_id"));
	String uploadPath = "";
	String fileName = ""; //서버에 저장된 파일 이름
	if (board_id == 1) {
		uploadPath = getServletContext().getRealPath("/imageFolder/free_board"); //파일을 저장할 서버의 경로
	} else if (board_id == 2) {
		uploadPath = getServletContext().getRealPath("/imageFolder/cinema_restaurant");
	} else if (board_id == 4) {
		uploadPath = getServletContext().getRealPath("/imageFolder/movie_preview");
	} else if (board_id == 5) {
		uploadPath = getServletContext().getRealPath("/imageFolder/movie_issue");
	}
	int maxSize = 5*1024*1024; //5MB
	
	try {
		//파일업로드 (request, 파일 저장경로, 용량, 인코딩타입, 중복 파일명에 대한 기본 정책)
		multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
		//파일 정보 가져와 출력
		Enumeration <?> files = multi.getFileNames();
		while(files.hasMoreElements()) {
			String name = (String)files.nextElement();
			fileName = multi.getFilesystemName(name);
		}
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>

<jsp:useBean id="article" scope="page" class="moviedam.board.ArticleDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<jsp:useBean id="restaurant" scope="page" class="moviedam.board.RestaurantDataBean">
   <jsp:setProperty name="restaurant" property="*"/>
</jsp:useBean>
<jsp:useBean id="preview" scope="page" class="moviedam.board.PreviewDataBean">
   <jsp:setProperty name="preview" property="*"/>
</jsp:useBean>
<jsp:useBean id="issue" scope="page" class="moviedam.board.IssueDataBean">
   <jsp:setProperty name="issue" property="*"/>
</jsp:useBean>

<%

	String pageNum = request.getParameter("pageNum");
	int currentPage = Integer.parseInt(pageNum);
	String userid = (String)session.getAttribute("userid");
	
	//가져올 데이터
	String article_writer = multi.getParameter("article_writer");
	String article_title = multi.getParameter("article_title");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());

	if(board_id == 1) { //자유게시판
		String category = multi.getParameter("category");
		String article_content = multi.getParameter("article_content");

	    article.setArticle_title(article_title);
	    article.setArticle_content(article_content);
	    article.setArticle_file(fileName);
	    article.setCategory(category);
	    
	    ArticleDBBean article_db = ArticleDBBean.getInstance();
	    int check = article_db.updateArticle(article,userid); 
	    if(check==1){
%>
			<meta http-equiv="Refresh" content="0;url=content.jsp?board_id=<%=board_id %>&article_id=<%=article.getArticle_id()%>&pageNum=<%=currentPage%>&category=<%=category%>" >
<% 		} else { %>
			<script>   
				alert("작성자만 수정할 수 있습니다.");
		      	history.go(-2);
			</script>
<% 		} 
	} else if(board_id == 2) { //맛집게시판
		String search_loc = multi.getParameter("search_loc");
		String article_content = multi.getParameter("article_content");
		float start_lat = Float.parseFloat(multi.getParameter("start_lat"));
		float start_lon = Float.parseFloat(multi.getParameter("start_lon"));
		String theater = multi.getParameter("theater");
		String area = multi.getParameter("area");
		
		restaurant.setArticle_writer(article_writer);
		restaurant.setArticle_title(article_title);
		restaurant.setArticle_content(article_content);
		restaurant.setArticle_file(fileName);
		restaurant.setReg_date(reg_date);
		restaurant.setSearch_loc(search_loc);
		restaurant.setStart_lat(start_lat);
		restaurant.setStart_lon(start_lon);
		restaurant.setTheater(theater);
		restaurant.setArea(area);
		
		RestaurantDBBean restaurant_db = RestaurantDBBean.getInstance();
		int check = restaurant_db.updateArticle(restaurant, userid);
		if(check==1){
%>
			<meta http-equiv="Refresh" content="0;url=content_rest.jsp?board_id=<%=board_id %>&article_id=<%=article.getArticle_id()%>&pageNum=<%=currentPage%>&theater=<%=theater%>" >
<% 		} else { %>
			<script>   
				alert("작성자만 수정할 수 있습니다.");
		      	history.go(-2);
			</script>
<% 		} 
	}	

%>