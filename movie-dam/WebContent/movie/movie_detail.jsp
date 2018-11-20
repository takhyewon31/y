<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "영화 상세";
	String id = request.getParameter("id");
	String api_key = "9dd279523f7113a4103a8f1e9ef6abe3";
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

<!-- ***** Breadcumb Area Start ***** -->
<div class="breadcumb-area height-700 bg-img bg-overlay">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcumb-content">
                    <div class="map-ratings-review-area d-flex">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- ***** Breadcumb Area End ***** -->

<!-- ***** Single Listing Area Start ***** -->
<section class="dorne-single-listing-area section-padding-100">
	<div class="container">
        <div class="row justify-content-center">
            <!-- Single Listing Content -->
			<div class="col-12">
    			<div class="single-listing-content">
			        <div class="single-listing-nav">
                        <nav>
                            <ul id="listingNav">
                                <li class="active"><a href="#overview">기본 정보</a></li>
                                <li><a href="#credit">출연·제작</a></li>
                                <li><a href="#trailer">예고편</a></li>
                                <li><a href="#similar" id="li_similar">유사한 영화</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="overview-content mt-50" id="overview">
                    	<div class="row">
	                    	<div class="col-sm-3" id="poster">
	                    	</div>
                         	<div class="col-sm-9">
	                         	<h4 id="title"></h4>
	                         	<h6 id="original_title" class="text-muted"></h6>
	                   			<dl class="row">
		                         	<dt class="col-sm-2 text-truncate">개봉일</dt>
		                         	<dd class="col-sm-10" id="show_release_date"></dd>
		                         	<dt class="col-sm-2 text-truncate">장르</dt>
		                         	<dd class="col-sm-10" id="show_genres"></dd>
		                         	<dt class="col-sm-2 text-truncate">러닝타임</dt>
		                         	<dd class="col-sm-10" id="show_runtime"></dd>
		                         	<dt class="col-sm-2 text-truncate">수익</dt>
		                         	<dd class="col-sm-10" id="show_revenue"></dd>
	                    		</dl>
	                    		<h6><b id="tagline"></b></h6>
	                    		<p id="overview_text"></p>
                         	</div>
                       	</div>
	                </div>
	                <div class="listing-reviews-area mt-100" id="credit">
	                    <h4>출연·제작</h4>
	                    <div class="row" id="cast_crew"></div>	
	                </div>
	                <div class="listing-reviews-area mt-100" id="trailer">
	                    <h4>예고편</h4>
	                    <div class="embed-responsive embed-responsive-16by9">
	                    	<iframe id="showVideo" class="embed-responsive-item" allowfullscreen></iframe>
	                    </div>	
	                </div>
	                <div class="listing-menu-area mt-100" id="similar">
	                    <h4>유사한 영화</h4>
	                    <div class="row" id="similar_movie"></div>
	                </div>
        		</div>
       		</div>
       		
       	
   		</div>
	</div>
</section>



<jsp:include page="/module/footer.jsp" flush="false"/>

<script>
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
var api_key = '<%=api_key%>';
$(document).ready(function() {
	var settings = {
		async: true,
	  	crossDomain: true,
	  	url: 'https://api.themoviedb.org/3/movie/'+<%=id%>+'',
		method: 'GET',
	  	data: {
		  	'language': 'ko-KR',
		  	'api_key': api_key
	  	},
	  	dataType: 'json',
	  	headers: {}
	}
	
	$.ajax(settings).done(function (response) {
	 	console.log(response);
	 	$('.breadcumb-area').attr('style', 'background-image: url(https://image.tmdb.org/t/p/original'+response["backdrop_path"]+');');
	  	$('#vote_average').html(response['vote_average']);
	 	$('#title').html(response['title']+' <small class="text-muted">'+response['original_title']+'</small>');
	  	$('#poster').html('<img src="https://image.tmdb.org/t/p/w500'+response["poster_path"]+'">');
	  	$('#overview_text').html(response['overview']);
	  	$('#tagline').html(response['tagline']);
	  	$('#show_release_date').html(response['release_date']);
	  	for(var i=0; i<response['genres'].length; i++) {
		  	$('#show_genres').append(response['genres'][i].name+' ');
	  	}
	  	$('#show_runtime').html(response['runtime']+'분');
	  	$('#show_revenue').html(numberWithCommas(response['revenue'])+'원');

	 	
		$('#showVideo').attr('src', 'https://moviedam-stream.herokuapp.com/player/'+response['title']+'.mp4');
	 	
	 	var settings2 = {
			async: true,
			crossDomain: true,
			url: 'https://api.themoviedb.org/3/movie/'+<%=id%>+'/credits',
			method: 'GET',
			headers: {},
			data: {
				'api_key': api_key
			}
		}
	 	
	 	$.ajax(settings2).done(function (response2) {
			console.log(response2);
			var rs = [];
			if(response2['cast'].length<6) {
				for(var i=0; i<response2['cast'].length; i++) {
					rs.push('<div class="single-review-area col-md-4">');
					rs.push('<div class="reviewer-meta d-flex align-items-center">');
					if(response2['cast'][i]['profile_path'] == null) {
						rs.push('<img src="https://via.placeholder.com/350x500?text=Dont+find+image" alt="Profile image">');
					} else {
						rs.push('<img src="https://image.tmdb.org/t/p/w185/'+response2['cast'][i]['profile_path']+'" alt="Profile image">');
					}
					rs.push('<div class="reviewer-content">');
					rs.push('<div class="review-title-ratings d-flex justify-content-between"><h6>'+response2['cast'][i]['name']+'</h6></div>');
					rs.push('<p>'+response2['cast'][i]['character']+'</p></div></div></div>');
				}		
			} else {
				for(var i=0; i<6; i++) {
					rs.push('<div class="single-review-area col-md-4">');
					rs.push('<div class="reviewer-meta d-flex align-items-center">');
					if(response2['cast'][i]['profile_path'] == null) {
						rs.push('<img src="https://via.placeholder.com/350x500?text=Dont+find+image" alt="Profile image">');
					} else {
						rs.push('<img src="https://image.tmdb.org/t/p/w185/'+response2['cast'][i]['profile_path']+'" alt="Profile image">');
					}
					rs.push('<div class="reviewer-content">');
					rs.push('<div class="review-title-ratings d-flex justify-content-between"><h6>'+response2['cast'][i]['name']+'</h6></div>');
					rs.push('<p>'+response2['cast'][i]['character']+'</p></div></div></div>');
				}			 	
			}
			if(response2['crew'].length<6) {
				for(var i=0; i<response2['crew'].length; i++) {
					rs.push('<div class="single-review-area col-md-4">');
					rs.push('<div class="reviewer-meta d-flex align-items-center">');
					if(response2['crew'][i]['profile_path'] == null) {
						rs.push('<img src="https://via.placeholder.com/350x500?text=Dont+find+image" alt="Profile image">');
					} else {
						rs.push('<img src="https://image.tmdb.org/t/p/w185/'+response2['crew'][i]['profile_path']+'" alt="Profile image">');
					}
					rs.push('<div class="reviewer-content">');
					rs.push('<div class="review-title-ratings d-flex justify-content-between"><h6>'+response2['crew'][i]['name']+'</h6></div>');
					rs.push('<p>'+response2['crew'][i]['job']+'</p></div></div></div>');
				}
			} else {
				for(var i=0; i<6; i++) {
					rs.push('<div class="single-review-area col-md-4">');
					rs.push('<div class="reviewer-meta d-flex align-items-center">');
					if(response2['crew'][i]['profile_path'] == null) {
						rs.push('<img src="https://via.placeholder.com/350x500?text=Dont+find+image" alt="Profile image">');
					} else {
						rs.push('<img src="https://image.tmdb.org/t/p/w185/'+response2['crew'][i]['profile_path']+'" alt="Profile image">');
					}
					rs.push('<div class="reviewer-content">');
					rs.push('<div class="review-title-ratings d-flex justify-content-between"><h6>'+response2['crew'][i]['name']+'</h6></div>');
					rs.push('<p>'+response2['crew'][i]['job']+'</p></div></div></div>');
				}
			}
			$('#cast_crew').html(rs.join(''));
			
			var settings3 = {
			  async: true,
			  crossDomain: true,
			  url: 'https://api.themoviedb.org/3/movie/'+<%=id%>+'/similar',
			  method: 'GET',
			  headers: {},
			  data: {
				  'page': 1,
				  'language': 'ko-KR',
				  'api_key': api_key
			  }
			}

			$.ajax(settings3).done(function (response3) {
				console.log(response3);
				var rs2 = [];
				if(response3.total_results == 0) {
					$('#similar').css('display', 'none');
					$('#li_similar').css('display', 'none');
				} else {
					if(response3.total_result <= 5) {
						for(var i=0; i<response3.total_result; i++) {
							rs2.push('<div class="single-listing-menu d-flex justify-content-between">');
							rs2.push('<div class="reviewer-meta d-flex align-items-center">');
							rs2.push('<img src="https://image.tmdb.org/t/p/w185/'+response3['results'][i]['poster_path']+'" alt="Poster image">');
							rs2.push('<div class="listing-menu-title">');
							rs2.push('<h6><a href="movie_detail.jsp?id='+response3['results'][i]['id']+'">'+response3['results'][i]['title']+'</a></h6>');
							if(response3['results'][i]['overview'] == "" || response3['results'][i]['overview'].length == 0) {
								rs2.push('<p style="display: inline-block; whith-space: nowrap; overflow: hidden; text-overflow: ellipsis; line-height: 1.3; height: 5.2em;">줄거리가 없습니다.</p>');
							} else {
								rs2.push('<p style="display: inline-block; whith-space: nowrap; overflow: hidden; text-overflow: ellipsis; line-height: 1.3; height: 5.2em;">'+response3['results'][i]['overview']+'</p>');
							}
							rs2.push('</div></div></div>');
						}
					} else {
						for(var i=0; i<5; i++) {
							rs2.push('<div class="single-listing-menu d-flex justify-content-between">');
							rs2.push('<div class="reviewer-meta d-flex align-items-center">');
							rs2.push('<img src="https://image.tmdb.org/t/p/w185/'+response3['results'][i]['poster_path']+'" alt="Poster image">');
							rs2.push('<div class="listing-menu-title">');
							rs2.push('<h6><a href="movie_detail.jsp?id='+response3['results'][i]['id']+'">'+response3['results'][i]['title']+'</a></h6>');
							if(response3['results'][i]['overview'] == "" || response3['results'][i]['overview'].length == 0) {
								rs2.push('<p style="display: inline-block; whith-space: nowrap; overflow: hidden; text-overflow: ellipsis; line-height: 1.3; height: 5.2em;">줄거리가 없습니다.</p>');
							} else {
								rs2.push('<p style="display: inline-block; whith-space: nowrap; overflow: hidden; text-overflow: ellipsis; line-height: 1.3; height: 5.2em;">'+response3['results'][i]['overview']+'</p>');
							}
							rs2.push('</div></div></div>');
						}
					}
				}
				$('#similar_movie').html(rs2.join(''));
			});
 		});

	});	
});
</script>
</body>
</html>