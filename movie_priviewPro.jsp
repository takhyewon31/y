<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "moviedam.board.ArticleDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%

	String fileName = ""; //서버에 저장된 파일 이름
	String uploadPath = getServletContext().getRealPath("/imageFolder"); //파일을 저장할 서버의 경로
	int maxSize = 5*1024*1024; //5MB
	
	MultipartRequest multi = null;
	
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
 
<%
	//게시판 구분
	int board_id = Integer.parseInt(multi.getParameter("board_id"));
	
	//가져올 데이터
	String article_title = multi.getParameter("article_title");
	Datetime preview_date = multi.getParameter("preview_date");
	String preview_region = multi.getParameter("preview_region");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	String original_url = multi.getParameter("original_url");
	String cinema = multi.getParameter("cinema");

	if(board_id == 4) { //시사회
		String category = multi.getParameter("category");
	    preview.setArticle_title(article_title);
	    preview.setPreview_date(preview_date);
	    preview.setPreview_region(preview_region);
	    preview.setReg_date(new Timestamp(System.currentTimeMillis()) );
	    preview.setPreview_original_url(original_url);
	    preview.setPreview_cinema(cinema);
	    preview.setCategory(영화카테고리); 
	    
	    ArticleDBBean article_db = ArticleDBBean.getInstance();
	    article_db.insertArticle(article); 
	    response.sendRedirect("./movie_preview.jsp");
	} 
%>