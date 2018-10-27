<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("utf-8");
	String title = "박스오피스";
	String api_key = "a19c59ff51a6a8f37d37e30cd7e64bb9";
	String api_key2 = "9dd279523f7113a4103a8f1e9ef6abe3";
	String selectedDate = request.getParameter("targetDate");
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
                <h4>Box office</h4>
                <p>일간 박스오피스</p>
            </div>
        </div>
    </div>

	<div class="row">
		<form action="./movie_boxoffice.jsp" onsubmit="return selectDate();">
			<div class="form-group" id="selectTargetDate">
				<div class="input-group input-group-alternative">
					<div class="input-group-prepend">
						<span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
					</div>
					<c:if test="<%=selectedDate == null %>">
					<input class="form-control datepicker" name="targetDate" placeholder="Select date" type="text" value="오늘 날짜">
					</c:if>
					<c:if test="<%=selectedDate != null %>">
					<input class="form-control datepicker" name="targetDate" placeholder="Select date" type="text" value="<%=selectedDate%>">
					</c:if>
				</div>
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-dark btn-sm">찾기</button> 
			</div>
		</form>
	</div>
	<div class="row">
<% 
	for(int i=0; i<10; i++) {
%>
		<div class="col-12 col-sm-6 col-lg-4" id="resultBoxOffice<%=i %>">
			<div class="single-features-area mb-50">
			<a href="movie_detail.jsp" class="detail_link"><img src="#" alt="" class="poster_path"></a>
				<div class="price-start"></div>
				<div class="feature-content d-flex align-items-center justify-content-between">
					<div class="feature-title">
						
					</div>
					<div class="feature-favourite">
						<a href="#" data-toggle="modal" onclick="openModal(<%=i %>)" data-target=".showChart<%=i %>" class="card-link"><i class="fas fa-chart-bar"></i></a>
					</div>
				</div>
			</div>
		</div>
<%	} %>
	</div>
<%	
	for(int i=0; i<10; i++) {
%>
	<div class="modal showChart<%=i %>" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<div class="h5 modal-title modalTitle"> </div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<span id="chartSalesInten<%=i %>" style='width: 450px; height: 250px; display: inline-block'></span>
					<span id="chartAudiInten<%=i %>" style='width: 450px; height: 250px; display: inline-block'></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<%	} %>
</div>
</section>

<jsp:include page="/module/footer.jsp" flush="false"/>

<script>
$(function() {
	$('.datepicker').datepicker({ 
        autoclose: true,
        format: 'yyyy/mm/dd'
	});
});
</script>

<script>
var audiAcc = [], title = [], openDt = [], rankOldAndNew = [], rank = [], rankInten = [], salesAmt = [], salesAcc = [], salesInten = [], audiCnt = [], audiAcc = [], audiInten = [];
var targetDate = '<%=selectedDate%>';
if (targetDate == 'null') {
	var now = new Date();
	now.setDate(now.getDate()-1);
	var todayUTC = new Date(Date.UTC(now.getFullYear(), now.getMonth(), now.getDate()));
	targetDate = todayUTC.toISOString().slice(0, 10).replace(/-/g, '');
} else {
	targetDate = targetDate.replace(/(\d\d)\/(\d\d)\/(\d{4})/, '$3-$1-$2');
	targetDate = targetDate.replace(/\-/g,'');
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function openModal(i) {
	var rankNumber = rank.map(Number);
	var rankIntenNumber = rankInten.map(Number);
	var salesAmtNumber = salesAmt.map(Number);
	var salesIntenNumber = salesInten.map(Number);
	var audiCntNumber = audiCnt.map(Number);
	var audiIntenNumber = audiInten.map(Number);
	
	$('.showChart'+i+'').find('.modalTitle').html(title[i]);
	$('.showChart'+i+'').find('.modalTitle').append(' <span class="oldOrNew">'+rankOldAndNew[i]+'</span>');
	if(rankOldAndNew[i]=='OLD') {
		$('.showChart'+i+'').find('.oldOrNew').addClass('badge badge-dark');
	} else {
		$('.showChart'+i+'').find('.oldOrNew').addClass('badge badge-info');
	}
	$('.showChart'+i+'').find('.modalRankInten').append(rankInten[i]);
	
	google.charts.load('current', {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart1);
    google.charts.setOnLoadCallback(drawChart2);
    function drawChart1() {
        var oldData1 = google.visualization.arrayToDataTable([
          ['Name', '매출액'],
          [title[i], salesAmtNumber[i] - salesIntenNumber[i]]
        ]);

        var newData1 = google.visualization.arrayToDataTable([
          ['Name', '매출액'],
          [title[i], salesAmtNumber[i]]
        ]);

        var colChartDiff1 = new google.visualization.ColumnChart(document.getElementById('chartSalesInten'+i+''));

        var options1 = { 
        		legend: { position: 'top' }, 
        		title: '전일 대비 매출액 증감분'		
        };

        var diffData1 = colChartDiff1.computeDiff(oldData1, newData1);
        colChartDiff1.draw(diffData1, options1);
      }
    function drawChart2() {
        var oldData2 = google.visualization.arrayToDataTable([
          ['Name', '관객수'],
          [title[i], audiCntNumber[i] - audiIntenNumber[i]]
        ]);

        var newData2 = google.visualization.arrayToDataTable([
          ['Name', '관객수'],
          [title[i], audiCntNumber[i]]
        ]);

        var colChartDiff2 = new google.visualization.ColumnChart(document.getElementById('chartAudiInten'+i+''));

        var options2 = { 
        		legend: { position: 'top' }, 
        		title: '전일 대비 관객수 증감분'		
        };

        var diffData2 = colChartDiff2.computeDiff(oldData2, newData2);
        colChartDiff2.draw(diffData2, options2);
      }
}
$(document).ready(function() {
	var settings = {
		type: 'GET',
		url: 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json',
		data: {
			'key': '<%=api_key%>',
			'targetDt': targetDate
		}
	}
	$.ajax(settings).done(function (response) {
		console.log(response);
		var rs = [];
		for(var i=0; i<response['boxOfficeResult']['dailyBoxOfficeList'].length; i++) {
			var settings2 = {
				async: false,
				crossDomain: true,
				url: 'https://api.themoviedb.org/3/search/movie',
				method: 'GET',
				headers: {},
				data: {
					'region': 'KR',
				  	'include_adult': false,
					'page': 1,
					'query': response['boxOfficeResult']['dailyBoxOfficeList'][i]['movieNm'],
					'language': 'ko-KR',
					'api_key': '<%=api_key2%>'
			  	}
			}

			$.ajax(settings2).done(function (response2) {
				title.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['movieNm']);
				rank.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['rank']);
				rankInten.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['rankInten']);
				rankOldAndNew.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['rankOldAndNew']);
				audiCnt.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['audiCnt']);
				audiAcc.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['audiAcc']);
				audiInten.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['audiInten']);
				salesAmt.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['salesAmt']);
				salesAcc.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['salesAcc']);
				salesInten.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['salesInten']);
				openDt.push(response['boxOfficeResult']['dailyBoxOfficeList'][i]['openDt']);
				
				console.log(response2);
/* 				if(response2['results'].length != 0) { */
					$('#resultBoxOffice'+i+'').find('.detail_link').attr('href', 'movie_detail.jsp?id='+response2['results'][0]['id']+'');
					$('#resultBoxOffice'+i+'').find('.poster_path').attr('src', 'https://image.tmdb.org/t/p/original'+response2['results'][0]['poster_path']+'');
/* 				} */
				if(rankInten[i] > 0) {
					$('#resultBoxOffice'+i+'').find('.price-start').html('<p>'+rank[i]+'위 (<i class="fas fa-caret-up" style="color:blue"></i>'+rankInten[i]+')</p>');
				} else if(rankInten[i] == 0) {
					$('#resultBoxOffice'+i+'').find('.price-start').html('<p>'+rank[i]+'위 (<i class="fas fa-minus fa-xs" style="color:black"></i>'+rankInten[i]+')</p>');
				} else {
					$('#resultBoxOffice'+i+'').find('.price-start').html('<p>'+rank[i]+'위 (<i class="fas fa-caret-down" style="color:red"></i>'+Math.abs(rankInten[i])+')</p>');
				}
				$('#resultBoxOffice'+i+'').find('.feature-title').html('<h5>'+title[i]+'</h5><p>누적관객수 '+numberWithCommas(audiAcc[i])+'명</p><p>누적매출액 '+numberWithCommas(salesAcc[i])+'원</p>');
				
			});	
			
		}
	});
		
});
</script>

</body>
</html>