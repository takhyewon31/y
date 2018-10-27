<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "게시글 작성";
	String cb_writer = request.getParameter("cb_writer");
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<!-- ***** Breadcumb Area Start ***** -->
<div class="breadcumb-area bg-img bg-overlay"
	style="background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)"></div>
<!-- ***** Breadcumb Area End ***** -->

<section class="dorne-single-listing-area section-padding-100">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-heading dark text-center">
					<span></span>
					<h4>debate write</h4>
					<p>토론글 작성</p>
				</div>
			</div>
		</div>

		<div class="row justify-content-center">
			<div class="col-12">
				<form method="post" name="writeForm" action="chanban_writePro.jsp" onsubmit="return writeSave()" enctype="multipart/form-data">
					<div class="form-group row">
						<label for="inputWriter" class="col-sm-2 col-form-label">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputWriter" name="cb_writer" value="<%=cb_writer%>" readonly="readonly">
						</div>
					</div>
	
					<div class="form-group row">
						<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputTitle" name="cb_title" maxlength="100">
						</div>
					</div>
					
					<div class="form-group row">
						<select class="form-control" id="inputCbtype" name="cb_type">
							<option value="찬성" selected="selected">찬성</option>
							<option value="반대">반대</option>
						</select>
					</div>
	
					<div class="form-group row">
						<label for="exampleTextarea" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<textarea class="summernote" name="cb_content" rows="3"></textarea>
						</div>
					</div>
					
					<div class="form-group row">
						<label for="exampleInputFile" class="col-sm-2 col-form-label">첨부파일</label> 
						<div class="col-sm-10">
							<input type="file" class="form-control-file" id="inputFile" name="cb_file" aria-describedby="fileHelp" accept="image/*"> 
							<small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
						</div>	
					</div>
					
					<div class="form-group row text-right">
						<div class="col-sm-12">
							<button type="submit" class="btn btn-sm btn-outline-primary">작성하기</button>
							<button type="reset" class="btn btn-sm btn-outline-danger">다시작성</button>
							<button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='debate_chanban.jsp'">목록으로</button>
						</div>
					</div>
	
				</form>
			</div>
		</div>
	
	</div>
</section>

<jsp:include page="/module/footer.jsp" flush="false" />

<script>
$(document).ready(function() {
	  $('.summernote').summernote({
		  height:300
	  });

});
 </script>

<script>
	$(function() {
		$('#datepicker').datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
</script>

</body>
</html>