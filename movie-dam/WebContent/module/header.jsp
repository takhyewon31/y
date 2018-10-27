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