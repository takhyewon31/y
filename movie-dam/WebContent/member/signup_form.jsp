<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>    
<%
	request.setCharacterEncoding("utf-8");
	String title = "회원 가입";
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
							<small>Sign up with credentials</small>
						</div>
						<form role="form" name="insertMember" method="post" action="signup_pro.jsp" onsubmit="return formSubmit();">
							<div class="form-group">
								<div class="input-group input-group-alternative mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-hat-3"></i></span>
									</div>
									<input class="form-control" placeholder="User id" type="text" id="inputUserId" name="mem_userid" >
									<div class="input-group-append">
										<button type="button" class="btn btn-sm btn-outline-secondary" onClick="idConfirm(document.getElementById('inputUserId'));">중복확인</button>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group input-group-alternative">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
									</div>
									<input class="form-control" placeholder="Password" type="password"  id="inputPassword" name="mem_pwd" >
								</div>
							</div>
							<div class="form-group">
								<div class="input-group input-group-alternative mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-hat-3"></i></span>
									</div>
									<input class="form-control" placeholder="Nickname" type="text" id="inputNickname" name="mem_nickname" >
									<div class="input-group-append">
										<button type="button" class="btn btn-sm btn-outline-secondary">중복확인</button>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group input-group-alternative mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-email-83"></i></span>
									</div>
									<input class="form-control" placeholder="Email" type="email" id="inputEmail" name="mem_email" required="required">
								</div>
							</div>
							<div class="form-group">
								<div class="input-group input-group-alternative mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-email-83"></i></span>
									</div>
									<input class="form-control" placeholder="Name" type="text" id="inputName" name="mem_name" required="required">
								</div>
							</div>
							<div class="form-group">
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" id="inputGender1" name="mem_gender" value="0" class="custom-control-input">
								  	<label class="custom-control-label" for="inputGender1">남성</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
								  	<input type="radio" id="inputGender2" name="mem_gender" value="1" class="custom-control-input">
								  	<label class="custom-control-label" for="inputGender2">여성</label>
								</div>
							</div>
							<div class="form-row col">
				    			<div class="form-group col-md-4">
				    				<input type="text" class="form-control" id="inputYear" name="mem_year" placeholder="YYYY" maxlength="4" required="required">
				    			</div>
				    			<div class="form-group col-md-4">
				    				<select class="form-control" id="inputMonth" name="mem_month">
				    					<option value="00" selected="selected">MM</option>
				    					<option value="01">01</option>
				    					<option value="02">02</option>
				    					<option value="03">03</option>
				    					<option value="04">04</option>
				    					<option value="05">05</option>
				    					<option value="06">06</option>
				    					<option value="07">07</option>
				    					<option value="08">08</option>
				    					<option value="09">09</option>
				    					<option value="10">10</option>
				    					<option value="11">11</option>
				    					<option value="12">12</option>
				    				</select>
				    			</div>
				    			<div class="form-group col-md-4">
				    				<select class="form-control" id="inputDay" name="mem_day">
				    					<option value="00" selected="selected">DD</option>
				    					<option value="01">01</option>
				    					<option value="02">02</option>
				    					<option value="03">03</option>
				    					<option value="04">04</option>
				    					<option value="05">05</option>
				    					<option value="06">06</option>
				    					<option value="07">07</option>
				    					<option value="08">08</option>
				    					<option value="09">09</option>
				    					<option value="10">10</option>
				    					<option value="11">11</option>
				    					<option value="12">12</option>
				    					<option value="13">13</option>
				    					<option value="14">14</option>
				    					<option value="15">15</option>
				    					<option value="16">16</option>
				    					<option value="17">17</option>
				    					<option value="18">18</option>
				    					<option value="19">19</option>
				    					<option value="20">20</option>
				    					<option value="21">21</option>
				    					<option value="22">22</option>
				    					<option value="23">23</option>
				    					<option value="24">24</option>
				    					<option value="25">25</option>
				    					<option value="26">26</option>
				    					<option value="27">27</option>
				    					<option value="28">28</option>
				    					<option value="29">29</option>
				    					<option value="30">30</option>
				    					<option value="31">31</option>
				    				</select>
				    			</div>
				    		</div>
							<div class="form-group">
								<div class="input-group input-group-alternative mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-hat-3"></i></span>
									</div>
									<input class="form-control" placeholder="Profile image" type="text" id="inputImg" name="mem_img" required="required" readonly="readonly">
									<div class="input-group-append">
										<button type="button" class="btn btn-sm btn-outline-secondary" id="showModal">사진선택</button>
									</div>
								</div>
							</div>
							<div class="modal fade" tabindex="-1" role="dialog" id="imgSelectModal">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h6 class="modal-title" id="modal-title-default">프로필 사진을 선택해 주세요.</h6>
							                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							                    <span aria-hidden="true">×</span>
							                </button>
										</div>
										<div class="modal-body">
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="man-0.png">
											  	<img src="/movie-dam/assets/img/profile-img/man-0.png" width="25%">
											</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="man-1.png">
											  	<img src="/movie-dam/assets/img/profile-img/man-1.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="man-2.png">
											  	<img src="/movie-dam/assets/img/profile-img/man-2.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="man-3.png">
											  	<img src="/movie-dam/assets/img/profile-img/man-3.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="man-4.png">
											  	<img src="/movie-dam/assets/img/profile-img/man-4.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="man-5.png">
											  	<img src="/movie-dam/assets/img/profile-img/man-5.png" width="25%">
											</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="woman-0.png">
											  	<img src="/movie-dam/assets/img/profile-img/woman-0.png" width="25%">
											</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="woman-1.png">
											  	<img src="/movie-dam/assets/img/profile-img/woman-1.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="woman-2.png">
											  	<img src="/movie-dam/assets/img/profile-img/woman-2.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="woman-3.png">
											  	<img src="/movie-dam/assets/img/profile-img/woman-3.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="woman-4.png">
											  	<img src="/movie-dam/assets/img/profile-img/woman-4.png" width="25%">
										  	</label>
											<label class="hide-radio">
												<input type="radio" name="selected_img" value="woman-5.png">
											  	<img src="/movie-dam/assets/img/profile-img/woman-5.png" width="25%">
											</label>
										</div>
										<div class="modal-footer">
							                <button type="button" class="btn btn-primary" id="submitBtn" class="btn btn-primary" data-toggle="modal" data-target="#imageSelectForm">Save changes</button>
							                <button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">Close</button>
							            </div>
									</div>
								</div>
							</div>
							<div class="row my-4">
								<div class="col-12">
									<div class="custom-control custom-control-alternative custom-checkbox">
										<input class="custom-control-input" id="customCheckRegister" type="checkbox"> 
										<label class="custom-control-label" for="customCheckRegister"> 
											<span>I agree with the <a href="#">Privacy Policy</a></span>
										</label>
									</div>
								</div>
							</div>
							<div class="form-group">
				      			<div id="html_element"></div>
				    		</div>
							<div class="text-center">
								<button type="submit" class="btn btn-primary mt-4">Create account</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</main>

<jsp:include page="/module/footer.jsp" flush="false"/>

<script>
$('#showModal').click(function() {
	$('#imgSelectModal').modal('show');
});
$('#submitBtn').click(function() {
	var selected = $('input[name="selected_img"]:checked').val();
	$('#inputImg').val(selected);
	$('#imgSelectModal').modal('hide');
});
</script>

<!-- reCaptcha -->
<script src='https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit' async defer></script>
<script>
var onloadCallback = function() {
    grecaptcha.render('html_element', {
          'sitekey' : '6Ldu9VUUAAAAANn65F6UQgOt0cO2R9oTchhjmiJi'
    });
};
var onReturnCallback = function() {
    var url = 'https://www.google.com/recaptcha/api/siteverify';
};
</script>

<!-- Check reCaptcha -->
<script>
function formSubmit() {
    if (grecaptcha.getResponse() == '') {
        alert('자동 가입 방지 체크를 확인해주세요.');
        return false;
    } else {
        return true;
    }
}
</script> 

<!-- Confirm id -->
<script>
function idConfirm(userid) {
    if(userid.value.length==0) {
        alert('아이디를 입력해 주세요.');
        inputId.focus();
        return false;
    }
    
    //중복 확인 새창
    url = 'idCheck.jsp?mem_userid=' + userid.value;
    open(url, '아이디 중복 체크', 'height=200, width=320, menubar=no, scrollbars=no, toolbar=no, location=no, status=no, resizable=no');
}
</script>

<!-- Check value -->
<script>
function checkValue() {
	if(insertMember.mem_userid.value == '') {
        alert("아이디를 입력해주세요.");
        insertMember.mem_userid.focus();
		return false;
	} else if(insertMember.mem_pwd.value == '') {
        alert("비밀번호를 입력해주세요.");
        insertMember.mem_pwd.focus();
		return false;
	} else if(insertMember.mem_name.value == '') {
        alert("이름을 입력해주세요.");
        insertMember.mem_name.focus();
        return false;
	} else if(insertMember.mem_nickname.value == '') {
        alert("닉네임을 입력해주세요.");
        insertMember.mem_nickname.focus();
        return false;
	} else if(insertMember.mem_email.value == '') {
        alert("이메일을 입력해주세요.");
        insertMember.mem_email.focus();
        return false;
	} else if(insertMember.mem_year.value == '') {
        alert("생년을 입력해주세요.");
        insertMember.mem_year.focus();
        return false;
	} else if(insertMember.mem_month.value == '') {
        alert("월을 선택해주세요.");
        insertMember.mem_year.focus();
        return false;
	} else if(insertMember.mem_day.value == '') {
        alert("일자를 선택해주세요.");
        insertMember.mem_day.focus();
        return false;
	} else if(insertMember.mem_gender.value == '') {
		alert("성별을 입력해주세요.");
        insertMember.gender.focus();
        return false;
	} else if(insertMember.mem_postcode.value == '') {
        alert("우편번호를 입력해주세요.");
        insertMember.mem_postcode.focus();
        return false;
	} else if(insertMember.mem_address.value == '') {
        alert("주소를 입력해주세요.");
        insertMember.mem_address.focus();
        return false;
	} else 
		return true;
    }
</script>

<!-- Cancel -->
<script>
function goMain(){
     location.href="../main.jsp";
}
</script>

</body>
</html>