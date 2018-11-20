<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="moviedam.board.ArticleDBBean" %>
<%@ page import="moviedam.board.ArticleDataBean" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="moviedam.board.RestaurantDBBean" %>
<%@ page import="moviedam.board.RestaurantDataBean" %>
<%@ page import="moviedam.member.MemberDataBean" %>
<%@ page import="moviedam.member.MemberDBBean" %>
<%
	request.setCharacterEncoding("utf-8");
	String title = "영화담";
%>
<%
	ArrayList<ArticleDataBean> articleList = null; 
	ArticleDBBean article_db = ArticleDBBean.getInstance();
	articleList = article_db.getTopArticles(); 
	
	List<RestaurantDataBean> restaurantList = null;   
	RestaurantDBBean restaurant_db = RestaurantDBBean.getInstance();
	restaurantList = restaurant_db.getTopArticles();
	
	MemberDBBean mem_db = MemberDBBean.getInstance(); 
%>
<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<!-- 
<section class="dorne-welcome-area bg-img bg-overlay"style="background-image: url(/movie-dam/assets/img/bg-img/coverlg_home.jpg);">
    <div class="container h-100">
        <div class="row h-100 align-items-center justify-content-center">
            <div class="col-12 col-md-10">
                <div class="hero-content">
                    <h2>라라랜드 같은 로맨스 영화</h2>
                    <h4>최신 로맨스 영화 보러 갈래?</h4>
                    <button type="submit" class="btn dorne-btn" onclick="location.href='/movie-dam/movie/movie_list.jsp?resultPage=1&sort=vote_count&with_genres=10749' "><i class="fa fa-search pr-2" aria-hidden="true"></i> 보러가기</button>
				</div>
			</div>
		</div>
    </div>
</section>
-->

<div id="mainCarousel" class="carousel slide" data-ride="carousel">
	<ol class="carousel-indicators">
		<li data-target="#mainCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#mainCarousel" data-slide-to="1"></li>
		<!-- <li data-target="#mainCarousel" data-slide-to="2"></li> -->
	</ol>
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img class="d-block w-100 dorne-welcome-area bg-img bg-overlay" src="/movie-dam/assets/img/bg-img/coverlg_home.jpg" alt="First slide">
			<div class="carousel-content-1 d-none d-md-block">
			    <p class="display-3 mb-4">라라랜드 같은 로맨스 영화</p>
			    <p class="mb-4 h5">19개의 다양한 장르 별로 찾아볼 수 있는 영화 목록</p>
			    <button type="button" class="btn dorne-btn" onclick="location.href='/movie-dam/movie/movie_list.jsp?resultPage=1&sort=vote_count&with_genres=10749'"><i class="ni ni-active-40" aria-hidden="true"></i> MORE</button>
			</div>
		</div>
		<div class="carousel-item">
			<img class="d-block w-100 dorne-welcome-area bg-img bg-overlay" src="/movie-dam/assets/img/bg-img/hero-3.jpg" alt="Second slide">
			<div class="carousel-content-2">
            	<div class="container">
	            	<div class="row">
	            		<div class="col">
	            			내용1
	            		</div>
	            		<div class="col">
	            			내용2
	            		</div>
	            		<div class="col">
	            			내용3
	            		</div>
	            	</div>
	            	<div class="row">
	            		<div class="col">
	            			내용1
	            		</div>
	            		<div class="col">
	            			내용2
	            		</div>
	            		<div class="col">
	            			내용3
	            		</div>
	            	</div>
            	</div>
            </div>
        </div>
		<!-- <div class="carousel-item">
			<img class="d-block w-100 dorne-welcome-area bg-img bg-overlay" src="/movie-dam/assets/img/bg-img/coverlg_home.jpg" alt="Third slide">
		</div> -->
	</div>
	<!-- <a class="carousel-control-prev" href="#mainCarousel" role="button" data-slide="prev"> 
		<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
		<span class="sr-only">Previous</span>
	</a> 
	<a class="carousel-control-next" href="#mainCarousel" role="button" data-slide="next"> 
		<span class="carousel-control-next-icon" aria-hidden="true"></span> 
		<span class="sr-only">Next</span>
	</a> -->
</div>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="/movie-dam/assets/js/jquery/jquery-2.2.4.min.js"></script>
<script src="/movie-dam/assets/js/bootstrap/popper.min.js"></script>
<script src="/movie-dam/assets/js/bootstrap/bootstrap.min.js"></script>
<script src="/movie-dam/assets/js/argon.min.js"></script>
<script src="/movie-dam/assets/js/others/plugins.js"></script>
<script src="/movie-dam/assets/js/active.js"></script>
<script src="/movie-dam/assets/js/bootstrap-datepicker.min.js"></script>
<script src="/movie-dam/assets/js/summernote-lite.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>

<script>
$('.carousel').carousel();
$('#mainCarousel').bind('mousewheel', function(e){
  if(e.originalEvent.wheelDelta /120 > 0) {
    $(this).carousel('prev');
  }
  else{
    $(this).carousel('next');
  }
});
</script>

</body>
</html>