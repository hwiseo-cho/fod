<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dailyme</title>
    <link rel="icon" type="${contextPath}/resources//images/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Google fonts-->
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,wght@0,600;1,600&amp;display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,300;0,500;0,600;0,700;1,300;1,500;1,600;1,700&amp;display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,400;1,400&amp;display=swap" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<!-- * *                               SB Forms JS                               * *-->
<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
/* img.weather{
    animation: rotate_image 25s linear infinite;
    transform-origin: 50% 50%;
}

img.other{
    animation: rotate_image 25s linear infinite;
    transform-origin: 50% 50%;
}
 
@keyframes rotate_image{
	100% {
    	transform: rotate(360deg);
    }
} */
/*   
linear-gradient(
177deg
, rgb(52 159 251), rgb(176 218 255)); 

linear-gradient(45deg, #4b647c, #525252)
*/

.weather_list{
	width:80px;
	text-align:center;
	float:left;
}
.weather_list>div{
	width:80px;
}

#weatherList::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
}
</style>
<script>
	var key;
	
	var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	
	var initDate;
	
	$(function(){
		key = '406cb129de55319689873830b7932d4d';
		
		getTime();
		
		navigator.geolocation.getCurrentPosition(
		function(result){
			var latitude  = result.coords.latitude;	 // 경도 
			var longitude = result.coords.longitude; // 위도
			
			searchWeather('1000',latitude,longitude);
			searchWeather('1001',latitude,longitude);
		}, 
		function(){
			console.log('error');
		});
	});
	
	function searchWeather(num,latitude,longitude) {
		var url = '';
		if(num == '1000') {
			url = 'https://api.openweathermap.org/data/2.5/weather?lat='+latitude+'&lon='+longitude+'&appid='+key+'&units=metric&lang=kr';
		} else if(num == '1001') {
			url = 'https://api.openweathermap.org/data/2.5/onecall?lat='+latitude+'&lon='+longitude+'&units=metric&lang=kr&appid='+key;
		}
		
		fetch(url).then(function(response){
			return response.json();
		}).then(function(result){
			
			console.log(result);
			
			if(num == '1000') {
				$('#temp').text(Math.round(Number(result.main.temp)) + ' ℃');
				$('#area').text(result.weather[0].description);
				$('#name').text(result.name);
				
				changeImageAndBackground(result.weather[0].main,result.weather[0].icon);
			} else if(num == '1001') {
				var hourly = result.hourly;
				$('#weatherList').html();
				
				var str = '';
				for(var i=0; i<24; i++) {
					var hour = Number(('0' + initDate.getHours()).slice(-2))+i+1;
					if(hour > 23) {
						hour -= 24;
					}
					str += '<div class="weather_list">';
					str += '	<div>'+ hour +'시</div>';
					str += '	<div><img src="https://openweathermap.org/img/wn/'+hourly[i].weather[0].icon+'@2x.png" style="width:100%;" /></div>';
					str += '	<div>'+Math.round(Number(hourly[i].temp)) + ' ℃'+'</div>';
					str += '</div>';
				}
				
				$('#weatherList').html(str);	
			}
		});
	}
	
	function changeImageAndBackground(main,icon) {
		$('#mainImg').attr('src','https://openweathermap.org/img/wn/'+icon+'@2x.png').removeClass('weather');
		$('#mainImg2').attr('src','https://openweathermap.org/img/wn/'+icon+'@2x.png').removeClass('weather');
	}
	
	function getTime() {
		initDate = new Date();
		$('#month').text(monthNames[initDate.getMonth()]);
		$('#time').text( ('0' + initDate.getHours()).slice(-2)+':'+('0' + initDate.getMinutes()).slice(-2));
		
		if(Number(initDate.getHours()) >= 18) {
			$('.masthead').css({'background':'linear-gradient(45deg, #4b647c, #525252)','padding-top':'6.5rem !important'});
		}
		
		setInterval(function(){
			var today = new Date();
			$('#time').text( ('0' + today.getHours()).slice(-2)+':'+('0' + today.getMinutes()).slice(-2));
		},30000);
	} 
</script>

<!-- <body id="page-top">
   Navigation
   <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav" style="background:none; box-shadow:none; height:120px;">
       <div class="container px-4 px-lg-5">
           <a class="navbar-brand" href="#page-top"></a>
           <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation" style="border:none;"><span class="navbar-toggler-icon" style="width:50px;"></span></button>
           <div class="collapse navbar-collapse" id="navbarResponsive">
               <ul class="navbar-nav ms-auto my-2 my-lg-0">
                   <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                   <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                   <li class="nav-item"><a class="nav-link" href="#portfolio">Portfolio</a></li>
                   <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
               </ul>
           </div>
       </div>
   </nav>
   Masthead
   맑음 45deg, yellow, #ff7907
   눈 45deg, #f406ff70, #0dcaf0 
   비 45deg, #46f5dd, #6c757d  
   구름 45deg, #8bddd2, #6c757d  
   <header id="backImg" class="masthead" style="height:inherit; background: linear-gradient( 45deg, yellow, #ff7907 );">
       <div class="container px-4 px-lg-5 h-100">
           <div class="row gx-4 gx-lg-5 h-50 align-items-center justify-content-center text-center">
               <div class="col-lg-8 align-self-end">
                   <h1 id="month" class="text-white font-weight-bold" style="text-align:left; font-size:55px;"></h1>
                   <h1 id="time" class="text-white font-weight-bold" style="text-align:left; margin-bottom:75px; font-size:100px;"></h1>
                   <h1 id="name" class="text-white font-weight-bold" style="text-align:center; margin-bottom:75px; font-size:120px; word-break:break-all;"></h1>
               </div>
               <div class="col-lg-8 align-self-baseline">
               		<img id="mainImg" class="weather" style="width:400px; height:400px;">
               </div>
               <div class="col-lg-8 align-self-end" style="text-align:center;">
                   <h1 id="temp" class="text-white font-weight-bold" style="text-align:center; margin-top:100px; font-size:140px;"></h1>
                   <hr style="border:4px solid #ffffff; opacity:unset; box-shadow:none; background:none; width:50%; display:inline-block;">
                   <h1 id="area" class="text-white font-weight-bold" style="text-align:center;  font-size:70px;"></h1>
               </div>
               
           </div>
       </div>
   </header>
   Bootstrap core JS
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
   


   <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
   
</body> -->
	<body id="page-top" style="height:100%;">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm" id="mainNav" style="background-color:transparent;">
            <div class="container px-5">
                <a class="navbar-brand fw-bold" href="#page-top" style="color:#fff;"><span id="month"></span>&nbsp;&nbsp;<span id="time"></span></a>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <!-- <ul class="navbar-nav ms-auto me-4 my-3 my-lg-0">
                        <li class="nav-item"><a class="nav-link me-lg-3" href="#features">Features</a></li>
                        <li class="nav-item"><a class="nav-link me-lg-3" href="#download">Download</a></li>
                    </ul>
                    <button class="btn btn-primary rounded-pill px-3 mb-2 mb-lg-0" data-bs-toggle="modal" data-bs-target="#feedbackModal">
                        <span class="d-flex align-items-center">
                            <i class="bi-chat-text-fill me-2"></i>
                            <span class="small">Send Feedback</span>
                        </span>
                    </button> -->
                </div>
            </div>
        </nav>
        <!-- Mashead header-->
        <header class="masthead" style="background:linear-gradient(0deg, rgb(215 221 227) ,#24b8f4);">
            <div class="container px-5">
                <div class="row gx-5 align-items-center">
                    <div class="col-lg-6">
                        <!-- Mashead text and app badges-->
                        <div class="mb-5 mb-lg-0 text-center text-lg-start">
                            <h1 id="name" class="display-1 lh-1 mb-3" style="color:#fff;"></h1>
                           <!--  <p  class="lead fw-normal text-muted mb-5">Launch your mobile app landing page faster with this free, open source theme from Start Bootstrap!</p> -->
                        </div>
                    </div>
                    <div class="col-lg-6" style="margin-top:-115px;">
                        <!-- Masthead device mockup feature-->
                        <div class="masthead-device-mockup">
                            <svg class="circle" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" style="fill:transparent;">
                                <defs>
                                    <linearGradient id="circleGradient" gradientTransform="rotate(45)">
                                        <stop class="gradient-start-color" offset="0%"></stop>
                                        <stop class="gradient-end-color" offset="100%"></stop>
                                    </linearGradient>
                                </defs>
                                <%-- <circle cx="50" cy="50" r="50"></circle> --%></svg
                            ><svg class="shape-1 d-none d-sm-block" viewBox="0 0 240.83 240.83" xmlns="http://www.w3.org/2000/svg">
                               <!--  <rect x="-32.54" y="78.39" width="305.92" height="84.05" rx="42.03" transform="translate(120.42 -49.88) rotate(45)"></rect>
                                <rect x="-32.54" y="78.39" width="305.92" height="84.05" rx="42.03" transform="translate(-49.88 120.42) rotate(-45)"></rect> --></svg
                            ><svg class="shape-2 d-none d-sm-block" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><%-- <circle cx="50" cy="50" r="50"></circle> --%></svg>
                            <div class="device-wrapper">
                                <div class="device" data-device="iPhoneX" data-orientation="portrait" data-color="black">
                                    <div class="screen bg-black" style="background-color:transparent !important; display: flex; justify-content: center; align-items: center;">
                                        <%-- <video muted="muted" autoplay="" loop="" style="max-width: 100%; height: 100%"><source src="${contextPath}/resources/images/demo-screen.mp4" type="video/mp4" /></video> --%>
                                         
                                        <img id="mainImg" style="width:100%;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <h1 id="temp" class="display-1 lh-1 mb-3" style="color:#fff; text-align:center; margin-top:-30px;"></h1>
                    	<h2 id="area" class="display-1 lh-1 mb-3" style="color:#fff; text-align:center; font-size:30px;"></h2>
                    </div>
                    <hr>
                    <div id="weatherList" style="overflow-x:scroll; display:flex; padding:0;">	
                    </div>
                </div>
            </div>
        </header>
        <!-- Quote/testimonial aside-->
       <%--  <aside class="text-center bg-gradient-primary-to-secondary" style="background:#fff !important;">
            <div class="container px-5">
                <div class="row gx-5 justify-content-center">
                    <div class="col-xl-8">
                        <div class="h2 fs-1 text-white mb-4">"An intuitive solution to a common problem that we all face, wrapped up in a single app!"</div>
                        <img src="${contextPath}/resources/images/tnw-logo.svg" alt="..." style="height: 3rem" />
                    </div>
                </div>
            </div>
        </aside> --%>
        <%-- 
        <!-- App features section-->
        <section id="features">
            <div class="container px-5">
                <div class="row gx-5 align-items-center">
                    <div class="col-lg-8 order-lg-1 mb-5 mb-lg-0">
                        <div class="container-fluid px-5">
                            <div class="row gx-5">
                                <div class="col-md-6 mb-5">
                                    <!-- Feature item-->
                                    <div class="text-center">
                                        <i class="bi-phone icon-feature text-gradient d-block mb-3"></i>
                                        <h3 class="font-alt">Device Mockups</h3>
                                        <p class="text-muted mb-0">Ready to use HTML/CSS device mockups, no Photoshop required!</p>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-5">
                                    <!-- Feature item-->
                                    <div class="text-center">
                                        <i class="bi-camera icon-feature text-gradient d-block mb-3"></i>
                                        <h3 class="font-alt">Flexible Use</h3>
                                        <p class="text-muted mb-0">Put an image, video, animation, or anything else in the screen!</p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-5 mb-md-0">
                                    <!-- Feature item-->
                                    <div class="text-center">
                                        <i class="bi-gift icon-feature text-gradient d-block mb-3"></i>
                                        <h3 class="font-alt">Free to Use</h3>
                                        <p class="text-muted mb-0">As always, this theme is free to download and use for any purpose!</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <!-- Feature item-->
                                    <div class="text-center">
                                        <i class="bi-patch-check icon-feature text-gradient d-block mb-3"></i>
                                        <h3 class="font-alt">Open Source</h3>
                                        <p class="text-muted mb-0">Since this theme is MIT licensed, you can use it commercially!</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 order-lg-0">
                        <!-- Features section device mockup-->
                        <div class="features-device-mockup">
                            <svg class="circle" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                                <defs>
                                    <linearGradient id="circleGradient" gradientTransform="rotate(45)">
                                        <stop class="gradient-start-color" offset="0%"></stop>
                                        <stop class="gradient-end-color" offset="100%"></stop>
                                    </linearGradient>
                                </defs>
                                <circle cx="50" cy="50" r="50"></circle></svg
                            ><svg class="shape-1 d-none d-sm-block" viewBox="0 0 240.83 240.83" xmlns="http://www.w3.org/2000/svg">
                                <rect x="-32.54" y="78.39" width="305.92" height="84.05" rx="42.03" transform="translate(120.42 -49.88) rotate(45)"></rect>
                                <rect x="-32.54" y="78.39" width="305.92" height="84.05" rx="42.03" transform="translate(-49.88 120.42) rotate(-45)"></rect></svg
                            ><svg class="shape-2 d-none d-sm-block" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="50"></circle></svg>
                            <div class="device-wrapper">
                                <div class="device" data-device="iPhoneX" data-orientation="portrait" data-color="black">
                                    <div class="screen bg-black">
                                        <!-- PUT CONTENTS HERE:-->
                                        <!-- * * This can be a video, image, or just about anything else.-->
                                        <!-- * * Set the max width of your media to 100% and the height to-->
                                        <!-- * * 100% like the demo example below.-->
                                        <video muted="muted" autoplay="" loop="" style="max-width: 100%; height: 100%"><source src="${contextPath}/resources/images/demo-screen.mp4" type="video/mp4" /></video>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Basic features section-->
        <section class="bg-light">
            <div class="container px-5">
                <div class="row gx-5 align-items-center justify-content-center justify-content-lg-between">
                    <div class="col-12 col-lg-5">
                        <h2 class="display-4 lh-1 mb-4">Enter a new age of web design</h2>
                        <p class="lead fw-normal text-muted mb-5 mb-lg-0">This section is perfect for featuring some information about your application, why it was built, the problem it solves, or anything else! There's plenty of space for text here, so don't worry about writing too much.</p>
                    </div>
                    <div class="col-sm-8 col-md-6">
                        <div class="px-5 px-sm-0"><img class="img-fluid rounded-circle" src="https://source.unsplash.com/u8Jn2rzYIps/900x900" alt="..." /></div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Call to action section-->
        <section class="cta">
            <div class="cta-content">
                <div class="container px-5">
                    <h2 class="text-white display-1 lh-1 mb-4">
                        Stop waiting.
                        <br />
                        Start building.
                    </h2>
                    <a class="btn btn-outline-light py-3 px-4 rounded-pill" href="https://startbootstrap.com/theme/new-age" target="_blank">Download for free</a>
                </div>
            </div>
        </section>
        <!-- App badge section-->
        <section class="bg-gradient-primary-to-secondary" id="download">
            <div class="container px-5">
                <h2 class="text-center text-white font-alt mb-4">Get the app now!</h2>
                <div class="d-flex flex-column flex-lg-row align-items-center justify-content-center">
                    <a class="me-lg-3 mb-4 mb-lg-0" href="#!"><img class="app-badge" src="${contextPath}/resources/images/google-play-badge.svg" alt="..." /></a>
                    <a href="#!"><img class="app-badge" src="${contextPath}/resources/images/app-store-badge.svg" alt="..." /></a>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <footer class="bg-black text-center py-5">
            <div class="container px-5">
                <div class="text-white-50 small">
                    <div class="mb-2">&copy; Your Website 2021. All Rights Reserved.</div>
                    <a href="#!">Privacy</a>
                    <span class="mx-1">&middot;</span>
                    <a href="#!">Terms</a>
                    <span class="mx-1">&middot;</span>
                    <a href="#!">FAQ</a>
                </div>
            </div>
        </footer> --%>
        <!-- Feedback Modal-->
       <!--  <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-gradient-primary-to-secondary p-4">
                        <h5 class="modal-title font-alt text-white" id="feedbackModalLabel">Send feedback</h5>
                        <button class="btn-close btn-close-white" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body border-0 p-4">
                        * * * * * * * * * * * * * * *
                        * * SB Forms Contact Form * *
                        * * * * * * * * * * * * * * *
                        This form is pre-integrated with SB Forms.
                        To make this form functional, sign up at
                        https://startbootstrap.com/solution/contact-forms
                        to get an API token!
                        <form id="contactForm" data-sb-form-api-token="API_TOKEN">
                            Name input
                            <div class="form-floating mb-3">
                                <input class="form-control" id="name" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                <label for="name">Full name</label>
                                <div class="invalid-feedback" data-sb-feedback="name:required">A name is required.</div>
                            </div>
                            Email address input
                            <div class="form-floating mb-3">
                                <input class="form-control" id="email" type="email" placeholder="name@example.com" data-sb-validations="required,email" />
                                <label for="email">Email address</label>
                                <div class="invalid-feedback" data-sb-feedback="email:required">An email is required.</div>
                                <div class="invalid-feedback" data-sb-feedback="email:email">Email is not valid.</div>
                            </div>
                            Phone number input
                            <div class="form-floating mb-3">
                                <input class="form-control" id="phone" type="tel" placeholder="(123) 456-7890" data-sb-validations="required" />
                                <label for="phone">Phone number</label>
                                <div class="invalid-feedback" data-sb-feedback="phone:required">A phone number is required.</div>
                            </div>
                            Message input
                            <div class="form-floating mb-3">
                                <textarea class="form-control" id="message" type="text" placeholder="Enter your message here..." style="height: 10rem" data-sb-validations="required"></textarea>
                                <label for="message">Message</label>
                                <div class="invalid-feedback" data-sb-feedback="message:required">A message is required.</div>
                            </div>
                            Submit success message
                           
                            This is what your users will see when the form
                            has successfully submitted
                            <div class="d-none" id="submitSuccessMessage">
                                <div class="text-center mb-3">
                                    <div class="fw-bolder">Form submission successful!</div>
                                    To activate this form, sign up at
                                    <br />
                                    <a href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>
                                </div>
                            </div>
                            Submit error message
                           
                            This is what your users will see when there is
                            an error submitting the form
                            <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
                            Submit Button
                            <div class="d-grid"><button class="btn btn-primary rounded-pill btn-lg disabled" id="submitButton" type="submit">Submit</button></div>
                        </form>
                    </div>
                </div>
            </div>
        </div> -->
        
    </body>
</html>