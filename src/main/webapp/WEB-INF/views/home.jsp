<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DailyMe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css" rel="stylesheet" />
    <link href="${contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<style>
img.weather{
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
}
</style>
<script>
	var key;
	
	var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	
	$(function(){
		key = '406cb129de55319689873830b7932d4d';
		
		getTime();
		
		navigator.geolocation.getCurrentPosition(
		function(result){
			var latitude  = result.coords.latitude;	 // 경도 
			var longitude = result.coords.longitude; // 위도
			
			searchWeather(latitude,longitude);
		}, 
		function(){
			console.log('error');
		});
	});
	
	function searchWeather(latitude,longitude) {
		var url = 'https://api.openweathermap.org/data/2.5/weather?lat='+latitude+'&lon='+longitude+'&appid='+key+'&units=metric';
		
		fetch(url).then(function(response){
			return response.json();
		}).then(function(result){
			if(result.cod == '200') {
				console.log(result);
				$('#temp').text(Math.round(Number(result.main.temp)) + ' ℃');
				$('#area').text(result.weather[0].main);
				$('#name').text(result.name);
				
				changeImageAndBackground(result.weather[0].main,result.weather[0].icon);
			}
		});
	}
	
	function changeImageAndBackground(main,icon) {
		if(main == 'Sunny') {
			$('#backImg').css({'background':'linear-gradient( 45deg, yellow, #ff7907 )'});
			$('#mainImg').attr('src','${contextPath}/resources/images/sunny.png').addClass('weather');
		} else if(main == 'Clouds' || main == 'Haze' || main == 'Mist' || 'Snow') {
			$('#backImg').css({'background':'linear-gradient( 45deg, #8bddd2, #6c757d )'});
			$('#mainImg').attr('src','https://openweathermap.org/img/wn/'+icon+'@2x.png').removeClass('weather');
		} else {
			$('#backImg').css({'background':'linear-gradient( 45deg, yellow, #ff7907 )'});
			$('#mainImg').attr('src','https://openweathermap.org/img/wn/'+icon+'@2x.png').removeClass('weather');
		}
	}
	
	function getTime() {
		var initDate = new Date();
		$('#month').text(monthNames[initDate.getMonth()]);
		$('#time').text( ('0' + initDate.getHours()).slice(-2)+':'+('0' + initDate.getMinutes()).slice(-2));
		
		setInterval(function(){
			var today = new Date();
			$('#time').text( ('0' + today.getHours()).slice(-2)+':'+('0' + today.getMinutes()).slice(-2));
		},30000);
	}
</script>

<body id="page-top">
   <!-- Navigation-->
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
   <!-- Masthead-->
   <!-- 맑음 45deg, yellow, #ff7907 -->
   <!-- 눈 45deg, #f406ff70, #0dcaf0  -->
   <!-- 비 45deg, #46f5dd, #6c757d   -->
   <!-- 구름 45deg, #8bddd2, #6c757d   -->
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
   <!-- Bootstrap core JS-->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
   <script src="${contextPath}/js/scripts.js"></script>
   <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
   
</body>
</html>