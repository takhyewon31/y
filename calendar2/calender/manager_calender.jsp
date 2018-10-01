<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	String title = "무대인사";
%>
<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

<link rel='stylesheet' type='text/css' href='../fullcalendar.css' />
<script type='text/javascript' src='../jquery/jquery.js'></script>
<script type='text/javascript' src='../jquery/jquery-ui-custom.js'></script>
<script type='text/javascript' src='../fullcalendar.min.js'></script>
<script type='text/javascript' src='../fullcalendar-movie.js'></script>
<script type='text/javascript'>


</script>
<style type='text/css'>

	#calendar {
		width: 900px;
		margin: 0 auto;
		}

</style>
<body>
<div class="container">
	<h3>
		<%= title %>
		<small class="text-muted">Movie Stage</small>
	</h3>

	<br>
	
	<button type=Button id="myBtn">새 일정</button>
    <!-- The Modal -->
    <div id="myModal" class="modal">
      <!-- Modal content -->
      <div class="modal-content">
      <div class="modal-header">
        <span class="close">&times;</span>  
      </div>
        <div class="modal-body">
      	 	<label for="inputTitle" class="col-sm-5 col-form-label">영화관 선택</label>
			<select class= "form-control" name="cine" id="cine">
		 		<option value="">선택</option>
		 		<option value="CGV">CGV</option>
		 		<option value="Lotte">Lotte</option>
		 		<option value="MegaBox">MegaBox</option>
			</select>   
          		<label for="inputTitle" class="col-sm-5 col-form-label">제목</label>
            	<input type="text" class="form-control" id="inputTitle" name="article_title" maxlength="50">
            	<label for="inputTitle" class="col-sm-5 col-form-label">참석자</label>
            	<input type="text" class="form-control" id="attendee" name="article_title" maxlength="50">
          </div>                                                                       
      	  <div class="modal-footer">
		<input type="button" name="btn" id="btn" value="Click">
	  </div>
     </div> 
 	</div>
	<div class="row">
		<div id='calendar'></div>
	</div>

</div>
</body>
</html>
