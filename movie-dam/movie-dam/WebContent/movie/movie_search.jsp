<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "영화 검색";
	String query = request.getParameter("query");
	String resultPage = request.getParameter("resultPage");
	if (resultPage == null || resultPage.length() == 0) {
		resultPage = "1";
	}
	String api_key = "9dd279523f7113a4103a8f1e9ef6abe3";
	
	query = request.getParameter("query");
%>
<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

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
                <h4>Movie search</h4>
                <p id="lead"></p>
            </div>
        </div>
    </div>	
    
   	<div class="row">
  		<div class="col-8 offset-md-2">
  			<form id="searchForm" action="movie_search.jsp">
  				<input type="text" class="form-control" id="searchMovie" name="query" placeholder="찾고 싶은 영화 제목을 검색해 보세요.">
			</form>
  		</div>
	</div>
	
	<div class="row">
  		<div class="col-12" id="resultList">
  		
  		</div>
	</div>
	
	<nav aria-label="Page navigation example">
		<ul class="pagination" id="paging">
			
	  	</ul>
	</nav>
    
</div>
</section>

<jsp:include page="/module/footer.jsp" flush="false"/>

<script>
var page = '<%=resultPage%>';
var query = '';
var api_key = '<%=api_key%>';
$('#searchForm').submit(function(event) {
	event.preventDefault();
	query = searchForm.query.value;
	
	var settings = {
		async: true,
		crossDomain: true,
		url: 'https://api.themoviedb.org/3/search/movie',
		method: 'GET',		
		data: {
			'region': 'KR',
			'include_adult': 'flase',
			'page': page,
			'query': query,
			'language': 'ko-KR',
			'api_key': api_key
		},
	  	dataType: 'json',
		method: 'GET',
		headers: {}
	}
	$.ajax(settings).done(function (response) {
		console.log(response);
		$('#lead').html('총 '+response.total_results+'개의 검색 결과');

		var rs = [];
		for(var i=0; i<response['results'].length; i++) {
			rs.push('<a href="movie_detail.jsp?id='+response['results'][i]['id']+'" style="color:black; text-decoratio: none;"><div class="media">');
			rs.push('<img class="mr-3" style="width: 64px; height: 64px;" src="https://image.tmdb.org/t/p/original'+response['results'][i]['poster_path']+'" alt="Generic placeholder image">');
			rs.push('<div class="media-body"><h5 class="mt-0">'+response['results'][i]['title']+'</h5>');
			rs.push('<p class="text-muted">'+response['results'][i]['overview']+'</p>');
			rs.push('</div></div></a>');

		}
		$('#resultList').html(rs.join(''));
		
		var rs2 = [];
		var total_results = response.total_results; //검색 결과 수
		var data_size = response['results'].length; //페이지 당 보여줄 영화 수
		var total_pages = response.total_pages; //전체 페이지 수
		var page_size = 10; //페이지 그룹 범위
		var current_page = page; //보여줄 페이지
		var page_group = Math.ceil(current_page/page_size); //페이지 그룹
		
		function paging(total_results, data_size, page_size, current_page) {
			var last = page_group * page_size;
			if(last > total_pages) {
				last = total_pages;
			}
			var first = last - (page_size-1);
			if(total_pages <= 10) {
				first = 1;
			}
			var next = last+1;
			var prev = first-1;
			console.log("last : " + last);
	        console.log("first : " + first);
	        console.log("next : " + next);
	        console.log("prev : " + prev);
	        
	        if(prev > 0) {
	        	rs2.push('<li class="page-item">');
	        	rs2.push('<a class="page-link" href="#" id="prev" aria-label="Previous"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a>');
	        	rs2.push('</li>');
	        }
	        for(var i=first; i<=last; i++) {
	        	rs2.push('<li class="page-item"><a class="page-link" href="#" id="'+i+'">'+i+'</a></li>');
	        }
	        if(last < total_pages) {
	        	rs2.push('<li class="page-item">');
	        	rs2.push('<a class="page-link" href="#" id="next" aria-label="Next"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a>');
	        	rs2.push('</li>');
	        }
	        
	        $('#paging').html(rs2.join(''));
	        $('#paging a').click(function() {
	        	paging(total_results, data_size, page_size, current_page);
	        });
		}
		$('document').ready(function(){        
	        paging(total_results, data_size, page_size, 1);
	    });
	});

});


</script>
</body>
</html>