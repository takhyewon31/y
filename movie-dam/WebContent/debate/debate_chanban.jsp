<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="moviedam.debate.ChanbanDBBean"%>
<%@ page import="moviedam.debate.ChanbanDataBean"%>
<%@ page import="moviedam.debate.ChanbanCommentDBBean"%>
<%@ page import="moviedam.debate.ChanbanCommentDataBean"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "찬반 토론";
	String pageNum = request.getParameter("pageNum");
	String option = request.getParameter("option");
	String search = request.getParameter("search");
%>
<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int ccount = 0;
	int procount = 0;
	int concount = 0;
	int number = 0;
	int total_page = 0;
	String content = "";
	List<ChanbanDataBean> chanbanList = null;

	try {
		ChanbanDBBean chanban_db = ChanbanDBBean.getInstance();

		ArrayList<ChanbanCommentDataBean> commentList = null;
		ChanbanCommentDBBean cb_comment_db = ChanbanCommentDBBean.getInstance();

		count = chanban_db.getChanbanCount(option, search); //전체 글 수
		if (count > 0) {
			chanbanList = chanban_db.getChanbans(startRow, endRow, option, search);
		}

		number = count - (currentPage - 1) * pageSize;
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<div class="breadcumb-area bg-img bg-overlay" style="background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)"></div>

<section class="dorne-listing-destinations-area section-padding-100-50">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-heading dark text-center">
					<h4>Pro and con debate</h4>
					<p>영화를 주제로 한 다양한 찬반 토론 <%=count%>개가 진행중입니다.</p><br>
				</div>
			</div>
		</div>
		
		<div class="row mb-3 mr-2 justify-content-center">
			<div class="col-12">
				<form>
					<div class="form-group">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<select class="form-control" name="option">
									<option value="all">전체글</option>
									<option value="cb_title">제목</option>
									<option value="cb_content">내용</option>
									<option value="cb_writer">작성자</option>
								</select>
							</div>
							<input class="form-control" type="text" name="search" placeholder="관심있는 토론 주제를 검색해 보세요.">
							<div class="input-group-append">
								<input class="btn btn-dark" type="submit" value="검색">
							</div>
						</div>
					</div>
				</form>
			</div>					
		</div>
		<br>
		
		<div class="container">
<%
			if (count == 0) {
%>
			<div class="alert alert-danger" role="alert">게시판에 저장된 글이 없습니다.</div>

<%
			} else {		
%>
			<div class="row justify-content-center">
				<!-- Single Features Area -->
				<div class="col-12">
<%
						int a = count / pageSize + (count % pageSize == 0 ? 0 : 1); //전체페이지 수 
							if (Integer.parseInt(pageNum) > a) {
%>
					<jsp:forward page="error.jsp" />
<%
							}
							
							for (int i = 0; i < chanbanList.size(); i++) {
								ChanbanDataBean chanban = chanbanList.get(i);
								String textWithoutTag = chanban.getCb_content().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");		
								String cb_tag = chanban.getCb_tag();
								pageContext.setAttribute("cb_tag", cb_tag);
								
								ccount = cb_comment_db.getChanbanCmtCount(chanban.getCb_id());
								procount = cb_comment_db.getChanbanProCount(chanban.getCb_id());
								concount = cb_comment_db.getChanbanConCount(chanban.getCb_id());
%>	
					<ul class="list-unstyled">
						<li class="media">
<% 
						if (chanban.getCb_file() != null) {
%>
							<img class="mr-3" src="/movie-dam/imageFolder/debate_chanban/<%=chanban.getCb_file()%>" width="128" height="128" alt="Generic placeholder image">
<%						} else { %>
							<img class="mr-3" src="https://via.placeholder.com/128x128?text=Image+doesn't+exist." alt="Generic placeholder image">
<%						} %>
							<div class="media-body">
								<h5 class="mt-0 mb-1">
									<a href="chanban_content.jsp?cb_id=<%=chanban.getCb_id()%>&pageNum=<%=currentPage%>" style="color: black;"><%=chanban.getCb_title()%></a>
								</h5>
								
								<div style="display: inline-block; whith-space: nowrap; overflow: hidden; text-overflow: ellipsis; line-height: 1.3; height: 5.2em;"><%=textWithoutTag %></div>
								<div class="hashtag mb-3">
									<c:set var="tags" value="${fn:split(cb_tag, '|')}"></c:set>
									<c:forEach var="item" items="${tags}">
									    <a href="#" class="badge badge-primary">#${item}</a>
									</c:forEach>
								</div>
								<div class="pro-con-icon">
									<span id="pros" ><i class="fas fa-thumbs-up fa-sm" style="color:#4374D9;"></i> 찬성 <%=procount %>&nbsp;&nbsp;</span> 
									<span id="cons"><i class="fas fa-thumbs-down fa-sm" style="color:#DF4D4D;"></i> 반대 <%=concount %>&nbsp;&nbsp;</span> 
									<span id="opinion"><i class="fas fa-comments fa-sm"></i> 의견 <%=ccount %></span>
								</div>
							</div>
						</li>
					</ul>
					<hr>
	
<%
						}
%>
				</div>
			</div>
			
		
		<div class="form-group row d-flex justify-content-end">
			<button class="btn btn-dark" onclick="document.location.href='chanban_writeForm.jsp?cb_writer=${sessionScope.userid}'">글쓰기</button>
		</div>
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
<%
					if (count > 0) {
						//전체 페이지수 구하기//50개=>5페이지, 51~59개=>6페이지
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	
						if (pageCount < currentPage) {
							currentPage = pageCount;
						}
						//한 페이지에 보여지는 시작페이지 구하기
						int startPage = 1;
	
						if (currentPage % 10 != 0)
							startPage = (int) (currentPage / 10) * 10 + 1;
						else
							startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
	
						int pageBlock = 10; //한 페이지에 보여줄 페이지수 설정
	
						//한 페이지에 보여지는 끝페이지 구하기
						int endPage = startPage + pageBlock - 1;
						if (endPage > pageCount) {
							endPage = pageCount;
						}
	
						if (startPage > 10) {
%>
				<li class="page-item"><a class="page-link" href="debate_chanban.jsp?pageNum=<%=startPage - 10%>">이전</a></li>
<%
					}
					
					for (int i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
%>
				<li class="page-item active">
					<a class="page-link" href="debate_chanban.jsp?pageNum=<%=i%>"><%=i%><span class="sr-only">(current)</span></a>
				</li>
<%
						} else {
%>
				<li class="page-item"><a class="page-link" href="debate_chanban.jsp?pageNum=<%=i%>"><%=i%></a></li>
<%
						}
					}
					
					if (endPage < pageCount) {
%>
				<li class="page-item"><a class="page-link" href="debate_chanban.jsp?pageNum=<%=startPage + 10%>">다음</a></li>
<%
					}
				}
%>
		
			</ul>
		</nav>
<%
			}	
%>
</div>
	
<% } catch (Exception e) { } %>
	</div>
</section>

<jsp:include page="/module/footer.jsp" flush="false" />

</body>
</html>