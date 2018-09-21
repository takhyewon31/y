<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="moviedam.board.BoardDBBean"%>
<%@ page import="moviedam.board.BoardDataBean"%>
    
<%
   request.setCharacterEncoding("utf-8");
   String title = "시사회 입력";
   int board_id = Integer.parseInt(request.getParameter("board_id"));
   String userid = request.getParameter("article_writer");
   BoardDBBean board_db = BoardDBBean.getInstance();
   BoardDataBean board = board_db.getBoard(board_id);
   
%>

<jsp:include page="/module/header.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />


<div class="container">
   <h3>
      <%=title%>
      <small class="text-muted">movie Preview input</small>
   </h3>
   <div class="row">
      <form method="post" name="writeform" action="?board_id=<%=board.getBoard_id()%>" onsubmit="return writeSave" enctype="multipart/form-data">
<%--       <input type="hidden" name="article_id" value="<%=article_id%>"> --%>
         
         <c:if test="<%=board_id == 4 %>">
            <div class="form-group col">
                  <label for="inputCategory">영화관</label> 
                  <select class="form-control" id="영화관 카테고리" name="영화관 카테고리">
                  <option value="전체" selected="selected">전체</option>
                  <option value="CGV">CGV</option>
                  <option value="롯데시네마">롯데시네마</option>
                  <option value="메가박스">메가박스</option>
               </select>
            </div>
         </c:if>
      
         <div class="form-group col">
            <label for="inputTitle" class="col-sm-3 col-form-label">제목</label>
            <div class="col-sm-10">
               <input type="text" class="form-control" id="inputTitle" name="article_title" maxlength="50">
            </div>
         </div>
         
         <div class="form-group col">
            <label for="Textarea">내용</label>
            <textarea class="form-control" id="inputContent" name="article_content" rows="3"></textarea>
         </div>
         
         <div class="form-group col">
            <label for="exampleInputFile">첨부파일</label> 
            <input type="file" class="form-control-file" id="inputFile" name="article_file" aria-describedby="fileHelp" accept="image/*"> 
            <small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
         </div>

         <button type="submit" class="btn btn-primary">작성하기</button>
         <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.location='./movie_preview">목록으로</button>
</div>

<jsp:include page="/module/footer.jsp" flush="false" />