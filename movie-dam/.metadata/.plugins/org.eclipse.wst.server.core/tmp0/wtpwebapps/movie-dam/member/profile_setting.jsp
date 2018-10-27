<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="moviedam.member.MemberDBBean" %>
<%@ page import="moviedam.member.MemberDataBean" %>
<%
	request.setCharacterEncoding("utf-8");
	String userid = (String)session.getAttribute("userid");
	
	try{
		MemberDBBean mem_db = MemberDBBean.getInstance(); 
		MemberDataBean profile =  mem_db.getProfile(userid);

		String title = profile.getMem_nickname()+"님의 프로필";
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<!-- ***** Breadcumb Area Start ***** -->
<div class="breadcumb-area bg-img bg-overlay" style="background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)"></div>
<!-- ***** Breadcumb Area End ***** -->

<!-- ***** Listing Destinations Area Start ***** -->
<section class="dorne-listing-destinations-area section-padding-100-50">
<div class="container">
	<div class="row justify-content-center">
		<div class="col-12 col-sm-6 col-lg-4">
	        <div class="single-features-area mb-50">
	            <img src="/movie-dam/assets/img/profile-img/<%=profile.getMem_img() %>" alt="">
	            <div class="price-start">
	            	<p>최근 접속시간</p>
	            </div>
	            <div class="feature-content d-flex align-items-center justify-content-between">
	                <div class="feature-title">
	                    <h5><%=profile.getMem_nickname() %></h5>
	                    <p><%=profile.getMem_email() %></p>
	                </div>
	                <div class="feature-favourite">
	                    <a href="profile_setting.jsp" id="setProfile" data-toggle="tooltip" data-placement="bottom" title="프로필 설정"><i class="fas fa-cog fa-sm" aria-hidden="true"></i></a>
	                </div>
	            </div>
	        </div>
	    </div>
						
				
	</div>
</div>
</section>		

<%
	} catch(Exception e){
%>
	<script>
		alert('잘못된 접근입니다!');
		history.go(-1);
	</script>		
<%
	}
%>

<jsp:include page="/module/footer.jsp" flush="false" />

</body>
</html>