<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*"%>    
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="moviedam.board.CommentRestDBBean" %>
<%@ page import="moviedam.board.CommentRestDataBean" %>
<%@ page import="moviedam.board.RestaurantDBBean" %>
<%@ page import="moviedam.board.RestaurantDataBean" %>
<%
	request.setCharacterEncoding("utf-8");
	String title = "영화관 맛집";
	String pageNum = request.getParameter("pageNum");
    String option = request.getParameter("option");
    String search = request.getParameter("search");
%>
<%!
    int pageSize = 9;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int ccount = 0;
	int number = 0;
	int total_page = 0;
	List<RestaurantDataBean> articleList = null; 
    
	try {
	RestaurantDBBean restaurant_db = RestaurantDBBean.getInstance();
    
    ArrayList<CommentRestDataBean> commentList = null;
	CommentRestDBBean comment_db = CommentRestDBBean.getInstance();
	
  	count = restaurant_db.getArticleCount(); 
    if (count > 0) {
       	articleList = restaurant_db.getArticles(startRow, endRow, option, search);
	}  
    
	number = count-(currentPage-1)*pageSize;
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<!-- ***** Breadcumb Area Start ***** -->
<div class="breadcumb-area bg-img bg-overlay" style="background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)"></div>
<!-- ***** Breadcumb Area End ***** -->

<section class="dorne-single-listing-area section-padding-100">
<div class="container">
	<div class="row">
		<div class="col-12">
		    <div class="section-heading dark text-center">
		    	<span></span>
				<h4>Cinema restaurant</h4>
				<p>검색된 글 : <%=count%>개</p>
			</div>
		</div>
	</div>
	<a class="btn btn-sm btn-outline-secondary" href="writeForm.jsp?board_id=2&article_writer=${sessionScope.userid}" role="button" >글쓰기</a>
	<div class="row justify-content-center">
		<div class="col-12">
			<form>
				<label class="control-label">게시글 검색</label>
				<div class="form-group">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<select class="form-control" name="option">
						        <option value="all">전체글</option>
						        <option value="article_title">제목</option>
						        <option value="article_content">내용</option>
						        <option value="article_writer">작성자</option>
					        </select>
						</div>
						<input class="form-control" type="text" name="search" placeholder="궁금한 것을 검색해보세요">
						<div class="input-group-append">
							<input class="btn btn-outline-secondary" type="submit" value="검색"> 
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	
		
<% if (count == 0) { %>

	<div class="alert alert-danger" role="alert">
	  게시판에 저장된 글이 없습니다.
	</div>

<% } else {%>

	<div class="row">
	
	<%  
		int a = count / pageSize + (count % pageSize == 0 ? 0 : 1); //전체페이지 수 
		
		if(Integer.parseInt(pageNum) > a){ %>
			<jsp:forward page="error.jsp"/>
		<% }
		
	   for (int i = 0 ; i < articleList.size() ; i++) {
		  RestaurantDataBean article = articleList.get(i);
		   
	       ccount = comment_db.getCommentCount(article.getArticle_id());
	%>
			<div class="col-12 col-sm-6 col-lg-4">
				<div class="single-features-area mb-50">
					<a href="content_rest.jsp?article_id=<%=article.getArticle_id()%>&pageNum=<%=currentPage%>&board_id=2"><img style="width:100%; height:250px; display:block;" src="/movie-dam/imageFolder/cinema_restaurant/<%=article.getArticle_file()%>" alt="저장된 사진이 없습니다."></a>
					<div class="feature-content d-flex align-items-center justify-content-between">
					<div class="feature-title"><h5><a href="content_rest.jsp?article_id=<%=article.getArticle_id()%>&pageNum=<%=currentPage%>&board_id=2"><%=number--%>) <%=article.getArticle_title()%><small>(<%=ccount%>)</small></a></h5>
						<p>글쓴이 | <%=article.getArticle_writer() %></p>
						<p>작성일 | <%=sdf.format(article.getReg_date())%></p>
						<div class="feature-favourite"><a href="#"><i class="fa fa-heart-o" aria-hidden="true"></i></a></div>
					</div>
					</div>
				</div>
			</div>

	<%	} %>

</div>
		
<%}%>

<nav aria-label="Page navigation">
	<ul class="pagination justify-content-center">
<%
    if (count > 0) {
    	//전체 페이지수 구하기//50개=>5페이지, 51~59개=>6페이지
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        
    	if(pageCount < currentPage){
    		currentPage = pageCount;
    	}
       	//한 페이지에 보여지는 시작페이지 구하기
		int startPage =1;
		
		if(currentPage % 10 != 0)
           startPage = (int)(currentPage/10)*10 + 1;
		else
           startPage = ((int)(currentPage/10)-1)*10 + 1; 
           
        int pageBlock = 10; //한 페이지에 보여줄 페이지수 설정
        
		//한 페이지에 보여지는 끝페이지 구하기
		int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) {
        	endPage = pageCount; 
        } 
        
        
        if (startPage > 10) { %>
    	<li class="page-item"><a class="page-link" href="cinema_restaurant.jsp?pageNum=<%=startPage - 10 %>">이전</a></li>
<%      }
    
    for (int i = startPage ; i <= endPage ; i++) {
    	if(i == currentPage) {
%>
		<li class="page-item active">
	      <a class="page-link" href="cinema_restaurant.jsp?pageNum=<%=i %>"><%=i %> <span class="sr-only">(current)</span></a>
	    </li>
<%        		
    	} else {
%>	
		<li class="page-item"><a class="page-link" href="cinema_restaurant.jsp?pageNum=<%=i %>"><%=i %></a></li>
<%        		
    	}
  }
    
    if (endPage < pageCount) {  %>
    	<li class="page-item"><a class="page-link" href="cinema_restaurant.jsp?pageNum=<%=startPage + 10 %>">다음</a></li>
<%
    }
}
%>
	</ul>
</nav>
<%
} catch (Exception e) { }
 %>

</div>
</section>

<jsp:include page="/module/footer.jsp" flush="false" />

</body>
</html>