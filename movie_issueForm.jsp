<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="moviedam.board.BoardDBBean"%>
<%@ page import="moviedam.board.BoardDataBean"%>
    
<%
   request.setCharacterEncoding("utf-8");
   String title = "이슈 입력"; 
   /*   int board_id = Integer.parseInt(request.getParameter("board_id"));
   String userid = request.getParameter("article_writer");
   BoardDBBean board_db = BoardDBBean.getInstance();
   BoardDataBean board = board_db.getBoard(board_id); */
%>

<jsp:include page="/module/header.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false" />


<div class="container">
   <h3>
      <%=title%>
      <small class="text-muted">movie Issue input</small>
   </h3>
   <div class="col">

<%--<input type="hidden" name="article_id" value="<%=article_id%>"> --%>
         
         <div class="form-group">
            <label for="inputTitle" class="col-sm-3 col-form-label">제목</label>
            <div class="col-sm-20">
               <input type="text" class="form-control" id="inputTitle" name="article_title" maxlength="50">
            </div>
         </div>
         
         <div class="form-group row">
            <div class="form-group col">
            <label for="Textarea">원본글 주소</label>
            <textarea class="form-control" id="inputContent" name="article_content" rows="1"></textarea>
         </div>
          </div>
  
         <div class="form-group">
            <label for="exampleInputFile">이슈 포스터</label> 
            <input type="file" class="form-control-file" id="inputFile" name="article_file" aria-describedby="fileHelp" accept="image/*"> 
            <small id="fileHelp" class="form-text text-muted">이미지 파일만 첨부 가능합니다.</small>
         </div>

         <button type="submit" class="btn btn-md btn-primary">작성하기</button>
         <button type="button" class="btn btn-md btn-outline-secondary" onclick="window.location='./movie_issue">목록으로</button>
</div>

<jsp:include page="/module/footer.jsp" flush="false" />