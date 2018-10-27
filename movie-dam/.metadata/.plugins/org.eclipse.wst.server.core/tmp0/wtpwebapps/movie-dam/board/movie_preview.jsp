<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>    
<%
	request.setCharacterEncoding("utf-8");
	String title = "시사회";
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

<div class="container">
	<h3>
		<%=title %>
		<small class="text-muted">Movie Preview</small>
	</h3>
	<div class="btn-group btn-group-toggle" data-toggle="buttons">
		<label class="btn btn-primary"> <input type="checkbox" checked="checked" autocomplete="off">CGV</label> 
		<label class="btn btn-primary"> <input type="checkbox" checked="checked" autocomplete="off">롯데시네마</label> 
		<label class="btn btn-primary"> <input type="checkbox" checked="checked" autocomplete="off">메가박스</label>
	</div>
	<div class="row">
		<div class="col">
			<div class="card" style="width: 18rem;">
				<div class="card-header">
					<span class="badge badge-danger">롯데시네마</span> 
					<a href="http://event.lottecinema.co.kr/LCHS/Contents/Event/stage-greeting-event.aspx?EventID=401070016918152"> '죄 많은 소녀' 관객과의 대화</a>
				</div>
				<a href="http://event.lottecinema.co.kr/LCHS/Contents/Event/stage-greeting-event.aspx?EventID=401070016918152">
					<img class="card-img-top" src="http://img.cgv.co.kr/Movie/Thumbnail/Poster/000080/80986/80986_1000.jpg" alt="Card image cap">
				</a>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">일시 2018.09.15(토) 오후 3:30</li>
					<li class="list-group-item">장소 롯데시네마 월드타워 3관</li>
				</ul>
			</div>
		</div>
		<div class="col">
			<div class="card" style="width: 18rem;">
				<div class="card-header">
					<span class="badge badge-danger">롯데시네마</span> 
					<a href="http://event.lottecinema.co.kr/LCHS/Contents/Event/preview-event.aspx?EventID=401080016918052"> '뽀잉:슈퍼 변신의 비밀' 시사회</a>
				</div>
				<a href="http://event.lottecinema.co.kr/LCHS/Contents/Event/preview-event.aspx?EventID=401080016918052">
					<img class="card-img-top" src="http://www.onlinebee.net/imgdata/onlinebee_net/201808/2018082424592319.jpg" alt="Card image cap">
				</a>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">일시 2018.09.20(목) 오후 7:00</li>
					<li class="list-group-item">장소 광명아울렛, 광복, 김포공항, 대전(백화점), 상인, 수완(아울렛), 수원, 울산(백화점), 월드타워, 율하</li>
				</ul>
			</div>
		</div>
		<div class="col">
			<div class="card" style="width: 18rem;">
				<div class="card-header">
					<span class="badge badge-info">메가박스</span> 
					<a href="http://www.megabox.co.kr/?menuId=event-mov&p=detail&p2=6393"> '안시성' 메가토크</a>
				</div>
				<a href="http://www.megabox.co.kr/?menuId=event-mov&p=detail&p2=6393">
					<img class="card-img-top" src="http://tenasia.hankyung.com/webwp_kr/wp-content/uploads/2018/08/2018082908361030357-540x772.jpg" alt="Card image cap">
				</a>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">일시 2018.09.18(화) 오후 7:00</li>
					<li class="list-group-item">장소 메가박스 코엑스 MX</li>
				</ul>
			</div>
		</div>
			
		<a class="btn btn-sm btn-outline-secondary" href="writeForm.jsp?board_id=4&article_writer=${sessionScope.userid}" role="button" >글쓰기</a>
		
	</div>
	
</div>

<jsp:include page="/module/footer.jsp" flush="false"/>

</body>
</html>