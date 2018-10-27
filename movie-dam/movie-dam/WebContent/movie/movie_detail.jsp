<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "영화 상세";
	String id = request.getParameter("id");
	String api_key = "9dd279523f7113a4103a8f1e9ef6abe3";
%>

<jsp:include page="/module/header.jsp" flush="false">
	<jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<jsp:include page="/module/nav.jsp" flush="false"/>

<!-- ***** Breadcumb Area Start ***** -->
<div class="breadcumb-area height-700 bg-img bg-overlay">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcumb-content">
                    <div class="map-ratings-review-area d-flex">
                        <a href="#" class="d-flex align-items-center justify-content-center"><i class="fa fa-heart-o" aria-hidden="true"></i></a>
                        <a href="#" id="vote_average"></a>
                        <a href="#">토론글 작성</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- ***** Breadcumb Area End ***** -->

<!-- ***** Single Listing Area Start ***** -->
<section class="dorne-single-listing-area section-padding-100">
	<div class="container">
        <div class="row justify-content-center">
            <!-- Single Listing Content -->
			<div class="col-12 col-lg-8">
    			<div class="single-listing-content">
			        <div class="listing-title">
			            <h4 id="title"></h4>
			            <h6 id="release_date"></h6>
			        </div>
			        <div class="single-listing-nav">
                        <nav>
                            <ul id="listingNav">
                                <li class="active"><a href="#overview">기본 정보</a></li>
                                <li><a href="#credit">출연·제작</a></li>
                                <li><a href="https://peaceful-basin-13921.herokuapp.com/">예고편</a></li>
                                <li><a href="#similar">관련 영화</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="overview-content mt-50" id="overview">
                    	<h6 id="tagline"></h6>
	                    <p id="overview_text"></p>
	                    <div class="row mt-5">
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Accepts Credit Cards</span>
	                            </label>
	                        </div>
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Bike Parking</span>
	                            </label>
	                        </div>
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Wireless Internet</span>
	                            </label>
	                        </div>
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Reservations</span>
	                            </label>
	                        </div>
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Privat Parking</span>
	                            </label>
	                        </div>
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Smoking Area</span>
	                            </label>
	                        </div>
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Wheelchair Accesible</span>
	                            </label>
	                        </div>
	                        <div class="col-6">
	                            <label class="custom-control custom-checkbox mb-3">
	                                <input type="checkbox" class="custom-control-input">
	                                <span class="custom-control-indicator"></span>
	                                <span class="custom-control-description">Coupons</span>
	                            </label>
	                        </div>
	                    </div>
	                </div>
	                <div class="listing-reviews-area mt-100" id="credit">
	                    <h4>출연·제작</h4>
	                    <div class="row">
		                    <div class="single-review-area col">
		                        <div class="reviewer-meta d-flex align-items-center">
		                            <img src="/movie-dam/assets/img/clients-img/1.jpg" alt="">
		                            <div class="reviewer-content">
		                                <div class="review-title-ratings d-flex justify-content-between">
		                                    <h6>Michael Brown</h6>
		                                </div>
		                                <p> ipsum.gula non volutpat.</p>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="single-review-area col">
		                        <div class="reviewer-meta d-flex align-items-center">
		                            <img src="/movie-dam/assets/img/clients-img/1.jpg" alt="">
		                            <div class="reviewer-content">
		                                <div class="review-title-ratings d-flex justify-content-between">
		                                    <h6>Michael Brown</h6>
		                                </div>
		                                <p> ipsum.gula non volutpat.</p>
		                            </div>
		                        </div>
		                    </div>
	                    </div>	
	                </div>
	                <div class="listing-menu-area mt-100" id="similar">
	                    <h4>관련 영화</h4>
	                    <!-- Single Listing Menu -->
	                    <div class="single-listing-menu d-flex justify-content-between">
	                        <!-- Listing Menu Title -->
	                        <div class="listing-menu-title">
	                            <h6>Classic Burger</h6>
	                            <p>Beef, salad, mustard, bacon, mayonnaise, spicey relish, cheese</p>
	                        </div>
	                        <!-- Listing Menu Price -->
	                        <div class="listing-menu-price">
	                            <h6>$9,90</h6>
	                        </div>
	                    </div>
	                    <!-- Single Listing Menu -->
	                    <div class="single-listing-menu d-flex justify-content-between">
	                        <!-- Listing Menu Title -->
	                        <div class="listing-menu-title">
	                            <h6>House Special Burger</h6>
	                            <p>Beef, salad, mustard, bacon, mayonnaise, spicey relish, cheese</p>
	                        </div>
	                        <!-- Listing Menu Price -->
	                        <div class="listing-menu-price">
	                            <h6>$9,90</h6>
	                        </div>
	                    </div>
	                    <!-- Single Listing Menu -->
	                    <div class="single-listing-menu d-flex justify-content-between">
	                        <!-- Listing Menu Title -->
	                        <div class="listing-menu-title">
	                            <h6>Classic Burger</h6>
	                            <p>Beef, salad, mustard, bacon, mayonnaise, spicey relish, cheese</p>
	                        </div>
	                        <!-- Listing Menu Price -->
	                        <div class="listing-menu-price">
	                            <h6>$9,90</h6>
	                        </div>
	                    </div>
	                    <!-- Single Listing Menu -->
	                    <div class="single-listing-menu d-flex justify-content-between">
	                        <!-- Listing Menu Title -->
	                        <div class="listing-menu-title">
	                            <h6>House Special Burger</h6>
	                            <p>Beef, salad, mustard, bacon, mayonnaise, spicey relish, cheese</p>
	                        </div>
	                        <!-- Listing Menu Price -->
	                        <div class="listing-menu-price">
	                            <h6>$9,90</h6>
	                        </div>
	                    </div>
	                    <a href="#" class="btn dorne-btn mt-50">+ 관련 영화 더 보기</a>
	                </div>
        		</div>
       		</div>
       		
       		<!-- Listing Sidebar -->
            <div class="col-12 col-md-8 col-lg-4">
                <div class="listing-sidebar">

                    <!-- Listing Verify -->
                    <div class="listing-verify">
                        <a href="#" class="btn dorne-btn w-100"><i class="fa fa-check pr-3"></i> Verified Listing</a>
                    </div>

                    <!-- Book A Table Widget -->
                    <div class="book-a-table-widget mt-50">
                        <h6>Book A Table</h6>
                        <form action="#" method="get">
                            <select class="custom-select" id="destinations">
                            <option selected>Who will be arriving</option>
                            <option value="1">New York</option>
                            <option value="2">Latvia</option>
                            <option value="3">Dhaka</option>
                            <option value="4">Melbourne</option>
                            <option value="5">London</option>
                        </select>
                            <select class="custom-select" id="catagories">
                            <option selected>Guest 1</option>
                            <option value="1">Guest 2</option>
                            <option value="3">Guest 3</option>
                            <option value="3">Guest 4</option>
                        </select>
                            <button type="submit" class="btn dorne-btn bg-white text-dark"><i class="fa fa-search pr-2" aria-hidden="true"></i> Search</button>
                        </form>
                    </div>

                    <!-- Opening Hours Widget -->
                    <div class="opening-hours-widget mt-50">
                        <h6>Opening Hours</h6>
                        <ul class="opening-hours">
                            <li>
                                <p>Monday</p>
                                <p>Closed</p>
                            </li>
                            <li>
                                <p>Tuesday</p>
                                <p>9 AM - 1 PM</p>
                            </li>
                            <li>
                                <p>Wednesday</p>
                                <p>9 AM - 1 PM</p>
                            </li>
                            <li>
                                <p>Thursday</p>
                                <p>9 AM - 1 PM</p>
                            </li>
                            <li>
                                <p>Friday</p>
                                <p>9 AM - 1 PM</p>
                            </li>
                            <li>
                                <p>Saturday</p>
                                <p>9 AM - 1 PM</p>
                            </li>
                            <li>
                                <p>Sunday</p>
                                <p>9 AM - 1 PM</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
   		</div>
	</div>
</section>



<jsp:include page="/module/footer.jsp" flush="false"/>

<script>
var api_key = '<%=api_key%>';
$(document).ready(function() {
	var settings = {
		async: true,
	  	crossDomain: true,
	  	url: 'https://api.themoviedb.org/3/movie/'+<%=id%>+'',
		method: 'GET',
	  	data: {
		  	'language': 'ko-KR',
		  	'api_key': api_key
	  	},
	  	dataType: 'json',
	  	headers: {}
	}
	
	$.ajax(settings).done(function (response) {
		var rs = [];
	 	console.log(response);
	 	$('.breadcumb-area').attr('style', 'background-image: url(https://image.tmdb.org/t/p/original'+response["backdrop_path"]+');');
	  	$('#vote_average').html(response['vote_average']);
	 	$('#title').html(response['title']);
	 	var releaes_year = new Date(response['release_date']).getFullYear();
	  	$('#release_date').html(releaes_year+' · 국가명');
	  	$('#overview_text').html(response['overview']);
	  	$('#tagline').html(response['tagline']);
	  
	 	$('#home').html(rs.join(''));
	});	
});
</script>
</body>
</html>