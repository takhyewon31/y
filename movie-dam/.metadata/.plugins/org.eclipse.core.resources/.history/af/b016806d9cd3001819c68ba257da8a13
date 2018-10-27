<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "moviedam.board.ArticleDBBean" %>
<%@ page import = "moviedam.board.RestaurantDBBean" %>
<%@ page import = "moviedam.board.PreviewDBBean" %>
<%@ page import = "moviedam.board.IssueDBBean" %>
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
	//가져올 데이터
	String article_writer = multi.getParameter("article_writer");
	String article_title = multi.getParameter("article_title");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());

	if(board_id == 1) { //자유게시판
		String category = multi.getParameter("category");
		String article_content = multi.getParameter("article_content");

	    article.setArticle_writer(article_writer);
	    article.setArticle_title(article_title);
	    article.setArticle_content(article_content);
	    article.setReg_date(reg_date);
	    article.setArticle_file(fileName);
	    article.setCategory(category);
	    
	    ArticleDBBean article_db = ArticleDBBean.getInstance();
	    article_db.insertArticle(article); 
	    response.sendRedirect("./free_board.jsp?pageNum=1&category=all");
	} else if(board_id == 2) { //맛집게시판
		String search_loc = multi.getParameter("search_loc");
		String article_content = multi.getParameter("article_content");
		float start_lat = Float.parseFloat(multi.getParameter("start_lat"));
		float start_lon = Float.parseFloat(multi.getParameter("start_lon"));
	
		restaurant.setArticle_writer(article_writer);
		restaurant.setArticle_title(article_title);
		restaurant.setArticle_content(article_content);
		restaurant.setArticle_file(fileName);
		restaurant.setReg_date(reg_date);
		restaurant.setSearch_loc(search_loc);
		restaurant.setStart_lat(start_lat);
		restaurant.setStart_lon(start_lon);
		
		RestaurantDBBean restaurant_db = RestaurantDBBean.getInstance();
		restaurant_db.insertArticle(restaurant);
		response.sendRedirect("./cinema_restaurant.jsp");
	} else if(board_id == 4) { //시사회
		String preview_date = multi.getParameter("preview_date");
		String cinema = multi.getParameter("cinema");
		String original_url = multi.getParameter("original_url");
		String preview_region = multi.getParameter("preview_region");
		
		preview.setArticle_title(article_title);
		preview.setPreview_date(preview_date);
		preview.setPreview_region(preview_region);
		preview.setReg_date(reg_date);
		preview.setOriginal_url(original_url);
		preview.setArticle_file(fileName);
		preview.setCinema(cinema);
		
		PreviewDBBean preview_db = PreviewDBBean.getInstance();
		preview_db.insertArticle(preview); 
	    response.sendRedirect("./movie_preview.jsp");
	} else if(board_id == 5) { //영화 이슈
		String original_url = multi.getParameter("original_url");
		
		issue.setArticle_title(article_title);
		issue.setReg_date(reg_date);
		issue.setOriginal_url(original_url);
		issue.setArticle_file(fileName);
		
		IssueDBBean issue_db = IssueDBBean.getInstance();
		issue_db.insertArticle(issue);
		response.sendRedirect("./movie_issue.jsp");
	}

%>