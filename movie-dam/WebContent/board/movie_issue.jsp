<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>    
<%
	request.setCharacterEncoding("utf-8");
	String title = "영화 이슈";
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

<div class="container">
	<h3>
		<%=title %>
		<small class="text-muted">Movie Issue</small>
	</h3>
	<div class="row">
		<div class="col">
			<div class="card" style="width: 18rem;">
				<a href="https://www.msn.com/ko-kr/entertainment/movies/‘봄이가도’-세월호-4년-그래도-잊지-않겠다는-약속개봉day/ar-BBNggAE">
					<img class="card-img-top" src="https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BBNgnGZ.img?h=385&w=270&m=6&q=60&o=f&l=f&x=282&y=465" alt="Card image cap" >
				</a>
				<div class="card-body">
					<a href="https://www.msn.com/ko-kr/entertainment/movies/‘봄이가도’-세월호-4년-그래도-잊지-않겠다는-약속개봉day/ar-BBNggAE" class="card-text">‘봄이가도’ 세월호 4년, 그래도 잊지 않겠다는 약속[개봉DAY]</a>
			  	</div>
			</div>
		</div>
		<div class="col">
			<div class="card" style="width: 18rem;">
				<a href="http://a.msn.com/07/ko-kr/BBNgdEQ?ocid=st">
					<img class="card-img-top" src="https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BBNgdEP.img?h=387&w=270&m=6&q=60&o=f&l=f&x=394&y=291" alt="Card image cap" >
				</a>
				<div class="card-body">
					<a href="http://a.msn.com/07/ko-kr/BBNgdEQ?ocid=st" class="card-text">260만 돌파 ‘너의 결혼식’ 2018 로맨스 영화 흥행 1위[박스오피스]</a>
			  	</div>
			</div>
		</div>
		<div class="col">
			<div class="card" style="width: 18rem;">
				<a href="http://a.msn.com/07/ko-kr/BBNgvD3?ocid=st">
					<img class="card-img-top" src="https://c-6rtwjumjzx7877x24nrl-x78-rx78s-htrx2efpfrfnejix2esjy.g01.msn.com/g00/3_c-6bbb.rx78s.htr_/c-6RTWJUMJZX77x24myyux78x3ax2fx2fnrl-x78-rx78s-htr.fpfrfneji.sjyx2fyjsfsyx2ffrux2fjsynydnix2fGGSlvmA.nrlx3fmx3d808x26bx3d725x26rx3d1x26vx3d15x26tx3dkx26qx3dkx26cx3d879x26dx3d709x26n65h.rfwpx3dnrflj_$/$/$/$/$" alt="Card image cap" >
				</a>
				<div class="card-body">
					<a href="http://a.msn.com/07/ko-kr/BBNgvD3?ocid=st" class="card-text">‘암수살인’ 감독 “낯설고 생소한 단어를 소재로 한 이유는..”</a>
			  	</div>
			</div>
		</div>	
	</div>
	<div class="row">
		<div class="col">
			<div class="card" style="width: 18rem;">
				<a href="http://a.msn.com/07/ko-kr/BBNg82I?ocid=st">
					<img class="card-img-top" src="https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BBNg82D.img?h=338&w=270&m=6&q=60&o=f&l=f&x=277&y=103" alt="Card image cap" >
				</a>
				<div class="card-body">
					<a href="http://a.msn.com/07/ko-kr/BBNg82I?ocid=st" class="card-text">‘협상’ 손예진 “감옥같았던 촬영장, 심리적 압박 컸다”(인터뷰)</a>
			  	</div>
			</div>
		</div>
		<div class="col">
			<div class="card" style="width: 18rem;">
				<a href="http://a.msn.com/07/ko-kr/BBNfOxf?ocid=st">
					<img class="card-img-top" src="https://c-6rtwjumjzx7877x24nrl-x78-rx78s-htrx2efpfrfnejix2esjy.g01.msn.com/g00/3_c-6bbb.rx78s.htr_/c-6RTWJUMJZX77x24myyux78x3ax2fx2fnrl-x78-rx78s-htr.fpfrfneji.sjyx2fyjsfsyx2ffrux2fjsynydnix2fGGSkZlp.nrlx3fmx3d839x26bx3d725x26rx3d1x26vx3d15x26tx3dkx26qx3dkx26cx3d750x26dx3d662x26n65h.rfwpx3dnrflj_$/$/$/$/$" alt="Card image cap" >
				</a>
				<div class="card-body">
					<a href="http://a.msn.com/07/ko-kr/BBNfOxf?ocid=st" class="card-text">박터지는 추석 극장가, ‘협상’ 유일한 현대극 통할까[무비와치]</a>
			  	</div>
			</div>
		</div>
		<div class="col">
			<div class="card" style="width: 18rem;">
				<a href="http://a.msn.com/07/ko-kr/BBNcT1T?ocid=st">
					<img class="card-img-top" src="https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BBNcVBv.img?h=416&w=799&m=6&q=60&u=t&o=f&l=f" alt="Card image cap" >
				</a>
				<div class="card-body">
					<a href="http://a.msn.com/07/ko-kr/BBNcT1T?ocid=st">‘더 프레데터’ 액션X스케일X캐릭터 관람포인트 셋</a>
			  	</div>
			</div>
		</div>
	</div>
	<a class="btn btn-sm btn-outline-secondary" href="writeForm.jsp?board_id=5&article_writer=${sessionScope.userid}" role="button" >글쓰기</a>
</div>


<jsp:include page="/module/footer.jsp" flush="false"/>

</body>
</html>