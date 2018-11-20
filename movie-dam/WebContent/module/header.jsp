<%@ page language="java" contentType="text/html; charset=UTF-8" 
   pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
   String pageTitle = request.getParameter("title");   
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>영화담 | <%=pageTitle %></title>

<!-- Favicon -->
<link rel="icon" href="/movie-dam/assets/img/core-img/favicon.ico">

<!-- Core Stylesheet -->
<link rel="stylesheet" href="/movie-dam/assets/style.css">
<link rel="stylesheet" href="/movie-dam/assets/css/argon.min.css">

<!-- Responsive CSS -->
<link rel="stylesheet" href="/movie-dam/assets/css/responsive/responsive.css">

<!-- Summernote CSS -->
<link rel="stylesheet" href="/movie-dam/assets/css/summernote-0.8.9/summernote-lite.css" rel="stylesheet">

<!-- Icon -->
<link rel="stylesheet" href="/movie-dam/assets/css/vender/nucleo/css/nucleo.css">

<!-- Custom styles -->
<link href="/movie-dam/assets/css/custom.css" rel="stylesheet">

<link href="/movie-dam/assets/css/calendar/fullcalendar.css">
<link href="/movie-dam/assets/css/calendar/fullcalendar.print.css">

<style>
#category {
   position: absolute;
   top: 10px;
   left: 10px;
   border-radius: 5px;
   border: 1px solid #909090;
   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
   background: #fff;
   overflow: hidden;
   z-index: 2;
}

#category li {
   float: left;
   list-style: none;
   width: 50px; px;
   border-right: 1px solid #acacac;
   padding: 6px 0;
   text-align: center;
   cursor: pointer;
}

#category li.on {
   background: #eee;
}

#category li:hover {
   background: #ffe6e6;
   border-left: 1px solid #acacac;
   margin-left: -1px;
}

#category li:last-child {
   margin-right: 0;
   border-right: 0;
}

#category li span {
   display: block;
   margin: 0 auto 3px;
   width: 27px;
   height: 28px;
}

#category li .category_bg {
   background: url(http://i68.tinypic.com/28l2q0.png) no-repeat;
}

#category li .bank {
   background-position: -10px 0;
}

#category li .subway {
   background-position: -10px -36px;
}

#category li .parking {
   background-position: -10px -72px;
}

#category li .restaurant {
   background-position: -10px -108px;
}

#category li .cafe {
   background-position: -10px -144px;
}

#category li .store {
   background-position: -10px -180px;
}

#category li.on .category_bg {
   background-position-x: -46px;
}

</style>
</head>

<body>

<!-- Preloader -->
<div id="preloader">
   <div class="dorne-load"></div>
</div> 

<!-- ***** Search Form Area ***** -->
<div class="dorne-search-form d-flex align-items-center">
   <div class="container">
      <div class="row">
         <div class="col-12">
            <div class="search-close-btn" id="closeBtn">
               <i class="pe-7s-close-circle" aria-hidden="true"></i>
            </div>
            <form action="#" method="get">
               <input type="search" name="caviarSearch" id="search" placeholder="Search Your Desire Destinations or Events">
               <input type="submit" class="d-none" value="submit">
            </form>
         </div>
      </div>
   </div>
</div>