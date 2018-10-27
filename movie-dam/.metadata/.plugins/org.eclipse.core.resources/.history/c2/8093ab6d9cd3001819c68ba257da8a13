<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="moviedam.board.BoardDBBean"%>
<%@ page import="moviedam.board.BoardDataBean"%>
<%@ page import="moviedam.member.MemberDBBean"%>
<%@ page import="moviedam.member.MemberDataBean"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "게시글 작성";
	int board_id = Integer.parseInt(request.getParameter("board_id"));
	String userid = request.getParameter("article_writer");
	BoardDBBean board_db = BoardDBBean.getInstance();
	BoardDataBean board = board_db.getBoard(board_id);
	MemberDBBean member_db = MemberDBBean.getInstance();
	MemberDataBean profile = member_db.getProfile(userid);
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
				<h4>Article write</h4>
				<p>게시글 작성</p>
			</div>
		</div>
	</div>
	
	<div class="row justify-content-center">
		<form method="post" name="writeForm" action="writePro.jsp?board_id=<%=board.getBoard_id()%>" onsubmit="return writeSave()" enctype="multipart/form-data">
			<div class="form-group col">
				<label for="inputWriter" class="col-sm-2 col-form-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputWriter" name="article_writer" value="<%=userid %>" readonly="readonly">
				</div>
			</div>
<c:if test="<%=board_id == 1 %>">
			<div class="form-group col">
				<label for="inputCategory">카테고리</label> 
				<select class="form-control" id="inputCategory" name="category">
					<option value="talk" selected="selected">사담</option>
					<option value="movietalk">영화후기</option>
					<option value="spoiler">스포일러</option>
					<option value="movietmi">영화TMI</option>
					<option value="boast">자랑하기</option>
					<option value="hobby">덕질공간</option>
				</select>
			</div>
</c:if>
<c:if test="<%=board_id == 4 %>">
			<div class="form-group">
				<label for="inputCategory">영화관</label> 
				<select class="form-control" id="inputCinema" name="cinema">
					<option value="cgv" selected="selected">CGV</option>
					<option value="lottecinema">롯데시네마</option>
					<option value="megabox">메가박스</option>
					<option value="etc">기타</option>
				</select>
			</div>
			<div class="form-group col">
				<label for="inputUrl" class="col-sm-2 col-form-label">원본글 주소</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputUrl" name="original_url">
				</div>
			</div>
			<div class="form-group col">
				<label for="inputWriter" class="col-sm-2 col-form-label">일시</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="datepicker" name="preview_date">
				</div>
			</div>
			<div class="form-group col">
				<label for="Textarea">지역</label>
				<textarea class="form-control" id="inputContent" name="preview_region" rows="1"></textarea>
			</div>
</c:if>
<c:if test="<%=board_id == 5 %>">
			<div class="form-group col">
				<label for="inputUrl" class="col-sm-2 col-form-label">원본글 주소</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputUrl" name="original_url">
				</div>
			</div>
</c:if>
			<div class="form-group col">
				<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputTitle" name="article_title" maxlength="100">
				</div>
			</div>
<c:if test="<%=board_id == 2 %>">
			<div class="form-group col">
				<div class="form-group">
					<label for="inputLoc" class="col-sm-2 col-form-label">장소</label>
					<div class="input-group mb-3">
						<input class="form-control" type="text" class="form-control" id="searchLoc" name="search_loc" placeholder="위치를 입력하세요.">
						<div class="input-group-append">
							<button class="btn btn-outline-secondary" type="button" onclick="search_location();">검색</button>
						</div>
					</div>
				</div>
				<p>
					지도를 클릭해 해당 위치에 마커를 입력해주세요!
				</p>
				<button class="btn btn-outline-secondary" type="button" id="setMarker" style="position:relative; left:400px; bottom:5px;">입력 완료</button>
			 	<div class="map_wrap">
					<div id="map" style="width:500px; height:400px; position:relative; overflow:hidden; margin-bottom:10px;"></div>
		  			<div class="hAddr">
				        <span class="title">지도중심기준 주소정보</span>
				        <span id="centerAddr"></span>
			        </div>
		        </div>
		        <div id=box style="height:70px; position:relative; overflow:hidden;"></div>
				<input type="hidden" id="startLat" name="start_lat" value="">
				<input type="hidden" id="startLon" name="start_lon" value="">
			</div>
</c:if>
			<div class="form-group col">
				<label for="exampleTextarea">내용</label>
				<textarea class="form-control" id="inputContent" name="article_content" rows="3"></textarea>
			</div>
			<div class="form-group col">
				<label for="exampleInputFile">첨부파일</label> 
				<input type="file" class="form-control-file" id="inputFile" name="article_file" aria-describedby="fileHelp" accept="image/*"> 
				<small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
			</div>

			<button type="submit" class="btn btn-primary">작성하기</button>
			<button type="reset" class="btn btn-secondary">다시작성</button>
<c:choose>
	<c:when test="<%=board_id == 1 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./free_board.jsp'">목록으로</button>
	</c:when>
	<c:when test="<%=board_id == 2 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./cinema_restaurant.jsp'">목록으로</button>
	</c:when>
	<c:when test="<%=board_id == 4 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./movie_preview.jsp'">목록으로</button>
	</c:when>
	<c:when test="<%=board_id == 5 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./movie_issue.jsp'">목록으로</button>
	</c:when>
</c:choose>
			
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

</script>
<script>
$('#setMarker').click(function() {
	var start_lat =  $('#startLat')[0].value;
	var start_lon =  $('#startLon')[0].value;
		
	document.writeForm.start_lat.value = start_lat;
	document.writeForm.start_lon.value = start_lon;
	
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

<script>
$(function() {
	$('#datepicker').datepicker({
		dateFormat: 'yy-mm-dd'
	});
});
</script>

</body>
</html>