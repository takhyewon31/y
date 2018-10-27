<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="moviedam.member.MemberDBBean"%>
<%@ page import="moviedam.member.MemberDataBean"%>
<%@ page import="moviedam.board.RestaurantDBBean"%>
<%@ page import="moviedam.board.RestaurantDataBean"%>
<%@ page import="moviedam.board.ArticlelikeDataBean"%>
<%@ page import="moviedam.board.CommentRestDBBean"%>
<%@ page import="moviedam.board.CommentRestDataBean"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>


<%
   request.setCharacterEncoding("utf-8");
   String title = "게시글 상세보기";
   String userid = (String) session.getAttribute("userid");
   int board_id = Integer.parseInt(request.getParameter("board_id"));
   int count = 0;
   int like_count = 0;
   float lat = 0;
   float lon = 0;
   String like_type = "";
   String search_loc = request.getParameter("search_loc");
%>

<%
   int article_id = Integer.parseInt(request.getParameter("article_id"));
   String pageNum = request.getParameter("pageNum");

   if (pageNum == null) {
      pageNum = "1";
   }

   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try {

		RestaurantDBBean restaurant_db = RestaurantDBBean.getInstance();
		RestaurantDataBean article = restaurant_db.getArticle(article_id);
		like_type = restaurant_db.getLike_type(board_id, article_id, userid);
		like_count = restaurant_db.getlikeCount(board_id, article_id);
		
		lat = article.getStart_lat();
		lon = article.getStart_lon();
			
		MemberDBBean mem_db = MemberDBBean.getInstance(); 
		MemberDataBean profile =  mem_db.getProfile(article.getArticle_writer());
%>

<%
   ArrayList<CommentRestDataBean> commentList = null;
      CommentRestDBBean cmt_db = CommentRestDBBean.getInstance();
      
      count = cmt_db.getCommentCount(article_id);
      if (count > 0) {
         commentList = cmt_db.getComments(article_id);
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
<div class="breadcumb-area bg-img bg-overlay"
   style="background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)"></div>
<!-- ***** Breadcumb Area End ***** -->

<section class="dorne-single-listing-area section-padding-100">
   <div class="container">
      <div class="row">
         <div class="col-12">
            <div class="section-heading dark text-center">
               <span></span>
               <h4>Cinema restaurant</h4>
               <p></p>
            </div>
         </div>
      </div>

      <div class="row justify-content-center">
         <div class="col-12 col-lg-8">
            <div class="single-listing-content">
               <div class="listing-title">
                  <h4><%=article.getArticle_title()%></h4>
                  <span>작성자 <a href="/movie-dam/member/profile.jsp?mem_userid=<%=article.getArticle_writer()%>"><%=profile.getMem_nickname()%></a>&nbsp;(<%=sdf.format(article.getReg_date())%>)
                  </span> <span><i class="fas fa-eye"></i> <%=article.getArticle_hits()%></span>
               </div>

               <div class="overview-content mt-50" id="overview">
                  <p><%=article.getArticle_content().replace("\r\n", "<br>")%></p>
               </div>
			<%
			  if (article.getArticle_file() != null) {
			%>
				<img src="/movie-dam/imageFolder/cinema_restaurant/<%=article.getArticle_file()%>" width="250px">
			<%
			  }
			%>
				<div style="height: 60px; position: relative; overflow: hidden;"></div>
				<span>지도를 클릭하여 해당하는 음식점의 위치를 확인하세요.</span>
				<div class="map_wrap">
					<div id="map" style="width: 500px; height: 400px; position: relative; overflow: auto; margin-bottom: 10px;"></div>
					<div class="hAddr">
						<span class="title">지도중심기준 주소정보</span> <span id="centerAddr"></span>
					</div>
				</div>
				<div style="height: 70px; position: relative; overflow: hidden;"></div>
				<div>
					<form id="likeForm" method="post"></form>
               	</div>
            </div>
            <%
               if (userid.equals("not")) {
            %>
            <button type="button" class="btn btn-sm btn-outline-secondary" disabled="disabled">수정</button>
            <button type="button" class="btn btn-sm btn-outline-secondary" disabled="disabled">삭제</button>
            <%
               } else {
            %>
            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='updateForm.jsp?board_id=<%=board_id%>&article_id=<%=article_id%>&pageNum=<%=pageNum%>&article_writer=${sessionScope.userid}'">수정</button>
            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='deletePro.jsp?board_id=<%=board_id%>&article_id=<%=article_id%>&pageNum=<%=pageNum%>&article_writer=${sessionScope.userid}'">삭제</button>
            <%
               }
            %>
            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='cinema_restaurant.jsp?pageNum=<%=pageNum%>'">글목록</button>
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

         <div class="row">
   
            <form action="content_rest_pro.jsp">
               <input type="hidden" name="cmt_id" value="<%=cmt_id%>"> 
               <input type="hidden" name="cmt_parent" value="<%=cmt_parent%>"> 
               <input type="hidden" name="cmt_restep" value="<%=cmt_restep%>">
               <input type="hidden" name="cmt_relevel" value="<%=cmt_relevel%>"> 
               
               <input type="hidden" name="cmt_ref" value="<%=article.getArticle_id()%>"> 
               <input type="hidden" name="pageNum" value="<%=pageNum%>"> 
               <input type="hidden" name="cmt_writer" value="<%=userid%>"> 
               <input type="hidden" name="board_id" value="<%=board_id%>"> 

               <table class="table">
                  <tr>
                     <td colspan="3" align="center"></td>
                  </tr>

                  <tr>
                     <td colspan="3" align="center">comment(<%=count%>)</td>
                  </tr>

                  <tr>
                     <td height="100" align="center"><%=userid%></td>
                     <td colspan="2" align="right" style="font-size: 14px;">
                        <textarea class="form-control" rows="3" cols="160" name="cmt_content"></textarea>
                        <input class="btn btn-outline-secondary btn-sm" type="submit" name="register" value="댓글 작성"> 
                        <input class="btn btn-outline-secondary btn-sm" type="reset"value="다시쓰기">
                     </td>
                  </tr>
               </table>
            </form>
            <%
               if (commentList != null && commentList.size() > 0) {
                     for (int i = 0; i < commentList.size(); i++) {
                        CommentRestDataBean comment = commentList.get(i);
                        
                        
            %>
            <form name="updatecomment" method="post" action="content_rest_pro.jsp">

               <table class="table">
<%
               if(comment.getCmt_restep() != 0){
%>               
                  <tr>
                     <td rowspan=2 align="center">┖></td>
                     <td rowspan=2 align="center">img</td>
                     <td colspan=2 align="left" style="font-size: 14px;"><b><%=comment.getCmt_writer()%></b>(<%=comment.getCmt_date()%>)</td>
                  </tr>
<%                   
               }else{
%>                  
                  <tr>
                     <td rowspan=2 align="center">img</td>
                     <td colspan=2 align="left" style="font-size: 14px;"><b><%=comment.getCmt_writer()%></b>(<%=comment.getCmt_date()%>)</td>
                  </tr>
<%                   
                  }
%>                  
                  <tr height="75">
                     <td colspan=2 style="font-size: 14px;"><%=comment.getCmt_content()%></td>
                  </tr>
                  
<%
               if (userid.equals(comment.getCmt_writer()) ) {
%>

<%
               if(comment.getCmt_restep() != 0){
%>                  
                  <tr>
                     <td colspan=3 align="right">
                        <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateOpen(<%=comment.getCmt_id()%>, <%=article_id%>, <%=pageNum%>, <%=board_id%>);">수정</button>
                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="document.location.href='deleteCommentPro.jsp?article_id=<%=article_id%>&cmt_id=<%=comment.getCmt_id()%>&userid=<%=userid%>&pageNum=<%=pageNum%>&cmt_ref=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>'">삭제</button>
                     </td>
                  </tr>
<%                   
               }else{
%>
                  <tr>
                     <td colspan=3 align="right">
                        <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateOpen(<%=comment.getCmt_id()%>, <%=article_id%>, <%=pageNum%>, <%=board_id%>);">수정</button>
                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="document.location.href='deleteCommentPro.jsp?article_id=<%=article_id%>&cmt_id=<%=comment.getCmt_id()%>&userid=<%=userid%>&pageNum=<%=pageNum%>&cmt_ref=<%=article_id%>&pageNum=<%=pageNum%>&board_id=<%=board_id%>'">삭제</button>
                        <a class="btn btn-sm btn-outline-secondary" onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)"> 답글쓰기 </a><div style="display:none" >
   
                        <input type="hidden" name="cmt_id" value="<%=comment.getCmt_id()%>"> 
                        <input type="hidden" name="cmt_parent" value="<%=comment.getCmt_parent()%>"> 
                        <input type="hidden" name="cmt_restep" value="<%=comment.getCmt_restep()%>">
                        <input type="hidden" name="cmt_relevel" value="<%=comment.getCmt_relevel()%>"> 
                        
                        <input type="hidden" name="cmt_ref" value="<%=article_id%>">  
                        <input type="hidden" name="pageNum" value="<%=pageNum%>"> 
                        <input type="hidden" name="cmt_writer" value="<%=userid%>"> 
                        <input type="hidden" name="userid" value="<%=userid%>">
                        <input type="hidden" name="board_id" value="<%=board_id%>"> 
                        
                        <table class="table">
                           <tr>
                              <td colspan="3" align="center">reply</td>
                           </tr>
                        
                           <tr>
                              <td height="100" align="center"><%=userid%></td>
                               <td colspan="2" align="right" style="font-size: 14px;">
                                    <textarea class="form-control" rows="3" cols="160" name="cmt_content"></textarea>
                                    <input class="btn btn-outline-secondary btn-sm" type="submit" value="댓글 작성">
                                    <input class="btn btn-outline-secondary btn-sm" type="reset"value="다시쓰기">
                              </td>
                          </tr>
                        </table>
                        </div>
                     </td>
                  </tr>   
<%                   
              }
%>
<%
              } else {
%>
                  <tr>
                     <td colspan=3 align="right">
                        <button type="button" class="btn btn-sm btn-outline-secondary" disabled="disabled">수정</button>
                        <button type="button" class="btn btn-sm btn-outline-danger" disabled="disabled">삭제</button>
                     </td>
                  </tr>
<%
                }
%>
         </table>
            
            </form>
            
            
            <%
                     }
                        }

                     } catch (Exception e) {

                     }
                  %>
                        

         </div>
      </div>
   </div>
</section>

<jsp:include page="/module/footer.jsp" flush="false" />


<script>
function updateOpen(cmt_id, article_id, pageNum, board_id) {
   url = 'updateCommentForm.jsp?cmt_id=' + cmt_id + '&article_id=' + article_id + '&pageNum=' + pageNum + '&board_id=' + board_id;
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
      rs.push('<button class="btn btn-link" type="submit" id="like"><i id="likeIcon" class="fas fa-heart fa-lg" style="color:red;"></i></button><span id="likeCount">'+like_count+'개</span>');
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
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f393c76a0b2985e070ae327f42034c70&libraries=services"></script>
<script>
$(document).ready(function() {
	var ps = new daum.maps.services.Places();
	//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new daum.maps.InfoWindow({
		zIndex : 1
	});
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center : new daum.maps.LatLng(<%=lat%>, <%=lon%>), //지도의 중심좌표
		level : 3
	//지도의 레벨(확대, 축소 정도)
	};

	//지도를 생성합니다
	var map = new daum.maps.Map(container, options);

	var marker = new daum.maps.Marker({
		//지도 중심 좌표에 마커를 생성합니다.
		position: map.getCenter()
	});
	marker.setMap(map);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();

	var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
	    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	    
	 // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	    daum.maps.event.addListener(map, 'click', function(mouseEvent) {
	        searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	            if (status === daum.maps.services.Status.OK) {
	                var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
	                detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
	                 var content = '<div class="bAddr">' + '<%=search_loc%>' + detailAddr + '</div>';
	                // 마커를 클릭한 위치에 표시합니다 
	                marker.setPosition(mouseEvent.latLng);
	                marker.setMap(map);
	                
	                //마커를 보이지 않게 합니다.
	                marker.setVisible(false);

	                // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	                infowindow.setContent(content);
	                infowindow.open(map, marker);
	            }   
	        });
	    });

	    function searchAddrFromCoords(coords, callback) {
	        // 좌표로  주소 정보를 요청합니다
	        geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	    }

	    function searchDetailAddrFromCoords(coords, callback) {
	        // 좌표로 상세 주소 정보를 요청합니다
	        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	    }
	    
	    
	 // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	    daum.maps.event.addListener(map, 'idle', function() {
	    	
	        searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	    });
	 
	 // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	    function displayCenterInfo(result, status) {
	        if (status === daum.maps.services.Status.OK) {
	            var infoDiv = document.getElementById('centerAddr');

	            for(var i = 0; i < result.length; i++) {
	                // 행정동의 region_type 값은 'H' 이므로
	                if (result[i].region_type === 'H') {
	                    infoDiv.innerHTML = result[i].address_name;
	                    break;
	                }
	            }
	        }    
	    }
});

</script> 
</body>
</html>