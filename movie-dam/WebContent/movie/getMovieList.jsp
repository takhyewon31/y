<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
$(document).ready(function() {
	function Request() {
		var requestParam = "";
		this.getParameter = function(param) {
			//현재 주소를 decoding
			var url = unescape(location.href);
			//파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다. 
			var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&"); 
				for(var i = 0 ; i < paramArr.length ; i++){
					var temp = paramArr[i].split("="); //파라미터 변수명을 담음
					if(temp[0].toUpperCase() == param.toUpperCase()){
					       // 변수명과 일치할 경우 데이터 삽입
					       requestParam = paramArr[i].split("=")[1]; 
					       break;
					}
				}
				return requestParam;
		}
	}

	var request = new Request();
	var sort = request.getParameter("sort");
	
	var settings = {
	  	async: true,
	  	crossDomain: true,
	  	url: 'https://api.themoviedb.org/3/discover/movie',
		method: 'GET',
	  	data: {
			'page': '1',
		  	'include_video': 'false',
		  	'include_adult': 'false',
		  	'sort_by': sort+'.desc',
		  	'region': 'KR',
		  	'language': 'ko-KR',
		  	'api_key': '9dd279523f7113a4103a8f1e9ef6abe3'
	  	},
	  	dataType: 'json',
	  	headers: {}
	}

	$.ajax(settings).done(function (response) {
		console.log(response);
  		$('.lead').html('총 '+response.total_results+'개의 작품 검색');
  		var rs = [];
  		var hoverList = new Array();
  		
  		var settings2 = {
		  "async": true,
		  "crossDomain": true,
		  "url": "https://api.themoviedb.org/3/genre/movie/list?language=ko-KR&api_key=9dd279523f7113a4103a8f1e9ef6abe3",
		  "method": "GET",
		  "headers": {},
		  "data": "{}"
		}

		$.ajax(settings2).done(function (response2) {
		  console.log(response2);
		});
  
  		for(var i=0; i<response['results'].length; i++) {
  			
  			var data = new Object();
  			data.index = i;
  			data.overview = response['results'][i]['overview'];
  			data.popularity = response['results'][i]['popularity'];
  			hoverList.push(data);
  			  			
  			rs.push('<div class="card mb-3 col-lg-4">');
  			rs.push('<h4 class="card-header">'+response['results'][i]['title']+'</h4>');
  			if(response['results'][i]['poster_path'] == null) {
  		  		rs.push('<img class="hvr-fade" style="width: 100%; display: block;" src="https://via.placeholder.com/350x500?text=dont+find+poster" alt="Card image">');
  			} else {
  		  		rs.push('<img class="hvr-fade" style="width: 100%; display: block;" src="https://image.tmdb.org/t/p/'+response['results'][i]['poster_path']+'" alt="Card image">');
  			}
  		  	rs.push('<ul class="list-group list-group-flush">');
			rs.push('<li class="list-group-item" id="genre">장르 '+response['results'][i]['genre_ids']+'</li>');
			rs.push('<li class="list-group-item">개봉일 '+response['results'][i]['release_date']+'</li>');
			rs.push('</ul>');
			rs.push('<div class="card-body">');
			rs.push('<a href="#" class="card-link">예매하기</a>');
			rs.push('<a href="#" class="card-link">상세보기</a>');
			rs.push('</div>');
			rs.push('</div>');
  	  		$('.row').html(rs.join(''));
			
			/* $.each(genresArray, function(index, item) {
				$('#genre').html(item.join(','));
			}); */

  			$('.hvr-fade').hover(function() {
  				//
  			}, function() {
  				//
  			});

  		}
  		
  		var jsonData = JSON.stringify(hoverList);
  		console.log(jsonData);

	});
});
</script>
