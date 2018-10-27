<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "moviedam.debate.ChanbanDBBean" %>
<%@ page import = "moviedam.member.MemberDBBean" %>
<%@ page import = "moviedam.member.MemberDataBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
	MultipartRequest multi = null;
	//게시판 구분
	String uploadPath = "";
	String fileName = ""; //서버에 저장된 파일 이름
	
	uploadPath = getServletContext().getRealPath("/imageFolder/debate_chanban"); //파일을 저장할 서버의 경로
	
	int maxSize = 5*1024*1024; //5MB
	
	try {
		//파일업로드 (request, 파일 저장경로, 용량, 인코딩타입, 중복 파일명에 대한 기본 정책)
		multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
		//파일 정보 가져와 출력
		Enumeration <?> files = multi.getFileNames();
		while(files.hasMoreElements()) {
			String name = (String)files.nextElement();
			fileName = multi.getFilesystemName(name);
		}
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>

<jsp:useBean id="chanban" scope="page" class="moviedam.debate.ChanbanDataBean">
   <jsp:setProperty name="chanban" property="*"/>
</jsp:useBean>
<%

	String pageNum = request.getParameter("pageNum");
	int currentPage = Integer.parseInt(pageNum);
	String userid = (String)session.getAttribute("userid");
	
	//가져올 데이터
	String cb_writer = multi.getParameter("cb_writer");
	String cb_title = multi.getParameter("cb_title");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	String cb_content = multi.getParameter("cb_content");
	String cb_type = multi.getParameter("cb_type");
	
	chanban.setCb_title(cb_title);
	chanban.setCb_content(cb_content);
	chanban.setCb_file(fileName);
	chanban.setCb_type(cb_type);
   
   ChanbanDBBean dbPro = ChanbanDBBean.getInstance();
   int check = dbPro.updateChanban(chanban,userid); 
   if(check==1){
%>
	<meta http-equiv="Refresh" content="0;url=chanban_content.jsp?cb_id=<%=chanban.getCb_id()%>&pageNum=<%=currentPage%>" >
<% 	} else { %>
<script>   
	alert("작성자만 수정할 수 있습니다.");
     	history.go(-2);
</script>
<% 		
	} 
%>  
	