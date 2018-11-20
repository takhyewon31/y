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
	String theater = request.getParameter("theater");
	
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
		<div class="col-12">
		<form method="post" name="updateform" action="updatePro.jsp?board_id=<%=board_id%>&pageNum=<%=pageNum%>&article_id=<%=article_id %>" onsubmit="return writeSave()" enctype="multipart/form-data">
 			<input type="hidden" name="article_id" value="<%=article_id%>"> 
	
	
<c:if test="<%=board_id == 1 %>">
	<div class="form-group row">
				<label for="inputWriter" class="col-sm-2 col-form-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputWriter" name="article_writer" value="<%=article.getArticle_writer()%>" readonly="readonly">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputCategory" class="col-sm-2 col-form-label">카테고리</label> 
						<div class="col-sm-10">
				<select class="form-control" id="inputCategory" name="category">
					<option value="talk"<%if(article.getCategory().equals("talk")){out.print(" selected=\"selected\"");}%>>사담</option>
					<option value="movietalk"<%if(article.getCategory().equals("movietalk")){out.print(" selected=\"selected\"");}%>>영화후기</option>
					<option value="spoiler"<%if(article.getCategory().equals("spoiler")){out.print(" selected=\"selected\"");}%>>스포일러</option>
					<option value="movietmi"<%if(article.getCategory().equals("movietmi")){out.print(" selected=\"selected\"");}%>>영화TMI</option>
					<option value="boast"<%if(article.getCategory().equals("boast")){out.print(" selected=\"selected\"");}%>>자랑하기</option>
					<option value="hobby"<%if(article.getCategory().equals("hobby")){out.print(" selected=\"selected\"");}%>>덕질공간</option>
				</select>
			</div>
			</div>
			<div class="form-group row">
				<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputTitle" name="article_title" value="<%=article.getArticle_title()%>" maxlength="100">
				</div>
			</div>
			<div class="form-group row">
				<label for="exampleTextarea" class="col-sm-2 col-form-label">내용</label>
				<div class="col-sm-10">
				<textarea class="form-control" id="inputContent" name="article_content" rows="10"><%=article.getArticle_content()%></textarea>
			</div>
			</div>
			<div class="form-group row">
				<label for="exampleInputFile" class="col-sm-2 col-form-label">첨부파일</label>
				 <div class="col-sm-10">
				<input type="file" class="form-control-file" id="inputFile" name="article_file" aria-describedby="fileHelp" accept="image/*"> 
				<small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
			</div>
			</div>
</c:if>
			
<c:if test="<%=board_id == 2 %>">	
			<div class="form-group row">
				<label for="inputWriter" class="col-sm-2 col-form-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputWriter" name="article_writer" value="<%=restaurant.getArticle_writer()%>" readonly="readonly">
				</div>
			</div>
				<div class="form-group row">
				<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputTitle" name="article_title" value="<%=restaurant.getArticle_title()%>" maxlength="100">
				</div>
			</div>
				<div class="form-group row">
					<label for="inputTheater" class="col-sm-2 col-form-label">극장선택</label> 
						<div class="col-sm-4">
							<select class="form-control" id="inputTheater" name="theater">
								<option value="cgv"<%if(restaurant.getTheater().equals("cgv")){out.print(" selected=\"selected\"");}%>>CGV</option>
								<option value="롯데시네마"<%if(restaurant.getTheater().equals("롯데시네마")){out.print(" selected=\"selected\"");}%>>롯데시네마</option>
								<option value="메가박스"<%if(restaurant.getTheater().equals("메가박스")){out.print(" selected=\"selected\"");}%>>메가박스</option>
								<option value="대한극장"<%if(restaurant.getTheater().equals("대한극장")){out.print(" selected=\"selected\"");}%>>대한극장</option>
								<option value="서울극장"<%if(restaurant.getTheater().equals("서울극장")){out.print(" selected=\"selected\"");}%>>서울극장</option>
								<option value="etc"<%if(restaurant.getTheater().equals("etc")){out.print(" selected=\"selected\"");}%>>ETC</option>
							</select>
						</div>
				<div class="col-sm-6">
					<select class="form-control" id="inputArea" name="area">
					<optgroup label ="[서울]">
					<option value="강남점"<%if(restaurant.getArea().equals("강남점")){out.print(" selected=\"selected\"");}%>>강남점</option>
					<option value="강변점"<%if(restaurant.getArea().equals("강변점")){out.print(" selected=\"selected\"");}%>>강변점</option>
					<option value="건대입구점"<%if(restaurant.getArea().equals("건대입구점")){out.print(" selected=\"selected\"");}%>>건대입구점</option>
					<option value="구로점"<%if(restaurant.getArea().equals("구로점")){out.print(" selected=\"selected\"");}%>>구로점</option>
					<option value="대학로점"<%if(restaurant.getArea().equals("대학로점")){out.print(" selected=\"selected\"");}%>>대학로점</option>
					<option value="동대문점"<%if(restaurant.getArea().equals("동대문점")){out.print(" selected=\"selected\"");}%>>동대문점</option>
					<option value="명동점"<%if(restaurant.getArea().equals("명동점")){out.print(" selected=\"selected\"");}%>>명동점</option>
					<option value="목동점"<%if(restaurant.getArea().equals("목동점")){out.print(" selected=\"selected\"");}%>>목동점</option>
					<option value="미아점"<%if(restaurant.getArea().equals("미아점")){out.print(" selected=\"selected\"");}%>>미아점</option>
					<option value="불광점"<%if(restaurant.getArea().equals("불광점")){out.print(" selected=\"selected\"");}%>>불광점</option>
					<option value="상봉점"<%if(restaurant.getArea().equals("상봉점")){out.print(" selected=\"selected\"");}%>>상봉점</option>
					<option value="성신여대점"<%if(restaurant.getArea().equals("성신여대점")){out.print(" selected=\"selected\"");}%>>상봉점</option>
					<option value="송파점"<%if(restaurant.getArea().equals("송파점")){out.print(" selected=\"selected\"");}%>>송파점</option>
					<option value="수유점"<%if(restaurant.getArea().equals("수유점")){out.print(" selected=\"selected\"");}%>>수유점</option>
					<option value="신촌점"<%if(restaurant.getArea().equals("신촌점")){out.print(" selected=\"selected\"");}%>>신촌점</option>
					<option value="압구정점"<%if(restaurant.getArea().equals("압구정점")){out.print(" selected=\"selected\"");}%>>압구정점</option>
					<option value="여의도점"<%if(restaurant.getArea().equals("여의도점")){out.print(" selected=\"selected\"");}%>>여의도점</option>
					<option value="영등포점"<%if(restaurant.getArea().equals("영등포점")){out.print(" selected=\"selected\"");}%>>영등포점</option>
					<option value="왕십리점"<%if(restaurant.getArea().equals("왕십리점")){out.print(" selected=\"selected\"");}%>>왕십리점</option>
					<option value="용산점"<%if(restaurant.getArea().equals("용산점")){out.print(" selected=\"selected\"");}%>>용산점</option>
					<option value="중계점"<%if(restaurant.getArea().equals("중계점")){out.print(" selected=\"selected\"");}%>>중계점</option>
					<option value="천호점"<%if(restaurant.getArea().equals("천호점")){out.print(" selected=\"selected\"");}%>>천호점</option>
					<option value="청담점"<%if(restaurant.getArea().equals("청담점")){out.print(" selected=\"selected\"");}%>>청담점</option>
					<option value="피카디리점"<%if(restaurant.getArea().equals("피카디리점")){out.print(" selected=\"selected\"");}%>>피카디리점</option>
					<option value="하계점"<%if(restaurant.getArea().equals("하계점")){out.print(" selected=\"selected\"");}%>>하계점</option>
					<option value="홍대점"<%if(restaurant.getArea().equals("홍대점")){out.print(" selected=\"selected\"");}%>>홍대점</option>
					</optgroup>
					<optgroup label ="[경기]">
					<option value="경기광주점"<%if(restaurant.getArea().equals("경기광주점")){out.print(" selected=\"selected\"");}%>>경기광주점</option>
					<option value="광교상현점"<%if(restaurant.getArea().equals("광교상현점")){out.print(" selected=\"selected\"");}%>>광교상현점</option>
					<option value="광명철산점"<%if(restaurant.getArea().equals("광명철산점")){out.print(" selected=\"selected\"");}%>>광명철산점</option>
					<option value="구리점"<%if(restaurant.getArea().equals("구리점")){out.print(" selected=\"selected\"");}%>>구리점</option>
					<option value="김포점"<%if(restaurant.getArea().equals("김포점")){out.print(" selected=\"selected\"");}%>>김포점</option>
					<option value="동백점"<%if(restaurant.getArea().equals("동백점")){out.print(" selected=\"selected\"");}%>>동백점</option>
					<option value="동수원점"<%if(restaurant.getArea().equals("동수원점")){out.print(" selected=\"selected\"");}%>>동수원점</option>
					<option value="동탄점"<%if(restaurant.getArea().equals("동탄점")){out.print(" selected=\"selected\"");}%>>동탄점</option>
					<option value="배곧점"<%if(restaurant.getArea().equals("배곧점")){out.print(" selected=\"selected\"");}%>>배곧점</option>
					<option value="범계점"<%if(restaurant.getArea().equals("범계점")){out.print(" selected=\"selected\"");}%>>범계점</option>
					<option value="부천점"<%if(restaurant.getArea().equals("부천점")){out.print(" selected=\"selected\"");}%>>부천점</option>
					<option value="부천역점"<%if(restaurant.getArea().equals("부천역점")){out.print(" selected=\"selected\"");}%>>부천역점</option>
					<option value="북수원점"<%if(restaurant.getArea().equals("북수원점")){out.print(" selected=\"selected\"");}%>>북수원점</option>
					<option value="산본점"<%if(restaurant.getArea().equals("산본점")){out.print(" selected=\"selected\"");}%>>산본점</option>
					<option value="소풍점"<%if(restaurant.getArea().equals("소풍점")){out.print(" selected=\"selected\"");}%>>소풍점</option>
					<option value="수원점"<%if(restaurant.getArea().equals("수원점")){out.print(" selected=\"selected\"");}%>>수원점</option>
					<option value="시흥점"<%if(restaurant.getArea().equals("시흥점")){out.print(" selected=\"selected\"");}%>>시흥점</option>
					<option value="안산점"<%if(restaurant.getArea().equals("안산점")){out.print(" selected=\"selected\"");}%>>안산점</option>
					<option value="안성점"<%if(restaurant.getArea().equals("안성점")){out.print(" selected=\"selected\"");}%>>안성점</option>
					<option value="역곡점"<%if(restaurant.getArea().equals("역곡점")){out.print(" selected=\"selected\"");}%>>역곡점</option>
					<option value="오리점"<%if(restaurant.getArea().equals("오리점")){out.print(" selected=\"selected\"");}%>>오리점</option>
					<option value="용인점"<%if(restaurant.getArea().equals("용인점")){out.print(" selected=\"selected\"");}%>>용인점</option>
					<option value="의정부점"<%if(restaurant.getArea().equals("의정부점")){out.print(" selected=\"selected\"");}%>>의정부점</option>
					<option value="일산점"<%if(restaurant.getArea().equals("일산점")){out.print(" selected=\"selected\"");}%>>일산점</option>
					<option value="죽전점"<%if(restaurant.getArea().equals("죽전점")){out.print(" selected=\"selected\"");}%>>죽전점</option>
					<option value="파주문산점"<%if(restaurant.getArea().equals("파주문산점")){out.print(" selected=\"selected\"");}%>>파주문산점</option>
					<option value="판교점"<%if(restaurant.getArea().equals("판교점")){out.print(" selected=\"selected\"");}%>>판교점</option>
					<option value="평촌점"<%if(restaurant.getArea().equals("평촌점")){out.print(" selected=\"selected\"");}%>>평촌점</option>
					<option value="평택비전점"<%if(restaurant.getArea().equals("평택비전점")){out.print(" selected=\"selected\"");}%>>평택비전점</option>
					<option value="평택소사점"<%if(restaurant.getArea().equals("평택소사점")){out.print(" selected=\"selected\"");}%>>평택소사점</option>
					<option value="화정점"<%if(restaurant.getArea().equals("화정점")){out.print(" selected=\"selected\"");}%>>화정점</option>
					</optgroup>
				</select>
					</div>
				</div>
			<div class="form-group row">
					<label for="inputLoc" class="col-sm-2 col-form-label">장소</label>
					<div class="col-sm-10">
					<div class="input-group mb-3">
						<input class="form-control" type="text" class="form-control" id="searchLoc" name="search_loc" placeholder="위치를 입력하세요." onkeypress="if(event.keyCode==13){search_location(); return false;}">
						<div class="input-group-append">
							<button class="btn btn-outline-secondary" type="button" onclick="search_location();">검색</button>
						</div>
					</div>
					</div>
					<div class="col-12">
					<div class="form-group row">
						<label for="inputMap" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-10">
			<p>지도를 클릭해 해당 위치에 마커를 입력해주세요!</p>
		<div class="col-sm-10 offset-sm-10">		
				<button class="btn btn-outline-primary" type="button" id="setMarker" style=" bottom: 5px;">입력 완료</button></div>
				<div class="map_wrap">
					<div id="map" style="width: 100%; height: 400px; position: relative; overflow: hidden; margin-bottom: 10px;"></div>
					<div class="hAddr">
						<span class="title">지도중심기준 주소정보</span> <span id="centerAddr"></span>
					</div>
				</div>
				<div id=box style="height: 70px; position: relative; overflow: hidden;"></div>
				<input type="hidden" id="startLat" name="start_lat" value="">
				<input type="hidden" id="startLon" name="start_lon" value="">
			</div>
			</div>
			</div>
			</div>
			<div class="form-group row">
						<label for="exampleTextarea" class="col-sm-2 col-form-label">내용</label>
					<div class="col-sm-10">
				<textarea class="form-control" id="inputContent" name="article_content" rows="10"><%=restaurant.getArticle_content()%></textarea>
			</div>
			</div>
			<div class="form-group row">
				<label for="exampleInputFile" class="col-sm-2 col-form-label">첨부파일</label> 
				<div class="col-sm-10">
				<input type="file" class="form-control-file" id="inputFile" name="article_file" aria-describedby="fileHelp" accept="image/*"> 
				<small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
			</div>
			</div>
</c:if>
		<div class="form-group row text-right">
						<div class="col-sm-12">
			<button type="submit" class="btn btn-sm btn-outline-primary">작성하기</button>
			<button type="reset" class="btn btn-sm btn-outline-danger">다시작성</button>
			<c:if test="<%=board_id == 1 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./free_board.jsp'">목록으로</button>
			</c:if>
			<c:if test="<%=board_id == 2 %>">
			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./cinema_restaurant.jsp'">목록으로</button>
			</c:if>
			</div>
			</div>
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
</body>
</html>