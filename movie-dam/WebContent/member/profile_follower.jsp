<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="moviedam.member.MemberDBBean" %>
<%@ page import="moviedam.member.MemberDataBean" %>
<%@ page import="moviedam.member.FollowDBBean" %>
<%@ page import="moviedam.member.FollowDataBean" %>
<%
	request.setCharacterEncoding("utf-8");
	String userid = (String)session.getAttribute("userid");
	String mem_userid = request.getParameter("mem_userid");
	String fol_type = "";
	int follower_cnt = 0;
	int following_cnt = 0;
	String birth = "";
	
	try{
		MemberDBBean mem_db = MemberDBBean.getInstance(); 
		MemberDataBean user_profile = mem_db.getProfile(mem_userid);
		
		FollowDBBean fol_db = FollowDBBean.getInstance(); 
		ArrayList<FollowDataBean> followerList = null;
		followerList = fol_db.getFollowers(mem_userid);
		follower_cnt = fol_db.getFollowerCount(mem_userid);
		following_cnt = fol_db.getFollowingCount(mem_userid);
		
		String title = user_profile.getMem_nickname()+"님의 프로필";
		birth = user_profile.getMem_birth();
%>
<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<main class="profile-page">
<section class="section-profile-cover section-shaped my-0">
	<!-- Circles background -->
	<div class="shape shape-style-1 shape-primary alpha-4">
		<span></span> <span></span> <span></span> <span></span> <span></span>
		<span></span> <span></span>
	</div>
	<!-- SVG separator -->
	<div class="separator separator-bottom separator-skew">
		<svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1" xmlns="http://www.w3.org/2000/svg">
			<polygon class="fill-white" points="2560 0 2560 100 0 100"></polygon>
        </svg>
	</div>
</section>
<section class="section">
	<div class="container">
		<div class="card card-profile shadow mt--300">
			<div class="px-4">
				<div class="row justify-content-center">
					<div class="col-lg-3 order-lg-2">
						<div class="card-profile-image">
							<a href="#"> 
								<img src="/movie-dam/assets/img/profile-img/<%=user_profile.getMem_img()%>" width="800" height="800" class="rounded-circle">
							</a>
						</div>
					</div>
					<div class="col-lg-4 order-lg-3 text-lg-right align-self-lg-center">
						<div class="card-profile-actions py-4 mt-lg-0">
							<a href="#" class="btn btn-sm btn-default float-right">Message</a>
							<% if (user_profile.getMem_userid().equals(userid)) { %>
							<a href="profile_setting.jsp" class="btn btn-sm btn-info mr-4" id="setProfile" data-toggle="tooltip" data-placement="bottom" title="프로필 설정">Setting</a>
							<% } else { %>
							<form id="followForm" method="post"></form>
							<% } %>
						</div>
					</div>
					<div class="col-lg-4 order-lg-1">
						<div class="card-profile-stats d-flex justify-content-center">
							<div>
								<a href="profile_following.jsp?mem_userid=<%=mem_userid%>">
									<span class="heading" id="followingCnt"><%=following_cnt%></span>
									<span class="description">팔로우</span>
								</a>
							</div>
							<div>
								<a href="profile_follower.jsp?mem_userid=<%=mem_userid%>"> 
									<span class="heading" id="followerCnt"><%=follower_cnt%></span> 
									<span class="description">팔로워</span>
								</a>
							</div>
							<div>
								<a href="#"> 
									<span class="heading">26</span> 
									<span class="description">좋아요</span>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="text-center mt-5">
					<h3>
						<a href="profile.jsp?mem_userid=<%=mem_userid%>"><%=user_profile.getMem_nickname()%></a>
						<span class="font-weight-light" id="birth"></span>
					</h3>
					<div class="h6 font-weight-300"><i class="ni location_pin mr-2"></i>자기소개가 없습니다.</div>
				</div>

				<div class="mt-5 py-5 border-top text-center">
					<%
						if (followerList != null && followerList.size() > 0) {
								for (int i = 0; i < followerList.size(); i++) {
									FollowDataBean follower = followerList.get(i);
									MemberDataBean follower_profile = mem_db.getProfile(follower.getMem_id());
					%>
					<div class="single-review-area col">
						<div class="reviewer-meta d-flex align-items-center">
							<img src="/movie-dam/assets/img/profile-img/<%=follower_profile.getMem_img()%>" alt="">
							<div class="reviewer-content">
								<div class="review-title-ratings d-flex justify-content-between">
									<h6>
										<a href="profile.jsp?mem_userid=<%=follower_profile.getMem_userid()%>"><%=follower_profile.getMem_nickname()%>
											<small>(<%=follower.getMem_id()%>)</small>
										</a>
									</h6>
								</div>
								<p>자기소개가 없습니다.</p>
							</div>
						</div>
					</div>
					<%
						}
							} else {
					%>
					<div class="single-review-area col">
							<div class="alert alert-secondary" role="alert">
							    아직 <strong><%=user_profile.getMem_nickname() %></strong>님을 팔로우하는 사람이 없습니다!
							</div>
					</div>
					<%
						}
					%>

				</div>

			</div>
		</div>
	</div>
</section>
</main>

<%
	} catch (Exception e) {
%>
	<script>
		alert('잘못된 접근입니다!');
		history.go(-1);
	</script>		
<%
	}
%>

<jsp:include page="/module/footer.jsp" flush="false" />
<script>
$(document).ready(function() {
	var birth = '<%=birth%>';
	var b_year = birth.substring(0,4);
	var b_month = birth.substring(4,6);
	var b_date = birth.substring(6,8);
	var birthday = new Date(b_year+'/'+b_month+'/'+b_date);
	var today = new Date();
	var years = today.getFullYear() - birthday.getFullYear();
	$('#birth').text(', '+years);
	
	var rs = [];
    var mem_id = '<%=userid%>';
    var target_mem_id = '<%=mem_userid%>';
    var fol_type = '<%=fol_type%>';
	var follower_cnt = <%=follower_cnt%>;
	if (fol_type == 'N') {
		rs.push('<button type="submit" class="btn btn-sm btn-info mr-4" id="following">Follow</button>');
		rs.push('<input type="hidden" name="mem_id" value="'+mem_id+'">');
		rs.push('<input type="hidden" name="target_mem_id" value="'+target_mem_id+'">');
		rs.push('<input type="hidden" name="currentFolType" value="N">');
		rs.push('<input type="hidden" name="follower_cnt" value="'+follower_cnt+'">');
		$('#followForm').append(rs.join(''));
	} else if (fol_type == 'Y') {
		rs.push('<button type="submit" class="btn btn-sm btn-danger mr-4" id="following">Unfollow</button>');
		rs.push('<input type="hidden" name="mem_id" value="'+mem_id+'">');
		rs.push('<input type="hidden" name="target_mem_id" value="'+target_mem_id+'">');
		rs.push('<input type="hidden" name="currentFolType" value="Y">');
		rs.push('<input type="hidden" name="follower_cnt" value="'+follower_cnt+'">');
		$('#followForm').append(rs.join(''));
	}

	var currentFolType = '';
	$('#followForm').submit(function(event) {
		event.preventDefault();
		var $form = $(this), 
		mem_id = $form.find('input[name="mem_id"]').val(), 
		target_mem_id = $form.find('input[name="target_mem_id"]').val(), 
		fol_type = $form.find('input[name="currentFolType"]').val();
		follower_cnt = $form.find('input[name="follower_cnt"]').val();

		var posting = $.post('follow_pro.jsp', {
			mem_id : mem_id,
			target_mem_id : target_mem_id,
			currentFolType : fol_type,
			follower_cnt : follower_cnt
		});
		posting.done(function(data) {
			console.log(data);
			$('#followForm').find('input[name="currentFolType"]').val(data.ftype);

			if (data.ftype == 'Y') {
				$('#following').removeClass('btn-info');
				$('#following').addClass('btn-danger');
				$('#following').text('Unfollow');
				$('#followerCnt').text(data.follower_cnt);
			} else if (data.ftype == 'N') {
				$('#following').removeClass('btn-danger');
				$('#following').addClass('btn-info');
				$('#following').text('Follow');
				$('#followerCnt').text(data.follower_cnt);
			}
		});
	});
});
</script>

</body>
</html>