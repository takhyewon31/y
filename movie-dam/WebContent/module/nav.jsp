<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ***** Header Area Start ***** -->
<header class="header_area" id="header">
	<div class="container-fluid h-100">
		<div class="row h-100">
			<div class="col-12 h-100">
				<nav class="h-100 navbar navbar-expand-lg">
					<a class="navbar-brand" href="/movie-dam/main.jsp"><img src="/movie-dam/assets/img/core-img/logo.png" alt=""></a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#dorneNav" aria-controls="dorneNav" aria-expanded="false" aria-label="Toggle navigation">
						<span class="fas fa-bars"></span>
					</button>
					<!-- Nav -->
					<div class="collapse navbar-collapse" id="dorneNav">
						<ul class="navbar-nav mr-auto" id="dorneMenu">
							<li class="nav-item active">
								<a class="nav-link" href="/movie-dam/main.jsp">Home <span class="sr-only">(current)</span></a>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Movie info 
								</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="/movie-dam/movie/movie_list.jsp">Movie List</a> 
									<a class="dropdown-item" href="/movie-dam/movie/movie_boxoffice.jsp">Box office</a> 
									<a class="dropdown-item" href="/movie-dam/movie/movie_search.jsp">Search movie</a> 
								</div>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Debate 
								</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown2">
									<a class="dropdown-item" href="/movie-dam/debate/debate_chanban.jsp">Pro-con debate</a> 
									<a class="dropdown-item" href="/movie-dam/debate/debate_battle.jsp">Debate battle</a>
								</div>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown3" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Playground 
								</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown3">
									<a class="dropdown-item" href="/movie-dam/board/free_board.jsp?category=all">Free board</a> 
									<a class="dropdown-item" href="/movie-dam/board/map_category.jsp">Cinema map</a>
									<a class="dropdown-item" href="/movie-dam/board/cinema_restaurant.jsp?theater=all">Cinema restaurant</a>
								</div>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown4" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">News 
								</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown4">
									<a class="dropdown-item" href="/movie-dam/board/movie_preview.jsp">Preview</a> 
									<a class="dropdown-item" href="/movie-dam/board/movie_stage.jsp">Stage</a>
									<a class="dropdown-item" href="/movie-dam/board/movie_issue.jsp">Movie issue</a> 
								</div>
							</li>
						</ul>
						<!-- Search btn -->
						<div class="dorne-search-btn">
							<a id="search-btn" href="#"><i class="fas fa-search" aria-hidden="true"></i> Search</a>
						</div>
						<!-- Signin btn -->
						<c:if test="${sessionScope.userid eq null }"> <!-- 비로그인 상태 -->
							<div class="dorne-signin-btn">
								<a href="/movie-dam/member/login_form.jsp">Log in or Register</a>
							</div>
						</c:if>
						<c:if test="${sessionScope.userid ne null }"> <!-- 로그인 상태 -->
							<div class="dorne-signin-btn">
								<a href="/movie-dam/member/logout.jsp">Logout</a>
								<a href="/movie-dam/member/profile.jsp?mem_userid=${sessionScope.userid }">Profile</a>
							</div>
						</c:if>
					</div>
				</nav>
			</div>
		</div>
	</div>
</header>
<!-- ***** Header Area End ***** -->