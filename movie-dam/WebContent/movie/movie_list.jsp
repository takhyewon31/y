<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "영화 목록";
	String resultPage = request.getParameter("resultPage");
	if (resultPage == null || resultPage.length() == 0) {
		resultPage = "1";
	}
	String sort = request.getParameter("sort");
	if (sort == null || sort.length() == 0) {
		sort = "vote_count";
	}
	String with_genres = request.getParameter("with_genres");
	if (with_genres == null || with_genres.length() == 0) {
		with_genres = "";
	}
	String api_key = "9dd279523f7113a4103a8f1e9ef6abe3";
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<!-- ***** Breadcumb Area Start ***** -->
<div class="breadcumb-area bg-img bg-overlay" style="background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)"></div>
<!-- ***** Breadcumb Area End ***** -->

<!-- ***** Listing Destinations Area Start ***** -->
<section class="dorne-listing-destinations-area section-padding-100-50">
<div class="container">
	<div class="row">
        <div class="col-12">
            <div class="section-heading dark text-center">
                <span></span>
                <h4>Movie list</h4>
                <p id="lead"></p>
            </div>
        </div>
    </div>	

	<div class="row mb-3 mr-2 d-flex justify-content-end">
		<div class="dropdown mb-4">
			<button class="btn btn-dark dropdown-toggle" type="button" id="dropdownGenre" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    	장르
			</button>
	  		<div class="dropdown-menu" aria-labelledby="dropdownGenre" id="dropdownGenreList">
	  		</div>
		</div>
		
		<div class="dropdown mb-4">
			<button class="btn btn-dark dropdown-toggle" type="button" id="dropdownSort" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
				정렬
		  	</button>
		  	<div class="dropdown-menu" aria-labelledby="dropdownSort">
		    	<a class="dropdown-item" href="movie_list.jsp?resultPage=1&sort=vote_count">인기순</a>
				<a class="dropdown-item" href="movie_list.jsp?resultPage=1&sort=release_date">최근 개봉순</a>
				<a class="dropdown-item" href="movie_list.jsp?resultPage=1&sort=revenue">최고 흥행순</a>
		  	</div>
		</div>
	</div>

	<div class="row" id="showMovieList">
		
	</div>

	<!-- Pagination -->
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center">
			<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
			<li class="page-item active"><a class="page-link" href="movie_list.jsp?resultPage=1&sort=<%=sort%>&with_genres=<%=with_genres%>">1</a></li>
			<li class="page-item"><a class="page-link" href="movie_list.jsp?resultPage=2&sort=<%=sort%>&with_genres=<%=with_genres%>">2</a></li>
			<li class="page-item"><a class="page-link" href="movie_list.jsp?resultPage=3&sort=<%=sort%>&with_genres=<%=with_genres%>">3</a></li>
			<li class="page-item"><a class="page-link" href="movie_list.jsp?resultPage=4&sort=<%=sort%>&with_genres=<%=with_genres%>">4</a></li>
			<li class="page-item"><a class="page-link" href="movie_list.jsp?resultPage=5&sort=<%=sort%>&with_genres=<%=with_genres%>">5</a></li>
			<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
		</ul>
	</nav>
</div>
</section>


<jsp:include page="/module/footer.jsp" flush="false" />

<script>
var page = '<%=resultPage%>';
var sort = '<%=sort%>';
var genre = '<%=with_genres%>';
var api_key = '<%=api_key%>';
var response2 = [];

$(document).ready(function() {
	var rs = [];
	var settings = {
	  	async: true,
	  	crossDomain: true,
	  	url: 'https://api.themoviedb.org/3/discover/movie',
		method: 'GET',
	  	data: {
			'page': page,
		  	'include_video': 'false',
		  	'include_adult': 'false',
		  	'sort_by': sort+'.desc',
		  	'region': 'KR',
		  	'language': 'ko-KR',
		  	'with_genres': genre, 
		  	'api_key': '9dd279523f7113a4103a8f1e9ef6abe3'
	  	},
	  	dataType: 'json',
	  	headers: {}
	}

	$.ajax(settings).done(function (response) {
		console.log(response);
  		$('#lead').html('총 '+response.total_results+'개의 작품 검색');
  		
  		var settings2 = {
		  async: true,
		  crossDomain: true,
		  url: 'https://api.themoviedb.org/3/genre/movie/list',
		  method: 'GET',
		  headers: {},
		  data: {
			  'language': 'ko-KR',
			  'api_key': api_key
		  },
		  dataTypa: 'json'
		}

		$.ajax(settings2).done(function (response2) {
		  	console.log(response2);
			var rs2 = [];
			rs2.push('<a class="dropdown-item" href="movie_list.jsp">전체</a>');
		  	for(var i=0; i<response2['genres'].length; i++) {
		  		rs2.push('<a class="dropdown-item" href="movie_list.jsp?resultPage='+page+'&sort='+sort+'&with_genres='+response2['genres'][i].id+'">'+response2['genres'][i].name+'</a>');
		  	}
		  	$('#dropdownGenreList').html(rs2.join(''));
		  
		  	function getGenreName(genre_ids) {
				var genreName = [];
				for(var i=0; i<genre_ids.length; i++) {
					for(var j=0; j<response2['genres'].length; j++) {
						if(response2['genres'][j].id == genre_ids[i]) {
							genreName.push(response2['genres'][j].name);
						}
					}
				}
				return genreName;
			}
  
	  		for(var i=0; i<response['results'].length; i++) {
	  			rs.push('<div class="col-12 col-sm-6 col-lg-4">');
	  			rs.push('<div class="single-features-area mb-50">');
	  			if(response['results'][i]['poster_path'] == null) {
	  		  		rs.push('<a href="movie_detail.jsp?id='+response['results'][i]['id']+'"><img style="width: 100%; display: block;" src="https://via.placeholder.com/350x500?text=dont+find+poster" alt="Card image"></a>');
	  			} else {
	  		  		rs.push('<a href="movie_detail.jsp?id='+response['results'][i]['id']+'"><img style="width: 100%; display: block;" src="https://image.tmdb.org/t/p/original'+response['results'][i]['poster_path']+'" alt="Card image"></a>');
	  			}
	  			rs.push('<div class="feature-content d-flex align-items-center justify-content-between">');
	  			rs.push('<div class="feature-title"><h5>'+response['results'][i]['title']+'</h5>');
	  			rs.push('<p>장르 | '+getGenreName(response['results'][i]['genre_ids'])+'</p>');
	  			rs.push('<p>개봉일 | '+response['results'][i]['release_date']+'</p></div>');
				rs.push('<div class="feature-favourite"><a href="#"><i class="fa fa-heart-o" aria-hidden="true"></i></a></div>');
				rs.push('</div></div></div>');
	  		}
  	  		$('#showMovieList').html(rs.join(''));

		});
	});
});
</script>
</body>
</html>