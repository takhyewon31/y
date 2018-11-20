<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="moviedam.member.MemberDBBean"%>
<%@ page import="moviedam.member.MemberDataBean"%>
<%@ page import="moviedam.board.ArticleDBBean"%>
<%@ page import="moviedam.board.ArticleDataBean"%>
<%@ page import="moviedam.board.ArticlelikeDataBean"%>
<%@ page import="moviedam.board.CommentDBBean"%>
<%@ page import="moviedam.board.CommentDataBean"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>


<%
   request.setCharacterEncoding("utf-8");
   String title = "게시글 상세보기";
   String userid = (String) session.getAttribute("userid");
   String category = request.getParameter("category");
   int board_id = Integer.parseInt(request.getParameter("board_id"));
   int count = 0;
   int like_count = 0;
   String like_type = "";
%>

<%
   int article_id = Integer.parseInt(request.getParameter("article_id"));
   String pageNum = request.getParameter("pageNum");

   if (pageNum == null) {
      pageNum = "1";
   }

   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try {
		ArticleDBBean article_db = ArticleDBBean.getInstance();
		ArticleDataBean article = article_db.getArticle(article_id);
		like_type = article_db.getLike_type(board_id, article_id, userid);
		like_count = article_db.getlikeCount(board_id, article_id);

	  	MemberDBBean mem_db = MemberDBBean.getInstance(); 
		MemberDataBean profile =  mem_db.getProfile(article.getArticle_writer());
%>

<%
   ArrayList<CommentDataBean> commentList = null;
      CommentDBBean cmt_db = CommentDBBean.getInstance();
      
      count = cmt_db.getCommentCount(article_id);
      if (count > 0) {
         commentList = cmt_db.getComments(article_id);
      }

      try {
         if (session.getAttribute("userid") == null)
            userid = "not";
         else
            userid = (String) session.getAttribute("userid");
      } catch (Exception e) {}
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />

<!-- ***** Breadcumb Area Start ***** -->
<div class="breadcumb-area bg-img bg-overlay" style="background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)"></div>
<!-- ***** Breadcumb Area End ***** -->

<section class="dorne-single-listing-area section-padding-100">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-heading dark text-center">
					<span></span>
					<h4>Free board</h4>
					<p></p>
				</div>
			</div>
		</div>
		<div class="row justify-content-center">
				<div class="col-10">
				<div class="single-listing-content">
					<h5><span class="badge badge-pill badge-primary"><%=article.getCategory()%></span></h5>
					<div class="listing-title">
						<h4><%=article.getArticle_title()%></h4>
						<span>작성자 <a href="/movie-dam/member/profile.jsp?mem_userid=<%=profile.getMem_userid()%>"><%=profile.getMem_nickname()%></a>&nbsp;(<%=sdf.format(article.getReg_date())%>)</span> 
						<span><i class="fas fa-eye"></i> <%=article.getArticle_hits()%></span>
					</div>
  <hr>
					<div class="overview-content mt-50" id="overview">
						<p><%=article.getArticle_content().replace("\r\n", "<br>")%></p>
					</div>
<%
                     if (article.getArticle_file() != null) {
%>
					<img src="/movie-dam/imageFolder/free_board/<%=article.getArticle_file()%>" width="500px">
<%
                     }
%>
					<div class="text-right" style="padding-bottom:15px;">
<%
               		if (userid.equals("not")) {
%>
						<button type="button" class="btn btn-sm btn-outline-primary" disabled="disabled">수정</button>
						<button type="button" class="btn btn-sm btn-outline-danger" disabled="disabled">삭제</button>
<%
               		} else {
%>
						<form id="likeForm" method="post"></form>
						<button type="button" class="btn btn-sm btn-outline-primary" onclick="location.href='updateForm.jsp?board_id=<%=board_id%>&article_id=<%=article_id%>&pageNum=<%=pageNum%>&article_writer=${sessionScope.userid}&category=<%=category%>'">수정</button>
						<button type="button" class="btn btn-sm btn-outline-danger" onclick="location.href='deletePro.jsp?board_id=<%=board_id%>&article_id=<%=article_id%>&pageNum=<%=pageNum%>&article_writer=${sessionScope.userid}'">삭제</button>
<%
               		}
%>
						<button type="button" class="btn btn-outline-default btn-sm" onclick="location.href='free_board.jsp?pageNum=<%=pageNum%>&category=<%=category%>'">글목록</button>
					</div>
				</div>
			</div>

			<!-- 댓글 시작 -->
		<%
            int cmt_id = 0, cmt_parent = 1, cmt_restep = 0, cmt_relevel = 0;
         
            if(request.getParameter("cmt_id")!=null){
               cmt_id = Integer.parseInt(request.getParameter("cmt_id"));
               cmt_parent = Integer.parseInt(request.getParameter("cmt_parent"));
               cmt_restep = Integer.parseInt(request.getParameter("cmt_restep"));
               cmt_relevel = Integer.parseInt(request.getParameter("cmt_relevel"));
            }
        %>

			<div class="container">
				<form action="contentPro.jsp">
					<input type="hidden" name="cmt_id" value="<%=cmt_id%>"> 
					<input type="hidden" name="cmt_parent" value="<%=cmt_parent%>"> 
					<input type="hidden" name="cmt_restep" value="<%=cmt_restep%>"> 
					<input type="hidden" name="cmt_relevel" value="<%=cmt_relevel%>">

					<input type="hidden" name="cmt_ref" value="<%=article.getArticle_id()%>"> 
					<input type="hidden" name="pageNum" value="<%=pageNum%>"> 
					<input type="hidden" name="cmt_writer" value="<%=userid%>"> 
					<input type="hidden" name="board_id" value="<%=board_id%>"> 
					<input type="hidden" name="category" value="<%=category%>">
					
					<div class="card">
					  <div class="card-body">
					    <div class="form-group text-center">comment <span>(<%=count%>)</span></div>
					    <hr>
    				
	    				<div class="form-group row">
							<label class="col-sm-12" ></label>
						    <label class="col-sm-2 col-form-label text-center"><%=userid%></label>
						    <div class="col-sm-10">
						      <textarea class="form-control" name="cmt_content"></textarea>
						    </div>
						 </div>
					 
						 <div class="form-group row text-right">
						    <div class="col-sm-12">
						      <button type="submit" class="btn btn-outline-default btn-sm">댓글작성</button>
						      <button type="reset" class="btn btn-outline-danger btn-sm">다시입력</button>
						    </div>
						  </div>
						</div>
					</div>
				</form>
<%
         		if (commentList != null && commentList.size() > 0) {
               		for (int i = 0; i < commentList.size(); i++) {
                  		CommentDataBean comment = commentList.get(i);
                  		MemberDataBean writer_profile = mem_db.getProfile(comment.getCmt_writer());
%>
				<form name="updatecomment" method="post" action="contentPro.jsp">
<%
               		if(comment.getCmt_restep() != 0){
%>						
						<hr>
						<div class="form-group row">
						    <label class="col-sm-3 col-form-label text-right"><img src="/movie-dam/assets/img/profile-img/<%=writer_profile.getMem_img() %>" width="128"></label>
						    <div class="col-sm-9">
						      <b><%=comment.getCmt_writer()%></b>(<%=comment.getCmt_date()%>)<br>
						      <%=comment.getCmt_content()%>
							</div>
						</div>
<%                   
               		}else{
%>
						<hr>
						<div class="form-group row">	
							<label class="col-sm-2 col-form-label text-center">
								<img src="/movie-dam/assets/img/profile-img/<%=writer_profile.getMem_img() %>" width="128">
							</label>
							<div class="col-sm-10">
								<b><%=comment.getCmt_writer()%></b>(<%=comment.getCmt_date()%>)<br>
								<%=comment.getCmt_content()%>
							</div>
						</div>

						
<%                   
                  }
%>
<%
				if(comment.getCmt_restep() != 0){
           			if (userid.equals(comment.getCmt_writer()) ) {
%>              		
           				<div class="col-sm-12 text-right">
						    <button type="button" class="btn btn-sm btn-outline-primary" onclick="updateOpen(<%=comment.getCmt_id()%>, <%=article_id%>, <%=pageNum%>, <%=board_id%>, '<%=category%>');">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger" onclick="document.location.href='deleteCommentPro.jsp?article_id=<%=article_id%>&cmt_id=<%=comment.getCmt_id()%>&userid=<%=userid%>&pageNum=<%=pageNum%>&cmt_ref=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>&category=<%=category%>'">삭제</button>
						</div>
<%					} else { %>
					<div class="col-sm-12 text-right">
					    <button type="button" class="btn btn-sm btn-outline-primary" disabled="disabled" style="display:none;">수정</button>
						<button type="button" class="btn btn-sm btn-outline-danger" disabled="disabled" style="display:none;">삭제</button>
					</div>
<%                   
					}
               
           		}else{
%>

					<div class="col-sm-12 text-right">
<%
						if (userid.equals(comment.getCmt_writer()) ) {
%>
						    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateOpen(<%=comment.getCmt_id()%>, <%=article_id%>, <%=pageNum%>, <%=board_id%>, '<%=category%>');">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger" onclick="document.location.href='deleteCommentPro.jsp?article_id=<%=article_id%>&cmt_id=<%=comment.getCmt_id()%>&userid=<%=userid%>&pageNum=<%=pageNum%>&cmt_ref=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>&category=<%=category%>'">삭제</button>
<%
						} else {
%>
							<button type="button" class="btn btn-sm btn-outline-secondary" disabled="disabled" style="display:none;">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger" disabled="disabled" style="display:none;">삭제</button>
<%						
						} 
%>
							 <a class="btn btn-outline-default btn-sm" onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)"> 답글쓰기 </a><div style="display: none">

								<input type="hidden" name="cmt_id" value="<%=comment.getCmt_id()%>"> 
									<input type="hidden" name="cmt_parent" value="<%=comment.getCmt_parent()%>">
									<input type="hidden" name="cmt_restep" value="<%=comment.getCmt_restep()%>"> 
									<input type="hidden" name="cmt_relevel" value="<%=comment.getCmt_relevel()%>">
									 
									<input type="hidden" name="cmt_ref" value="<%=article_id%>">
									<input type="hidden" name="pageNum" value="<%=pageNum%>">
									<input type="hidden" name="cmt_writer" value="<%=userid%>">
									<input type="hidden" name="userid" value="<%=userid%>">
									<input type="hidden" name="board_id" value="<%=board_id%>">
									<input type="hidden" name="category" value="<%=category%>">
	
								<div class="card">
								  <div class="card-body">
								    <div class="form-group text-center">reply</div>
								    <hr>
			    				
				    				<div class="form-group row">
										<label class="col-sm-12" ></label>
									    <label class="col-sm-2 col-form-label text-center"><%=userid%></label>
									    <div class="col-sm-10 text-left">
									      <textarea class="form-control" name="cmt_content"></textarea>
									    </div>
									 </div>
								 
									 <div class="form-group row text-right">
									    <div class="col-sm-12">
									      <button type="submit" class="btn btn-outline-default btn-sm">댓글작성</button>
									      <button type="reset" class="btn btn-outline-danger btn-sm">다시입력</button>
									    </div>
									 </div>
									  
									</div>
								</div>
									
							</div>
						</div>
<%                   
              	}
	    }
	}
%>

<%

                     } catch (Exception e) {

                     }
%>

			
	</div>
</section>

<jsp:include page="/module/footer.jsp" flush="false" />


<script>
function updateOpen(cmt_id, article_id, pageNum, board_id, category) {
   url = 'updateCommentForm.jsp?cmt_id=' + cmt_id + '&article_id=' + article_id + '&pageNum=' + pageNum + '&board_id=' + board_id + '&category=' + category;
   window.open(url, '댓글 수정', 'height=200, width=400, scrollbars=no, resizable=no');
}
</script>

<script>
$(document).ready(function() {
   var rs = [];
   var like_type = '<%=like_type%>';
   var like_count = <%=like_count%>;
   var board_id = <%=board_id%>;
   var article_id = '<%=article_id%>';
   var mem_id = '<%=userid%>';
   if(like_type=='N') {
      rs.push('<button class="btn btn-link" type="submit" id="like" ><i id="likeIcon" class="far fa-heart fa-lg" style="color:black;"></i></button><span id="likeCount">'+like_count+'개</span>');
      rs.push('<input type="hidden" name="currentLike" value="N">');
      rs.push('<input type="hidden" name="board_id" value="'+board_id+'">');
      rs.push('<input type="hidden" name="article_id" value="'+article_id+'">');
      rs.push('<input type="hidden" name="mem_id" value="'+mem_id+'">');
      $('#likeForm').append(rs.join(''));
   } else if(like_type=='Y') {
      rs.push('<button class="btn btn-link" type="submit" id="like" ><i id="likeIcon" class="fas fa-heart fa-lg" style="color:red;"></i></button><span id="likeCount">'+like_count+'개</span>');
      rs.push('<input type="hidden" name="currentLike" value="Y">');
      rs.push('<input type="hidden" name="board_id" value="'+board_id+'">');
      rs.push('<input type="hidden" name="article_id" value="'+article_id+'">');
      rs.push('<input type="hidden" name="mem_id" value="'+mem_id+'">');
      $('#likeForm').append(rs.join(''));
   }
   
   var currentLike = '';

   $('#likeForm').submit(function(event) {
      event.preventDefault();
      var $form = $(this),
      board_id = $form.find('input[name="board_id"]').val(),
      article_id = $form.find('input[name="article_id"]').val(),
      mem_id = $form.find('input[name="mem_id"]').val(),
      like_type = $form.find('input[name="currentLike"]').val();

      var posting = $.post('content_like_pro.jsp', { 
         board_id: board_id,
         article_id: article_id,
         mem_id: mem_id,
         currentLike: like_type
      });
      posting.done(function(data) {
         console.log(data);
         $('#likeForm').find('input[name="currentLike"]').val(data.ltype);
         
         if(data.ltype == 'Y') {
			$('#likeIcon').removeClass('far');
            $('#likeIcon').addClass('fas');
            $('#likeIcon').attr('style', 'color:red');
         } else if(data.ltype == 'N') {
            $('#likeIcon').removeClass('fas');
            $('#likeIcon').addClass('far');
            $('#likeIcon').attr('style', 'color:black');
         }
          
         $('#likeCount').html(data.lcount+'개');
      });
   });
   
});
</script>

<script>
$(document).ready(function() {
	$('#like').click(function(){
		$('#likeIcon').toggleClass("animated bounce",function(){
			$(this).remove(); 
		});
	})
});  
</script>

</body>
</html>