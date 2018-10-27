<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "moviedam.board.ArticleDBBean" %>
<%@ page import = "moviedam.board.ArticleDataBean" %>
<%@ page import = "moviedam.board.RestaurantDBBean" %>
<%@ page import = "moviedam.board.RestaurantDataBean" %>
<%@ page import="moviedam.board.BoardDBBean"%>
<%@ page import="moviedam.board.BoardDataBean"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String title = "게시글 수정";
	int article_id = Integer.parseInt(request.getParameter("article_id"));
	String pageNum = request.getParameter("pageNum");
	int board_id = Integer.parseInt(request.getParameter("board_id"));
	String category = request.getParameter("category");
	String article_writer = request.getParameter("article_writer");
	ArticleDataBean article = null;
	RestaurantDataBean restaurant = null;
	
	if(board_id == 1) {
		ArticleDBBean dbPro = ArticleDBBean.getInstance();
		article = dbPro.updateGetArticle(article_id);
	} else if(board_id == 2) {
		RestaurantDBBean dbPro = RestaurantDBBean.getInstance();
		restaurant = dbPro.updateGetArticle(article_id);
	}

	BoardDBBean board_db = BoardDBBean.getInstance();
	BoardDataBean board = board_db.getBoard(board_id);

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
				<h4>Article update</h4>
				<p>게시글 수정</p>
			</div>
		</div>
	</div>

	<div class="row justify-content-center">
		<form method="post" name="updateform" action="updatePro.jsp?board_id=<%=board_id%>&pageNum=<%=pageNum%>&article_id=<%=article_id %>" onsubmit="return writeSave()" enctype="multipart/form-data">
 			<input type="hidden" name="article_id" value="<%=article_id%>"> 
	
<c:if test="<%=board_id == 1 %>">
			<div class="form-group col">
				<label for="inputCategory">카테고리</label> 
				<select class="form-control" id="inputCategory" name="category">
					<option value="talk"<%if(article.getCategory().equals("talk")){out.print(" selected=\"selected\"");}%>>사담</option>
					<option value="movietalk"<%if(article.getCategory().equals("movietalk")){out.print(" selected=\"selected\"");}%>>영화후기</option>
					<option value="spoiler"<%if(article.getCategory().equals("spoiler")){out.print(" selected=\"selected\"");}%>>스포일러</option>
					<option value="movietmi"<%if(article.getCategory().equals("movietmi")){out.print(" selected=\"selected\"");}%>>영화TMI</option>
					<option value="boast"<%if(article.getCategory().equals("boast")){out.print(" selected=\"selected\"");}%>>자랑하기</option>
					<option value="hobby"<%if(article.getCategory().equals("hobby")){out.print(" selected=\"selected\"");}%>>덕질공간</option>
				</select>
			</div>
			<div class="form-group col">
				<label for="inputWriter" class="col-sm-2 col-form-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputWriter" name="article_writer" value="<%=article.getArticle_writer()%>" readonly="readonly">
				</div>
			</div>
			<div class="form-group col">
				<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputTitle" name="article_title" value="<%=article.getArticle_title()%>" maxlength="100">
				</div>
			</div>
			<div class="form-group col">
				<label for="exampleTextarea">내용</label>
				<textarea class="form-control" id="inputContent" name="article_content" rows="3"><%=article.getArticle_content()%></textarea>
			</div>
			<div class="form-group col">
				<label for="exampleInputFile">첨부파일</label> 
				<input type="file" class="form-control-file" id="inputFile" name="article_file" aria-describedby="fileHelp" accept="image/*"> 
				<small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
			</div>
</c:if>
			
<c:if test="<%=board_id == 2 %>">
			<div class="form-group col">
				<label for="inputWriter" class="col-sm-2 col-form-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputWriter" name="article_writer" value="<%=restaurant.getArticle_writer()%>" readonly="readonly">
				</div>
			</div>
			<div class="form-group col">
				<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputTitle" name="article_title" value="<%=restaurant.getArticle_title()%>" maxlength="100">
				</div>
			</div>
			<div class="form-group col">
				<div class="form-group">
					<label for="inputLoc" class="col-sm-2 col-form-label">장소</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="searchLoc" name="search_loc" placeholder="위치를 입력하세요.">
						<div class="input-group-append">
							<button class="btn btn-primary" type="button" onclick="search_location();">검색</button>
						</div>
					</div>
				</div>
				<!-- <div id="map" style="width: 500px; height: 400px;"></div> -->
				<p>
					지도를 클릭해 해당 위치에 마커를 입력해주세요!
				</p>
				<button type="button" id="setMarker">입력 완료</button>
			 	<div class="map_wrap">
					<div id="map" style="width: 500px; height: 400px;"></div>
		  			<div class="hAddr">
				        <span class="title">지도중심기준 주소정보</span>
				        <span id="centerAddr"></span>
			        </div>
		        </div>
				<input type="hidden" id="startLat" name="start_lat" value="">
				<input type="hidden" id="startLon" name="start_lon" value="">
			</div>
			<div class="form-group col">
				<label for="exampleTextarea">내용</label>
				<textarea class="form-control" id="inputContent" name="article_content" rows="3"><%=restaurant.getArticle_content()%></textarea>
			</div>
			<div class="form-group col">
				<label for="exampleInputFile">첨부파일</label> 
				<input type="file" class="form-control-file" id="inputFile" name="article_file" aria-describedby="fileHelp" accept="image/*"> 
				<small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
			</div>
</c:if>
	
			<button type="submit" class="btn btn-primary">작성하기</button>
			<button type="reset" class="btn btn-secondary">다시 작성</button>
			<c:if test="<%=board_id == 1 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./free_board.jsp'">목록으로</button>
			</c:if>
			<c:if test="<%=board_id == 2 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./cinema_restaurant.jsp'">목록으로</button>
			</c:if>
		</form>
	</div>

</div>
</section>




<jsp:include page="/module/footer.jsp" flush="false" />

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f393c76a0b2985e070ae327f42034c70&libraries=services"></script>
<script>
var ps = new daum.maps.services.Places();
//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new daum.maps.InfoWindow({
	zIndex : 1
});
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center : new daum.maps.LatLng(37.55889, 127.049694),
	level : 3
//지도의 레벨(확대, 축소 정도)
};

//지도를 생성합니다
var map = new daum.maps.Map(container, options);

//장소 검색 객체를 생성합니다. 키워드로 장소를 검색합니다.
function search_location() {
	var loc = $('#searchLoc').val();
	ps.keywordSearch(loc, placesSearchCB);
}

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
	if (status === daum.maps.services.Status.OK) {

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		// LatLngBounds 객체에 좌표를 추가합니다
		var bounds = new daum.maps.LatLngBounds();

		for (var i = 0; i < data.length; i++) {

			displayMarker(data[i]);
			bounds.extend(new daum.maps.LatLng(data[i].y, data[i].x));       
		}
		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		map.setBounds(bounds);

	}
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
	
	
	// 마커를 생성하고 지도에 표시합니다
	var marker = new daum.maps.Marker({
		map : map,
		position : new daum.maps.LatLng(place.y, place.x)
	});

	//지도에 마커를 표시합니다
	marker.setMap(map);

	// 마커에 클릭이벤트를 등록합니다
	daum.maps.event.addListener(marker, 'click', function() {

		// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		infowindow.setContent('<div style="padding:5px;font-size:12px;">'
				+ place.place_name + '</div>');
		infowindow.open(map, marker);
	});
}


//지도를 클릭한 위치에 표출할 마커입니다
var marker = new daum.maps.Marker({
	// 지도 중심좌표에 마커를 생성합니다 
	position : map.getCenter()
});
//지도에 마커를 표시합니다
marker.setMap(map);

//지도에 클릭 이벤트를 등록합니다
//지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
daum.maps.event.addListener(map, 'click', function(mouseEvent) {
		
	// 클릭한 위도, 경도 정보를 가져옵니다 
	var latlng = mouseEvent.latLng;
	
	// 마커 위치를 클릭한 위치로 옮깁니다
	marker.setPosition(latlng);   
	    
	    $('#startLat')[0].value = latlng.getLat();
	    $('#startLon')[0].value = latlng.getLng();
    
});

function submitFunc(){
	var start_lat =  $('#startLat')[0].value;
	var start_lon =  $('#startLon')[0].value;
		
	document.writeForm.start_lat.value = start_lat;
	document.writeForm.start_lon.value = start_lon;
} 
</script>
<script>
$('#setMarker').click(function() {
	
	console.log($('#startLat')[0].value+$('#startLon')[0].value);
	var ps = new daum.maps.services.Places();
	//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new daum.maps.InfoWindow({
		zIndex : 1
	});
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center : new daum.maps.LatLng($('#startLat')[0].value, $('#startLon')[0].value), //지도의 중심좌표
		level : 3
	//지도의 레벨(확대, 축소 정도)
	};

	//지도를 생성합니다
	var map = new daum.maps.Map(container, options);

	var marker = new daum.maps.Marker({
		//지도 중심 좌표에 마커를 생성합니다.
		position: map.getCenter()
	});
	marker.setMap(map);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();

	var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
	    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	    
	 // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	    daum.maps.event.addListener(map, 'click', function(mouseEvent) {
	        searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	            if (status === daum.maps.services.Status.OK) {
	                var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
	                detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
	                
	                var content = '<div class="bAddr">' +  $('#searchLoc').val() + detailAddr + '</div>';
	                // 마커를 클릭한 위치에 표시합니다 
	                marker.setPosition(mouseEvent.latLng);
	                marker.setMap(map);
	                
	                //마커를 보이지 않게 합니다.
	                marker.setVisible(false);

	                // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	                infowindow.setContent(content);
	                infowindow.open(map, marker);
	            }   
	        });
	    });

	    function searchAddrFromCoords(coords, callback) {
	        // 좌표로  주소 정보를 요청합니다
	        geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	    }

	    function searchDetailAddrFromCoords(coords, callback) {
	        // 좌표로 상세 주소 정보를 요청합니다
	        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	    }
	    
	    
	 // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	    daum.maps.event.addListener(map, 'idle', function() {
	    	
	        searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	    });
	 
	 // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	    function displayCenterInfo(result, status) {
	        if (status === daum.maps.services.Status.OK) {
	            var infoDiv = document.getElementById('centerAddr');

	            for(var i = 0; i < result.length; i++) {
	                // 행정동의 region_type 값은 'H' 이므로
	                if (result[i].region_type === 'H') {
	                    infoDiv.innerHTML = result[i].address_name;
	                    break;
	                }
	            }
	        }    
	    }
});

</script> 

   
</body>
</html>