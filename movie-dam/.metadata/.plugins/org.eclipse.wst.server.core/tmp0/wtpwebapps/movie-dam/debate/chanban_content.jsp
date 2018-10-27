<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="moviedam.debate.ChanbanDBBean"%>
<%@ page import="moviedam.debate.ChanbanDataBean"%>
<%@ page import="moviedam.debate.ChanbanlikeDataBean"%>
<%@ page import="moviedam.debate.ChanbanCommentDBBean"%>
<%@ page import="moviedam.debate.ChanbanCommentDataBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>

<%
   request.setCharacterEncoding("utf-8");
   String title = "토론방";
   String userid = (String) session.getAttribute("userid");
   int count = 0;
   int like_count = 0;
   String cb_like_type = "";
   String color = "";
   String align = "";
   int col1 = 0;
   int col2 = 0;

%>
<%
   int cb_id = Integer.parseInt(request.getParameter("cb_id"));
   String pageNum = request.getParameter("pageNum");

   if (pageNum == null) {
      pageNum = "1";
   }

   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try {
		ChanbanDBBean chanban_db = ChanbanDBBean.getInstance();
		ChanbanDataBean chanban = chanban_db.getChanban(cb_id);
%>

<%
	ArrayList<ChanbanCommentDataBean> commentList = null;
	ChanbanCommentDBBean cmt_db = ChanbanCommentDBBean.getInstance();
	cb_like_type = cmt_db.getLike_type(cb_id, userid);
	like_count = cmt_db.getlikeCount(cb_id);
      
	count = cmt_db.getChanbanCmtCount(cb_id);
	if (count > 0) {
		commentList = cmt_db.getChanbanCmts(cb_id);
	}

	try {
		if (session.getAttribute("userid") == null)
            userid = "not";
         else
            userid = (String) session.getAttribute("userid");
	} catch (Exception e) {
    }
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
					<h4>Pro and con debate</h4>
					<p></p>
				</div>
			</div>
		</div>

		<div class="row justify-content-center">
			<div class="col-10">
				<div class="single-listing-content">
					<div class="listing-title">
						<h4><%=chanban.getCb_title()%></h4>
						<span>작성자 <a href="/movie-dam/member/profile.jsp?mem_userid=<%=chanban.getCb_writer()%>"><%=chanban.getCb_writer()%></a>&nbsp;(<%=sdf.format(chanban.getReg_date())%>)</span> 
						<span><i class="fas fa-eye"></i> <%=chanban.getCb_hits()%></span>
					</div>

					<div class="overview-content mt-50" id="overview">
						<p><%=chanban.getCb_content().replace("\r\n", "<br>")%></p>
					</div>

<%
                     if (chanban.getCb_file() != null) {
%>
					<img src="/movie-dam/imageFolder/debate_chanban/<%=chanban.getCb_file()%>" width="250px">
<%
                     }
%>
					<div class="text-right">							
<%
               if (userid.equals("not")) {
%>
						<button type="button" class="btn btn-sm btn-outline-primary" disabled="disabled">수정</button>
						<button type="button" class="btn btn-sm btn-outline-danger" disabled="disabled">삭제</button>
<%
               } else {
%>
						<form id="likeForm" method="post"></form>
						<button type="button" class="btn btn-sm btn-outline-primary" onclick="location.href='chanban_updateForm.jsp?cb_id=<%=cb_id%>&pageNum=<%=pageNum%>&cb_writer=${sessionScope.userid}'">수정</button>
						<button type="button" class="btn btn-sm btn-outline-danger" onclick="location.href='chanban_deletePro.jsp?cb_id=<%=cb_id%>&pageNum=<%=pageNum%>&cb_writer=${sessionScope.userid}'">삭제</button>
<%
               }
%>
						<button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='debate_chanban.jsp?pageNum=<%=pageNum%>'">글목록</button>
				</div>
			</div>
		</div>
	</div>
		
		<br>	
			
		

<!-- -----댓글 시작----- -->
<%
            int cb_cmt_id = 0, cb_cmt_group = 1, cb_cmt_step = 0, cb_cmt_level = 0;
			String cb_cmt_type = "";
         
            if(request.getParameter("cb_cmt_id")!=null){
            	cb_cmt_id = Integer.parseInt(request.getParameter("cb_cmt_id"));
            	cb_cmt_group = Integer.parseInt(request.getParameter("cb_cmt_group"));
            	cb_cmt_step = Integer.parseInt(request.getParameter("cb_cmt_step"));
            	cb_cmt_level = Integer.parseInt(request.getParameter("cb_cmt_level"));
            	cb_cmt_type = request.getParameter("cb_cmt_type");
            }
%>
			
			<div class="container">
				<form action="chanban_contentPro.jsp">
					<input type="hidden" name="cb_cmt_level" value="<%=cb_cmt_level%>">
					<input type="hidden" name="cb_cmt_group" value="<%=cb_cmt_group%>">
					<input type="hidden" name="cb_cmt_step" value="<%=cb_cmt_step%>">
					<input type="hidden" name="cb_cmt_level" value="<%=cb_cmt_level%>">

					<input type="hidden" name="cb_cmt_ref" value="<%=chanban.getCb_id()%>"> 
					<input type="hidden" name="pageNum" value="<%=pageNum%>"> 
					<input type="hidden" name="cb_cmt_writer" value="<%=userid%>">
					
					<div class="card">
					  <div class="card-body">
					    <div class="form-group text-center">주장(<%=count%>)</div>
					    <hr>
    				
	    				<div class="form-group row">
	    					<div class="col-sm-10 offset-sm-2">
		    					<select class="form-control" id="inputCategory" name="cb_cmt_type">
									<option value="찬성" selected="selected">찬성</option>
									<option value="반대">반대</option>
								</select>
							</div>
							<label class="col-sm-12" ></label>
						    <label class="col-sm-2 col-form-label text-center"><%=userid%></label>
						    <div class="col-sm-10">
						      <textarea class="form-control summernote" name="cb_cmt_content"></textarea>
						    </div>
						 </div>
					 
						 <div class="form-group row text-right">
						    <div class="col-sm-12">
						      <button type="submit" class="btn btn-outline-secondary btn-sm">의견작성</button>
						      <button type="reset" class="btn btn-outline-danger btn-sm">다시입력</button>
						    </div>
						  </div>
						  
						</div>
					</div>
				</form>
			
 				
<%
			if (commentList != null && commentList.size() > 0) {
			      for (int i = 0; i < commentList.size(); i++) {
			         ChanbanCommentDataBean comment = commentList.get(i);
			         
			         if(comment.getCb_cmt_type().equals("찬성") && comment.getCb_cmt_step() == 0){
			        	 color = "blue";
			        	 align = "left";
			        	 col1= 2;
			        	 col2= 10;
			        	 
			         }else if (comment.getCb_cmt_type().equals("찬성") && comment.getCb_cmt_step() != 0){
			        	 color = "red";
			        	 align = "right";
			        	 col1= 3;
			        	 col2= 9;
			         }else if(comment.getCb_cmt_type().equals("반대") && comment.getCb_cmt_step() == 0){
			        	 color = "red";
			        	 align = "right";
			        	 col1= 10;
			        	 col2= 2;
			        	 
			         }else {
			        	 color = "red";
			        	 align = "right";
			        	 col1= 10;
			        	 col2= 2;
			         }
%>
				<form name="chanban_updateCmt" method="post" action="chanban_contentPro.jsp">				
<%				
               if(comment.getCb_cmt_type().equals("찬성") && comment.getCb_cmt_step() == 0){ 
%>						
						<hr>
						<div class="form-group row" style="border-left:5px solid blue;">	
							<label class="col-sm-2 col-form-label text-center">img</label>
							<div class="col-sm-10">
								<%=comment.getCb_cmt_writer()%>님의 <span style="color:blue"><%=comment.getCb_cmt_type() %></span> 의견  - <%=comment.getCb_cmt_date()%><br>
								<%=comment.getCb_cmt_content()%>
							</div>
						</div>
						
						
<%     	   
               }else if (comment.getCb_cmt_type().equals("찬성") && comment.getCb_cmt_step() != 0){
%>
						<hr>
						<div class="form-group row text-left">
						    <label class="col-sm-3 col-form-label text-center">┖> img </label>
						    <div class="col-sm-9">
						      <%=comment.getCb_cmt_writer()%>님의 의견 - <%=comment.getCb_cmt_date()%><br>
						      <%=comment.getCb_cmt_content()%>
							</div>
						</div>
						
<%                
                  }else if(comment.getCb_cmt_type().equals("반대") && comment.getCb_cmt_step() == 0){
%>
					<hr>
						<div class="form-group row text-right" style="border-right:5px solid red">	
							<div class="col-sm-10">
								<%=comment.getCb_cmt_writer()%>님의 <span style="color:red"><%=comment.getCb_cmt_type() %></span> 의견  - <%=comment.getCb_cmt_date()%><br>
								<%=comment.getCb_cmt_content()%>
							</div>
							<label class="col-sm-2 col-form-label text-center">img</label>
						</div>
<%				
                  } else {
%>
					<hr>
						<div class="form-group row text-right">
						    <div class="col-sm-9">
						      <%=comment.getCb_cmt_writer()%>님의 의견 - <%=comment.getCb_cmt_date()%><br>
						      <%=comment.getCb_cmt_content()%>
							</div>
						    <label class="col-sm-3 col-form-label text-center"> img <┚</label>
						</div>
<%                	  
                  }
               if (userid.equals(comment.getCb_cmt_writer()) ) {
%>
<%
               	if(comment.getCb_cmt_step() != 0){
%>
						<div class="col-sm-12 text-right">
						    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateOpen(<%=comment.getCb_cmt_id()%>, <%=cb_id%>, <%=pageNum%>);">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger" onclick="document.location.href='deleteCommentPro.jsp?cb_id=<%=cb_id%>&cb_cmt_id=<%=comment.getCb_cmt_id()%>&userid=<%=userid%>&pageNum=<%=pageNum%>&cb_cmt_ref=<%=cb_id%>&pageNum=<%=pageNum%>'">삭제</button>
						</div>
<%                   
               	}else{
%>
						<div class="col-sm-12 text-right">
						     <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateOpen(<%=comment.getCb_cmt_id()%>, <%=cb_id%>, <%=pageNum%>);">수정</button>
							 <button type="button" class="btn btn-sm btn-outline-danger" onclick="document.location.href='chanban_deleteCmtPro.jsp?cb_id=<%=cb_id%>&cb_cmt_id=<%=comment.getCb_cmt_id()%>&userid=<%=userid%>&pageNum=<%=pageNum%>&cb_cmt_ref=<%=cb_id%>'">삭제</button>
							 <a class="btn btn-sm btn-outline-secondary" onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)"> 답글쓰기 </a><div style="display: none">

								<input type="hidden" name="cb_cmt_id" value="<%=comment.getCb_cmt_id()%>"> 
								<input type="hidden" name="cb_cmt_group" value="<%=comment.getCb_cmt_group()%>"> 
								<input type="hidden" name="cb_cmt_step" value="<%=comment.getCb_cmt_step()%>"> 
								<input type="hidden" name="cb_cmt_level" value="<%=comment.getCb_cmt_level()%>">
								<input type="hidden" name="cb_cmt_type" value="<%=comment.getCb_cmt_type()%>"> 
								
								<input type="hidden" name="cb_cmt_ref" value="<%=cb_id%>"> 
								<input type="hidden" name="pageNum" value="<%=pageNum%>"> 
								<input type="hidden" name="cb_cmt_writer" value="<%=userid%>">
								<input type="hidden" name="userid" value="<%=userid%>">
	
								<div class="card">
								  <div class="card-body">
								    <div class="form-group text-center">reply</div>
								    <hr>
			    				
				    				<div class="form-group row">
										<label class="col-sm-12" ></label>
									    <label class="col-sm-2 col-form-label text-center"><%=userid%></label>
									    <div class="col-sm-10 text-left">
									      <textarea class="form-control summernote" name="cb_cmt_content"></textarea>
									    </div>
									 </div>
								 
									 <div class="form-group row text-right">
									    <div class="col-sm-12">
									      <button type="submit" class="btn btn-outline-secondary btn-sm">의견작성</button>
									      <button type="reset" class="btn btn-outline-danger btn-sm">다시입력</button>
									    </div>
									 </div>
									  
									</div>
								</div>
									
							</div>
						</div>
<%                   
              	}
%>
<%
              } else {
%>
						<div class="col-sm-12">
					      	<button type="button" class="btn btn-sm btn-outline-secondary" disabled="disabled" style="display:none;">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger" disabled="disabled" style="display:none;">삭제</button>
						</div>
<%
             }
	    }
	}
%>
				</form>
			</div>	
<%
                   

	} catch (Exception e) {

		}
%>
	</div>
</section>

<jsp:include page="/module/footer.jsp" flush="false" />

<script>
$(document).ready(function() {
	  $('.summernote').summernote({
		  height:150
	  });

});
 </script>

<script>
function updateOpen(cb_cmt_id, cb_id, pageNum) {
   url = 'chanban_updateCmtForm.jsp?cb_cmt_id=' + cb_cmt_id + '&cb_id=' + cb_id + '&pageNum=' + pageNum;
   window.open(url, '댓글 수정', 'height=200, width=400, scrollbars=no, resizable=no');
}
</script>

<script>
$(document).ready(function() {
   var rs = [];
   var cb_like_type = '<%=cb_like_type%>';
   var like_count = <%=like_count%>;
   var cb_id = '<%=cb_id%>';
   var mem_id = '<%=userid%>';
   if(cb_like_type=='N') {
      rs.push('<button class="btn btn-link" type="submit" id="like" ><i id="likeIcon" class="far fa-heart fa-lg" style="color:black;"></i></button><span id="likeCount">'+like_count+'개</span>');
      rs.push('<input type="hidden" name="currentLike" value="N">');
      rs.push('<input type="hidden" name="cb_id" value="'+cb_id+'">');
      rs.push('<input type="hidden" name="mem_id" value="'+mem_id+'">');
      $('#likeForm').append(rs.join(''));
   } else if(cb_like_type=='Y') {
      rs.push('<button class="btn btn-link" type="submit" id="like"><i id="likeIcon" class="fas fa-heart fa-lg" style="color:red;"></i></button><span id="likeCount">'+like_count+'개</span>');
      rs.push('<input type="hidden" name="currentLike" value="Y">');
      rs.push('<input type="hidden" name="cb_id" value="'+cb_id+'">');
      rs.push('<input type="hidden" name="mem_id" value="'+mem_id+'">');
      $('#likeForm').append(rs.join(''));
   }
   
   var currentLike = '';

   $('#likeForm').submit(function(event) {
      event.preventDefault();
      var $form = $(this),
      cb_id = $form.find('input[name="cb_id"]').val(),
      mem_id = $form.find('input[name="mem_id"]').val(),
      cb_like_type = $form.find('input[name="currentLike"]').val();

      var posting = $.post('chanban_like_pro.jsp', { 
         cb_id: cb_id,
         mem_id: mem_id,
         currentLike: cb_like_type
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

</body>
</html>