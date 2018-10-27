<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "토론 배틀";
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
                    <h4>Debate Battle</h4>
                    <p>좀 더 심도있는 토론을  다양한 사람과 나눌 수 있습니다. 토론하고 싶은 주제를 직접 등록하고 참여해 보세요.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Single Features Area -->
            <div class="col-12">
                <ul class="list-unstyled">
					<li class="media">
					  <div class="media-body">
					  <a class="btn btn-sm btn-outline-secondary" href="http://localhost:3005/room" role="button" >글쓰기</a>
					    <h4 class="mt-0 mb-1">‘나의 라임 오렌지나무’ 에서 제제가 아버지에게 담배를 사드린 것은 옳은 일일까?</h4>
					    <button type="button" class="btn btn-outline-primary" onclick="location.href='http://localhost:3005/room/5bc893c298af5813c8ed7b74?password=1234' ">참여하기</button>
					   	<div class="hashtag">
						  	<a type="buttn" class="btn btn-outline-primary btn-sm">#미성년자</a>
						  	<a type="buttn" class="btn btn-outline-primary btn-sm">#가족</a>
						  	<a type="buttn" class="btn btn-outline-primary btn-sm">#가정폭력</a>
					  	</div>
					  </div>
					</li>
				</ul>
            </div>
            
        </div>
    </div>
</section>
<!-- ***** Listing Destinations Area End ***** -->


<jsp:include page="/module/footer.jsp" flush="false"/>

</body>
</html>