/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.53
 * Generated at: 2018-10-19 12:50:01 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.debate;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import moviedam.debate.ChanbanDBBean;
import moviedam.debate.ChanbanDataBean;
import moviedam.debate.ChanbanlikeDataBean;
import moviedam.debate.ChanbanCommentDBBean;
import moviedam.debate.ChanbanCommentDataBean;
import java.text.SimpleDateFormat;
import java.util.List;
import java.sql.*;

public final class chanban_005fcontent_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("jar:file:/C:/_server/movie-dam/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/movie-dam/WEB-INF/lib/standard.jar!/META-INF/c.tld", Long.valueOf(1090214156000L));
    _jspx_dependants.put("/WEB-INF/lib/standard.jar", Long.valueOf(1539818326000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("moviedam.debate.ChanbanDBBean");
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("moviedam.debate.ChanbanlikeDataBean");
    _jspx_imports_classes.add("moviedam.debate.ChanbanCommentDBBean");
    _jspx_imports_classes.add("java.text.SimpleDateFormat");
    _jspx_imports_classes.add("moviedam.debate.ChanbanCommentDataBean");
    _jspx_imports_classes.add("java.util.ArrayList");
    _jspx_imports_classes.add("moviedam.debate.ChanbanDataBean");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

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


      out.write('\n');

   int cb_id = Integer.parseInt(request.getParameter("cb_id"));
   String pageNum = request.getParameter("pageNum");

   if (pageNum == null) {
      pageNum = "1";
   }

   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try {
		ChanbanDBBean chanban_db = ChanbanDBBean.getInstance();
		ChanbanDataBean chanban = chanban_db.getChanban(cb_id);

      out.write('\n');
      out.write('\n');

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

      out.write('\n');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/module/header.jsp" + "?" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("title", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(title), request.getCharacterEncoding()), out, false);
      out.write('\n');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/module/nav.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("<!-- ***** Breadcumb Area Start ***** -->\n");
      out.write("<div class=\"breadcumb-area bg-img bg-overlay\" style=\"background-image: url(/movie-dam/assets/img/bg-img/hero-1.jpg)\"></div>\n");
      out.write("<!-- ***** Breadcumb Area End ***** -->\n");
      out.write("\n");
      out.write("<section class=\"dorne-single-listing-area section-padding-100\">\n");
      out.write("\t<div class=\"container\">\n");
      out.write("\t\t<div class=\"row\">\n");
      out.write("\t\t\t<div class=\"col-12\">\n");
      out.write("\t\t\t\t<div class=\"section-heading dark text-center\">\n");
      out.write("\t\t\t\t\t<span></span>\n");
      out.write("\t\t\t\t\t<h4>Pro and con debate</h4>\n");
      out.write("\t\t\t\t\t<p></p>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\n");
      out.write("\t\t<div class=\"row justify-content-center\">\n");
      out.write("\t\t\t<div class=\"col-10\">\n");
      out.write("\t\t\t\t<div class=\"single-listing-content\">\n");
      out.write("\t\t\t\t\t<div class=\"listing-title\">\n");
      out.write("\t\t\t\t\t\t<h4>");
      out.print(chanban.getCb_title());
      out.write("</h4>\n");
      out.write("\t\t\t\t\t\t<span>작성자 <a href=\"/movie-dam/member/profile.jsp?mem_userid=");
      out.print(chanban.getCb_writer());
      out.write('"');
      out.write('>');
      out.print(chanban.getCb_writer());
      out.write("</a>&nbsp;(");
      out.print(sdf.format(chanban.getReg_date()));
      out.write(")</span> \n");
      out.write("\t\t\t\t\t\t<span><i class=\"fas fa-eye\"></i> ");
      out.print(chanban.getCb_hits());
      out.write("</span>\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<div class=\"overview-content mt-50\" id=\"overview\">\n");
      out.write("\t\t\t\t\t\t<p>");
      out.print(chanban.getCb_content().replace("\r\n", "<br>"));
      out.write("</p>\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\n");

                     if (chanban.getCb_file() != null) {

      out.write("\n");
      out.write("\t\t\t\t\t<img src=\"/movie-dam/imageFolder/debate_chanban/");
      out.print(chanban.getCb_file());
      out.write("\" width=\"250px\">\n");

                     }

      out.write("\n");
      out.write("\t\t\t\t\t<div class=\"text-right\">\t\t\t\t\t\t\t\n");

               if (userid.equals("not")) {

      out.write("\n");
      out.write("\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-primary\" disabled=\"disabled\">수정</button>\n");
      out.write("\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger\" disabled=\"disabled\">삭제</button>\n");

               } else {

      out.write("\n");
      out.write("\t\t\t\t\t\t<form id=\"likeForm\" method=\"post\"></form>\n");
      out.write("\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-primary\" onclick=\"location.href='chanban_updateForm.jsp?cb_id=");
      out.print(cb_id);
      out.write("&pageNum=");
      out.print(pageNum);
      out.write("&cb_writer=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionScope.userid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("'\">수정</button>\n");
      out.write("\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger\" onclick=\"location.href='chanban_deletePro.jsp?cb_id=");
      out.print(cb_id);
      out.write("&pageNum=");
      out.print(pageNum);
      out.write("&cb_writer=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionScope.userid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("'\">삭제</button>\n");

               }

      out.write("\n");
      out.write("\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-secondary\" onclick=\"location.href='debate_chanban.jsp?pageNum=");
      out.print(pageNum);
      out.write("'\">글목록</button>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\t</div>\n");
      out.write("\t\t\n");
      out.write("\t\t<br>\t\n");
      out.write("\t\t\t\n");
      out.write("\t\t\n");
      out.write("\n");
      out.write("<!-- -----댓글 시작----- -->\n");

            int cb_cmt_id = 0, cb_cmt_group = 1, cb_cmt_step = 0, cb_cmt_level = 0;
			String cb_cmt_type = "";
         
            if(request.getParameter("cb_cmt_id")!=null){
            	cb_cmt_id = Integer.parseInt(request.getParameter("cb_cmt_id"));
            	cb_cmt_group = Integer.parseInt(request.getParameter("cb_cmt_group"));
            	cb_cmt_step = Integer.parseInt(request.getParameter("cb_cmt_step"));
            	cb_cmt_level = Integer.parseInt(request.getParameter("cb_cmt_level"));
            	cb_cmt_type = request.getParameter("cb_cmt_type");
            }

      out.write("\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t<div class=\"container\">\n");
      out.write("\t\t\t\t<form action=\"chanban_contentPro.jsp\">\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_level\" value=\"");
      out.print(cb_cmt_level);
      out.write("\">\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_group\" value=\"");
      out.print(cb_cmt_group);
      out.write("\">\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_step\" value=\"");
      out.print(cb_cmt_step);
      out.write("\">\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_level\" value=\"");
      out.print(cb_cmt_level);
      out.write("\">\n");
      out.write("\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_ref\" value=\"");
      out.print(chanban.getCb_id());
      out.write("\"> \n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"pageNum\" value=\"");
      out.print(pageNum);
      out.write("\"> \n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_writer\" value=\"");
      out.print(userid);
      out.write("\">\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t\t<div class=\"card\">\n");
      out.write("\t\t\t\t\t  <div class=\"card-body\">\n");
      out.write("\t\t\t\t\t    <div class=\"form-group text-center\">주장(");
      out.print(count);
      out.write(")</div>\n");
      out.write("\t\t\t\t\t    <hr>\n");
      out.write("    \t\t\t\t\n");
      out.write("\t    \t\t\t\t<div class=\"form-group row\">\n");
      out.write("\t    \t\t\t\t\t<div class=\"col-sm-10 offset-sm-2\">\n");
      out.write("\t\t    \t\t\t\t\t<select class=\"form-control\" id=\"inputCategory\" name=\"cb_cmt_type\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<option value=\"찬성\" selected=\"selected\">찬성</option>\n");
      out.write("\t\t\t\t\t\t\t\t\t<option value=\"반대\">반대</option>\n");
      out.write("\t\t\t\t\t\t\t\t</select>\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t<label class=\"col-sm-12\" ></label>\n");
      out.write("\t\t\t\t\t\t    <label class=\"col-sm-2 col-form-label text-center\">");
      out.print(userid);
      out.write("</label>\n");
      out.write("\t\t\t\t\t\t    <div class=\"col-sm-10\">\n");
      out.write("\t\t\t\t\t\t      <textarea class=\"form-control summernote\" name=\"cb_cmt_content\"></textarea>\n");
      out.write("\t\t\t\t\t\t    </div>\n");
      out.write("\t\t\t\t\t\t </div>\n");
      out.write("\t\t\t\t\t \n");
      out.write("\t\t\t\t\t\t <div class=\"form-group row text-right\">\n");
      out.write("\t\t\t\t\t\t    <div class=\"col-sm-12\">\n");
      out.write("\t\t\t\t\t\t      <button type=\"submit\" class=\"btn btn-outline-secondary btn-sm\">의견작성</button>\n");
      out.write("\t\t\t\t\t\t      <button type=\"reset\" class=\"btn btn-outline-danger btn-sm\">다시입력</button>\n");
      out.write("\t\t\t\t\t\t    </div>\n");
      out.write("\t\t\t\t\t\t  </div>\n");
      out.write("\t\t\t\t\t\t  \n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t</form>\n");
      out.write("\t\t\t\n");
      out.write(" \t\t\t\t\n");

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

      out.write("\n");
      out.write("\t\t\t\t<form name=\"chanban_updateCmt\" method=\"post\" action=\"chanban_contentPro.jsp\">\t\t\t\t\n");
				
               if(comment.getCb_cmt_type().equals("찬성") && comment.getCb_cmt_step() == 0){ 

      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<hr>\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group row\" style=\"border-left:5px solid blue;\">\t\n");
      out.write("\t\t\t\t\t\t\t<label class=\"col-sm-2 col-form-label text-center\">img</label>\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-sm-10\">\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(comment.getCb_cmt_writer());
      out.write("님의 <span style=\"color:blue\">");
      out.print(comment.getCb_cmt_type() );
      out.write("</span> 의견  - ");
      out.print(comment.getCb_cmt_date());
      out.write("<br>\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(comment.getCb_cmt_content());
      out.write("\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\n");
     	   
               }else if (comment.getCb_cmt_type().equals("찬성") && comment.getCb_cmt_step() != 0){

      out.write("\n");
      out.write("\t\t\t\t\t\t<hr>\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group row text-left\">\n");
      out.write("\t\t\t\t\t\t    <label class=\"col-sm-3 col-form-label text-center\">┖> img </label>\n");
      out.write("\t\t\t\t\t\t    <div class=\"col-sm-9\">\n");
      out.write("\t\t\t\t\t\t      ");
      out.print(comment.getCb_cmt_writer());
      out.write("님의 의견 - ");
      out.print(comment.getCb_cmt_date());
      out.write("<br>\n");
      out.write("\t\t\t\t\t\t      ");
      out.print(comment.getCb_cmt_content());
      out.write("\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\n");
                
                  }else if(comment.getCb_cmt_type().equals("반대") && comment.getCb_cmt_step() == 0){

      out.write("\n");
      out.write("\t\t\t\t\t<hr>\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group row text-right\" style=\"border-right:5px solid red\">\t\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-sm-10\">\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(comment.getCb_cmt_writer());
      out.write("님의 <span style=\"color:red\">");
      out.print(comment.getCb_cmt_type() );
      out.write("</span> 의견  - ");
      out.print(comment.getCb_cmt_date());
      out.write("<br>\n");
      out.write("\t\t\t\t\t\t\t\t");
      out.print(comment.getCb_cmt_content());
      out.write("\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t<label class=\"col-sm-2 col-form-label text-center\">img</label>\n");
      out.write("\t\t\t\t\t\t</div>\n");
				
                  } else {

      out.write("\n");
      out.write("\t\t\t\t\t<hr>\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group row text-right\">\n");
      out.write("\t\t\t\t\t\t    <div class=\"col-sm-9\">\n");
      out.write("\t\t\t\t\t\t      ");
      out.print(comment.getCb_cmt_writer());
      out.write("님의 의견 - ");
      out.print(comment.getCb_cmt_date());
      out.write("<br>\n");
      out.write("\t\t\t\t\t\t      ");
      out.print(comment.getCb_cmt_content());
      out.write("\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t    <label class=\"col-sm-3 col-form-label text-center\"> img <┚</label>\n");
      out.write("\t\t\t\t\t\t</div>\n");
                	  
                  }
               if (userid.equals(comment.getCb_cmt_writer()) ) {

      out.write('\n');

               	if(comment.getCb_cmt_step() != 0){

      out.write("\n");
      out.write("\t\t\t\t\t\t<div class=\"col-sm-12 text-right\">\n");
      out.write("\t\t\t\t\t\t    <button type=\"button\" class=\"btn btn-sm btn-outline-secondary\" onclick=\"updateOpen(");
      out.print(comment.getCb_cmt_id());
      out.write(',');
      out.write(' ');
      out.print(cb_id);
      out.write(',');
      out.write(' ');
      out.print(pageNum);
      out.write(");\">수정</button>\n");
      out.write("\t\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger\" onclick=\"document.location.href='deleteCommentPro.jsp?cb_id=");
      out.print(cb_id);
      out.write("&cb_cmt_id=");
      out.print(comment.getCb_cmt_id());
      out.write("&userid=");
      out.print(userid);
      out.write("&pageNum=");
      out.print(pageNum);
      out.write("&cb_cmt_ref=");
      out.print(cb_id);
      out.write("&pageNum=");
      out.print(pageNum);
      out.write("'\">삭제</button>\n");
      out.write("\t\t\t\t\t\t</div>\n");
                   
               	}else{

      out.write("\n");
      out.write("\t\t\t\t\t\t<div class=\"col-sm-12 text-right\">\n");
      out.write("\t\t\t\t\t\t     <button type=\"button\" class=\"btn btn-sm btn-outline-secondary\" onclick=\"updateOpen(");
      out.print(comment.getCb_cmt_id());
      out.write(',');
      out.write(' ');
      out.print(cb_id);
      out.write(',');
      out.write(' ');
      out.print(pageNum);
      out.write(");\">수정</button>\n");
      out.write("\t\t\t\t\t\t\t <button type=\"button\" class=\"btn btn-sm btn-outline-danger\" onclick=\"document.location.href='chanban_deleteCmtPro.jsp?cb_id=");
      out.print(cb_id);
      out.write("&cb_cmt_id=");
      out.print(comment.getCb_cmt_id());
      out.write("&userid=");
      out.print(userid);
      out.write("&pageNum=");
      out.print(pageNum);
      out.write("&cb_cmt_ref=");
      out.print(cb_id);
      out.write("'\">삭제</button>\n");
      out.write("\t\t\t\t\t\t\t <a class=\"btn btn-sm btn-outline-secondary\" onclick=\"this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';\" href=\"javascript:void(0)\"> 답글쓰기 </a><div style=\"display: none\">\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_id\" value=\"");
      out.print(comment.getCb_cmt_id());
      out.write("\"> \n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_group\" value=\"");
      out.print(comment.getCb_cmt_group());
      out.write("\"> \n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_step\" value=\"");
      out.print(comment.getCb_cmt_step());
      out.write("\"> \n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_level\" value=\"");
      out.print(comment.getCb_cmt_level());
      out.write("\">\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_type\" value=\"");
      out.print(comment.getCb_cmt_type());
      out.write("\"> \n");
      out.write("\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_ref\" value=\"");
      out.print(cb_id);
      out.write("\"> \n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"pageNum\" value=\"");
      out.print(pageNum);
      out.write("\"> \n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"cb_cmt_writer\" value=\"");
      out.print(userid);
      out.write("\">\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" name=\"userid\" value=\"");
      out.print(userid);
      out.write("\">\n");
      out.write("\t\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"card\">\n");
      out.write("\t\t\t\t\t\t\t\t  <div class=\"card-body\">\n");
      out.write("\t\t\t\t\t\t\t\t    <div class=\"form-group text-center\">reply</div>\n");
      out.write("\t\t\t\t\t\t\t\t    <hr>\n");
      out.write("\t\t\t    \t\t\t\t\n");
      out.write("\t\t\t\t    \t\t\t\t<div class=\"form-group row\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<label class=\"col-sm-12\" ></label>\n");
      out.write("\t\t\t\t\t\t\t\t\t    <label class=\"col-sm-2 col-form-label text-center\">");
      out.print(userid);
      out.write("</label>\n");
      out.write("\t\t\t\t\t\t\t\t\t    <div class=\"col-sm-10 text-left\">\n");
      out.write("\t\t\t\t\t\t\t\t\t      <textarea class=\"form-control summernote\" name=\"cb_cmt_content\"></textarea>\n");
      out.write("\t\t\t\t\t\t\t\t\t    </div>\n");
      out.write("\t\t\t\t\t\t\t\t\t </div>\n");
      out.write("\t\t\t\t\t\t\t\t \n");
      out.write("\t\t\t\t\t\t\t\t\t <div class=\"form-group row text-right\">\n");
      out.write("\t\t\t\t\t\t\t\t\t    <div class=\"col-sm-12\">\n");
      out.write("\t\t\t\t\t\t\t\t\t      <button type=\"submit\" class=\"btn btn-outline-secondary btn-sm\">의견작성</button>\n");
      out.write("\t\t\t\t\t\t\t\t\t      <button type=\"reset\" class=\"btn btn-outline-danger btn-sm\">다시입력</button>\n");
      out.write("\t\t\t\t\t\t\t\t\t    </div>\n");
      out.write("\t\t\t\t\t\t\t\t\t </div>\n");
      out.write("\t\t\t\t\t\t\t\t\t  \n");
      out.write("\t\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t</div>\n");
                   
              	}

      out.write('\n');

              } else {

      out.write("\n");
      out.write("\t\t\t\t\t\t<div class=\"col-sm-12\">\n");
      out.write("\t\t\t\t\t      \t<button type=\"button\" class=\"btn btn-sm btn-outline-secondary\" disabled=\"disabled\" style=\"display:none;\">수정</button>\n");
      out.write("\t\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-sm btn-outline-danger\" disabled=\"disabled\" style=\"display:none;\">삭제</button>\n");
      out.write("\t\t\t\t\t\t</div>\n");

             }
	    }
	}

      out.write("\n");
      out.write("\t\t\t\t</form>\n");
      out.write("\t\t\t</div>\t\n");

                   

	} catch (Exception e) {

		}

      out.write("\n");
      out.write("\t</div>\n");
      out.write("</section>\n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/module/footer.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("$(document).ready(function() {\n");
      out.write("\t  $('.summernote').summernote({\n");
      out.write("\t\t  height:150\n");
      out.write("\t  });\n");
      out.write("\n");
      out.write("});\n");
      out.write(" </script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("function updateOpen(cb_cmt_id, cb_id, pageNum) {\n");
      out.write("   url = 'chanban_updateCmtForm.jsp?cb_cmt_id=' + cb_cmt_id + '&cb_id=' + cb_id + '&pageNum=' + pageNum;\n");
      out.write("   window.open(url, '댓글 수정', 'height=200, width=400, scrollbars=no, resizable=no');\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("$(document).ready(function() {\n");
      out.write("   var rs = [];\n");
      out.write("   var cb_like_type = '");
      out.print(cb_like_type);
      out.write("';\n");
      out.write("   var like_count = ");
      out.print(like_count);
      out.write(";\n");
      out.write("   var cb_id = '");
      out.print(cb_id);
      out.write("';\n");
      out.write("   var mem_id = '");
      out.print(userid);
      out.write("';\n");
      out.write("   if(cb_like_type=='N') {\n");
      out.write("      rs.push('<button class=\"btn btn-link\" type=\"submit\" id=\"like\" ><i id=\"likeIcon\" class=\"far fa-heart fa-lg\" style=\"color:black;\"></i></button><span id=\"likeCount\">'+like_count+'개</span>');\n");
      out.write("      rs.push('<input type=\"hidden\" name=\"currentLike\" value=\"N\">');\n");
      out.write("      rs.push('<input type=\"hidden\" name=\"cb_id\" value=\"'+cb_id+'\">');\n");
      out.write("      rs.push('<input type=\"hidden\" name=\"mem_id\" value=\"'+mem_id+'\">');\n");
      out.write("      $('#likeForm').append(rs.join(''));\n");
      out.write("   } else if(cb_like_type=='Y') {\n");
      out.write("      rs.push('<button class=\"btn btn-link\" type=\"submit\" id=\"like\"><i id=\"likeIcon\" class=\"fas fa-heart fa-lg\" style=\"color:red;\"></i></button><span id=\"likeCount\">'+like_count+'개</span>');\n");
      out.write("      rs.push('<input type=\"hidden\" name=\"currentLike\" value=\"Y\">');\n");
      out.write("      rs.push('<input type=\"hidden\" name=\"cb_id\" value=\"'+cb_id+'\">');\n");
      out.write("      rs.push('<input type=\"hidden\" name=\"mem_id\" value=\"'+mem_id+'\">');\n");
      out.write("      $('#likeForm').append(rs.join(''));\n");
      out.write("   }\n");
      out.write("   \n");
      out.write("   var currentLike = '';\n");
      out.write("\n");
      out.write("   $('#likeForm').submit(function(event) {\n");
      out.write("      event.preventDefault();\n");
      out.write("      var $form = $(this),\n");
      out.write("      cb_id = $form.find('input[name=\"cb_id\"]').val(),\n");
      out.write("      mem_id = $form.find('input[name=\"mem_id\"]').val(),\n");
      out.write("      cb_like_type = $form.find('input[name=\"currentLike\"]').val();\n");
      out.write("\n");
      out.write("      var posting = $.post('chanban_like_pro.jsp', { \n");
      out.write("         cb_id: cb_id,\n");
      out.write("         mem_id: mem_id,\n");
      out.write("         currentLike: cb_like_type\n");
      out.write("      });\n");
      out.write("      posting.done(function(data) {\n");
      out.write("         console.log(data);\n");
      out.write("         $('#likeForm').find('input[name=\"currentLike\"]').val(data.ltype);\n");
      out.write("         \n");
      out.write("         if(data.ltype == 'Y') {\n");
      out.write("            $('#likeIcon').removeClass('far');\n");
      out.write("              $('#likeIcon').addClass('fas');\n");
      out.write("              $('#likeIcon').attr('style', 'color:red');\n");
      out.write("         } else if(data.ltype == 'N') {\n");
      out.write("            $('#likeIcon').removeClass('fas');\n");
      out.write("              $('#likeIcon').addClass('far');\n");
      out.write("              $('#likeIcon').attr('style', 'color:black');\n");
      out.write("         }\n");
      out.write("          \n");
      out.write("         $('#likeCount').html(data.lcount+'개');\n");
      out.write("      });\n");
      out.write("   });\n");
      out.write("   \n");
      out.write("});\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
