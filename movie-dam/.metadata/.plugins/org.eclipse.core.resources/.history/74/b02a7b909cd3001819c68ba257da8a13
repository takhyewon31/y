<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "로그인";
%>
<%
	Cookie[] cookies = request.getCookies();
	String userid = "";
	if (cookies != null) { //쿠키가 존재하면
		for (int i=0; i<cookies.length; i++) {
			if ( cookies[i].getName().equals("userid")) {
				userid = cookies[i].getValue(); //찾은 쿠키값 가져오기
			}
		}
	}
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

<main>
<section class="section section-shaped section-lg">
	<div class="shape shape-style-1 bg-gradient-default">
		<span></span> <span></span> <span></span> <span></span> <span></span>
		<span></span> <span></span> <span></span>
	</div>
	<div class="container pt-lg-md">
		<div class="row justify-content-center">
			<div class="col-lg-5">
				<div class="card bg-secondary shadow border-0">
					<div class="card-body px-lg-5 py-lg-5">
						<div class="text-center text-muted mb-4">
							<small>Sign in with credentials</small>
						</div>
						<form role="form" name="loginForm" method="post" action="login_pro.jsp">
							<div class="form-group mb-3">
								<div class="input-group input-group-alternative">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-email-83"></i></span>
									</div>
									<input class="form-control" placeholder="User id" type="text" id="inputUserId" name="mem_userid" required="required" value="<%=userid %>">
								</div>
							</div>
							<div class="form-group">
								<div class="input-group input-group-alternative">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
									</div>
									<input class="form-control" placeholder="Password" type="password" id="inputPassword" name="mem_pwd" placeholder="Password" required="required">
								</div>
							</div>
							<div class="custom-control custom-control-alternative custom-checkbox">
								<input class="custom-control-input" type="checkbox" id="idCheck" name="saveId"<% if(userid.isEmpty()==false) out.print(" checked=\"checked\"");%>> 
								<label class="custom-control-label" for="idCheck"> <span>Remember me</span></label>
							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-primary my-4">Sign in</button>
							</div>
						</form>
					</div>
				</div>
				<div class="row mt-3">
					<div class="col-6">
						<a href="#" class="text-light" onclick="history.go(-1);"> <small>Return to previous</small></a>
					</div>
					<div class="col-6 text-right">
						<a href="signup_form.jsp" class="text-light"> <small>Create new account</small></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</main>

<jsp:include page="/module/footer.jsp" flush="false"/>

</body>
</html>