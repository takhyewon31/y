<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>    
<%
   request.setCharacterEncoding("utf-8");
   String title = "영화이슈";
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
 <div class="col-lg-4">
   <h6 class="card-header"> 
   <img style="width: 100%; display: block;" 
   src="http://image.cine21.com/resize/cine21/still/2018/0920/14_10_44__5ba32bd4c7137[S250,250].jpg" alt="Card image">
   <ul class="list-group list-group-flush">
   <li class="list-group-item"><a href="http://www.cine21.com/news/view/?idx=1&mag_id=91264">언제 적 백마 탄 왕자님? 로맨스를 벗어난 현빈의 얼굴들</a>
   </li>
   </ul>
   </h6>
   </div>
         
   <div class="col-lg-4">
   <h6 class="card-header"> 
   <img style="width: 100%; display: block;" 
   src="http://image.cine21.com/resize/cine21/still/2018/0910/17_12_00__5b96275062be6[S250,250].jpg" alt="Card image">
   <ul class="list-group list-group-flush">
   <li class="list-group-item"><a href="http://www.cine21.com/news/view/?idx=1&mag_id=91188">'타샤 튜더'에 담긴 자연주의자 타샤 튜더의 삶 </a>
   </li>
   </ul>
   </h6>
   </div>
  	
   <div class="col-lg-4">
   <h6 class="card-header"> 
   <img style="width: 100%; display: block;" 
   src="http://image.cine21.com/resize/cine21/still/2018/0824/14_19_54__5b7f957ae0298[S250,250].jpg" alt="Card image">
   <ul class="list-group list-group-flush">
   <li class="list-group-item"><a href="http://www.cine21.com/news/view/?idx=1&mag_id=91016">‘메이즈 러너’ 이기홍, MBC 드라마 ‘프로메테우스’ 출연 </a>
   </li>
   </ul>
   </h6>
   </div>
   
   <div class="col-lg-4">
   <h6 class="card-header"> 
   <img style="width: 100%; display: block;" 
   src="http://image.cine21.com/resize/cine21/still/2018/0820/14_41_47__5b7a549b41c2f[S250,250].jpg" alt="Card image">
   <ul class="list-group list-group-flush">
   <li class="list-group-item"><a href="http://www.cine21.com/news/view/?idx=1&mag_id=90957">[Coming Soon] ‘체실 비치에서’, 1962년 영국의 체실 비치로 신혼여행을 간 커플 </a>
   </li>
   </ul>
   </h6>
   </div>
  	
   <div class="col-lg-4">
   <h6 class="card-header"> 
   <img style="width: 100%; display: block;" 
   src="http://image.cine21.com/resize/cine21/still/2018/0914/14_49_53__5b9b4c01b470d[S250,250].jpg" alt="Card image">
   <ul class="list-group list-group-flush">
   <li class="list-group-item"><a href="http://www.cine21.com/news/view/?idx=1&mag_id=91202">배우 버트 레이놀즈, 9월 6일 심장마비로 별세 外 </a>
   </li>
   </ul>
   </h6>
   </div>
   
   <div class="col-lg-4">
   <h6 class="card-header"> 
   <img style="width: 100%; display: block;" 
   src="http://image.cine21.com/resize/cine21/still/2018/0907/11_53_33__5b91e82d792c7[S250,250].jpg" alt="Card image">
   <ul class="list-group list-group-flush">
   <li class="list-group-item"><a href="http://www.cine21.com/news/view/?idx=1&mag_id=91144">대니얼 크레이그, ‘스타워즈: 라스트 제다이’ 라이언 존슨 감독 신작에 출연 外</a>
   </li>
   </ul>
   </h6>
   </div>
   
</div>
</div>
<jsp:include page="/module/footer.jsp" flush="false"/>