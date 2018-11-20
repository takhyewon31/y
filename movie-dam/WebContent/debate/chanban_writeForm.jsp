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
					<input type="hidden" id="inputWriter" name="cb_writer" value="<%=cb_writer%>">

					<div class="form-group row mb-3">
						<label for="inputWriter" class="col-sm-2 col-form-label">영화</label>
						<div class="input-group col-sm-10">
							<input type="text" class="form-control" id="inputWriter" name="cb_movie" placeholder="검색 버튼을 눌러 영화를 찾아주세요." readonly="readonly" required="required">
							<div class="input-group-append">
								<button type="button" class="btn btn-outline-secondary" onclick="search_movie();">검색</button>
							</div>
						</div>
					</div>

					<div class="form-group row mb-3">
						<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputTitle" name="cb_title" maxlength="100" placeholder="글 제목을 입력해 주세요." required="required">
						</div>
					</div>
					
					<div class="form-group row mb-3">
						<label for="inputCbtype_chan" class="col-sm-2 col-form-label">찬반</label>					
						<div class="custom-file col-sm-10">
							<div class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="inputCbtype_chan" name="cb_type" class="custom-control-input" value="찬성">
								<label class="custom-control-label" for="inputCbtype_chan">찬성</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="inputCbtype_ban" name="cb_type" class="custom-control-input" value="반대">
								<label class="custom-control-label" for="inputCbtype_ban">반대</label>
							</div>
						</div>
					</div>
	
					<div class="form-group row mb-3">
						<label for="inputFile" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<textarea class="summernote" id="inputFile" name="cb_content" rows="3" required="required"></textarea>
						</div>
					</div>
										
					<div class="form-group row mb-3">
						<label for="inputFile" class="col-sm-2 col-form-label">첨부파일</label>
						<div class="custom-file col-sm-10">
							<input type="file" class="custom-file-input" id="inputFile" name="cb_file" accept="image/*">
							<label class="custom-file-label" for="customFile">파일 선택...</label>
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
function search_movie() {
	open('searchMovie.jsp', '영화 검색', 'height=800, width=600, menubar=no, scrollbars=no, toolbar=no, location=no, status=no, resizable=no');
}
$(document).ready(function() {
	  $('.summernote').summernote({
		  height:300
	  });
});
</script>

</body>
</html>