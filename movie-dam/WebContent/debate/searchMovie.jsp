<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String query = request.getParameter("query")==null ? "" : request.getParameter("query");
	String resultPage = request.getParameter("resultPage")==null ? "1" : request.getParameter("resultPage");
	String api_key = "9dd279523f7113a4103a8f1e9ef6abe3";
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>영화 검색</title>
<!-- Favicon -->
<link rel="icon" href="/movie-dam/assets/img/core-img/favicon.ico">

<!-- Core Stylesheet -->
<link rel="stylesheet" href="/movie-dam/assets/style.css">
<link rel="stylesheet" href="/movie-dam/assets/css/argon.min.css">

<!-- Responsive CSS -->
<link rel="stylesheet" href="/movie-dam/assets/css/responsive/responsive.css">

<!-- Custom styles -->
<link href="/movie-dam/assets/css/custom.css" rel="stylesheet">

</head>
<body>

<div class="container">
	<div class="row mb-5">
		<form id="searchForm" action="searchMovie.jsp">
		<div class="input-group mb-3">
			<% if(query.equals("")) { %>
				<input type="text" class="form-control" id="searchMovie" name="query" placeholder="찾고 싶은 영화 제목을 검색해 보세요.">
			<% } else { %>
				<input type="text" class="form-control" id="searchMovie" name="query" value="<%=query%>">
			<% } %>
			<div class="input-group-append">
				<input class="btn btn-primary" type="submit" value="검색">
			</div>
		</div>	
		</form>
	</div>
	
	<div class="row">
		<div class="col-12" id="resultList">
		</div>
	</div>
	
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center" id="paging">
	  	</ul>
	</nav>
</div>

<script src="/movie-dam/assets/js/jquery/jquery-2.2.4.min.js"></script>
<script src="/movie-dam/assets/js/bootstrap/popper.min.js"></script>
<script src="/movie-dam/assets/js/bootstrap/bootstrap.min.js"></script>
<script src="/movie-dam/assets/js/argon.min.js"></script>
<script src="/movie-dam/assets/js/others/plugins.js"></script>
<script src="/movie-dam/assets/js/active.js"></script>
<script>
var page = '<%=resultPage%>';
var query = '<%=query%>';
var api_key = '<%=api_key%>';

var total_results = 0; //검색 결과 수
var data_size = 0; //페이지 당 보여줄 영화 수
var total_pages = 0; //전체 페이지 수
var page_size = 10; //페이지 그룹 범위
var current_page = 0; //보여줄 페이지
var page_group = 0; //페이지 그룹
function paging(total_results, data_size, page_size, current_page) {
	var rs2 = [];
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
    	rs2.push('<a class="page-link" href="searchMovie.jsp?query='+query+'&resultPage='+prev+'" id="prev" aria-label="Previous"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a>');
    	rs2.push('</li>');
    }
    for(var i=first; i<=last; i++) {
    	rs2.push('<li class="page-item"><a class="page-link" href="searchMovie.jsp?query='+query+'&resultPage='+i+'" id="'+i+'">'+i+'</a></li>');
    }
    if(last < total_pages) {
    	rs2.push('<li class="page-item">');
    	rs2.push('<a class="page-link" href="searchMovie.jsp?query='+query+'&resultPage='+next+'" id="next" aria-label="Next"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a>');
    	rs2.push('</li>');
    }
 
    $('#paging').html(rs2.join(''));
    $('#paging a').click(function() {
    	paging(total_results, data_size, page_size, current_page);
    });
    $('#'+page+'').parent('li').addClass('active');
}

function setMovie(cb_movie) {
	opener.document.writeForm.cb_movie.value = cb_movie;
	self.close();
}

$('document').ready(function(){	
	if(query != '') {
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
			if(response.total_results == 0) {
		    	rs.push('<div class="alert alert-secondary" role="alert">');
		    	rs.push('<strong>검색 결과가 없습니다!</strong> 다른 검색어를 입력해 주세요.');
		    	rs.push('</div>');
		    	$('#resultList').html(rs.join(''));
		    } else {
				for(var i=0; i<response['results'].length; i++) {
					var title_id = response['results'][i]['title'] + '(' + response['results'][i]['id'] +')';
					title_id.replace('', '&nbsp;');
					rs.push('<a href="javascript:setMovie(\''+title_id+'\');"><div class="media">');
					rs.push('<img class="mr-3" style="width: 64px; height: 64px;" src="https://image.tmdb.org/t/p/original'+response['results'][i]['poster_path']+'" alt="Generic placeholder image">');
					if(response['results'][i]['release_date'] == '') {
						rs.push('<div class="media-body"><h5 class="mt-0">'+response['results'][i]['title']+'</h5>');
					} else {
						rs.push('<div class="media-body"><h5 class="mt-0">'+response['results'][i]['title']+'<small class="text-muted"> ('+response['results'][i]['release_date'].substring(0,4)+')</small></h5>');
					}
					if(response['results'][i]['overview'] == '') {
						rs.push('<p class="text-muted" style="display: inline-block; whith-space: nowrap; overflow: hidden; text-overflow: ellipsis; line-height: 1.3; height: 5.2em;">영화 소개가 없습니다.</p>');
					} else {
						rs.push('<p class="text-muted" style="display: inline-block; whith-space: nowrap; overflow: hidden; text-overflow: ellipsis; line-height: 1.3; height: 5.2em;">'+response['results'][i]['overview']+'</p>');
					}
					rs.push('</div></div></a>');
				}
				$('#resultList').html(rs.join(''));
				
				total_results = response.total_results; 
				data_size = response['results'].length; 
				total_pages = response.total_pages; 
				page_size = 10;
				current_page = page; 
				page_group = Math.ceil(current_page/page_size); 
						
		     	paging(total_results, data_size, page_size, 1);
			}
		});
	}
});
</script>
</body>
</html>