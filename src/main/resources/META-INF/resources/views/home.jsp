<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DailyMe</title>
	<!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
     <!-- Google fonts-->
     <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
     <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
     <!-- SimpleLightbox plugin CSS-->
     <link href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css" rel="stylesheet" />
     <!-- Core theme CSS (includes Bootstrap)-->
     <link href="${contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
<script src="js/scripts.js"></script>
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>


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
   <header class="masthead" style="height:-webkit-fill-available; background: linear-gradient( 45deg, yellow, #ff7907 );">
       <div class="container px-4 px-lg-5 h-100">
           <div class="row gx-4 gx-lg-5 h-50 align-items-center justify-content-center text-center">
               <div class="col-lg-8 align-self-end">
                   <h1 class="text-white font-weight-bold" style="text-align:left; font-size:30px;">November</h1>
                   <h1 class="text-white font-weight-bold" style="text-align:left; margin-bottom:75px; font-size:75px;">17:15</h1>
               </div>
               <div class="col-lg-8 align-self-baseline">
               		<img style="width:400px; height:400px;" src="${contextPath}/resources/images/sunny.png">
               </div>
               <div class="col-lg-8 align-self-end">
                   <h1 class="text-white font-weight-bold" style="text-align:center; margin-top:100px; font-size:120px;">13 ℃</h1>
                   <hr style="border:4px solid #ffffff;">
                   <h1 class="text-white font-weight-bold" style="text-align:center;  font-size:75px;">Sunny</h1>
               </div>
           </div>
       </div>
   </header>
   <!-- Bootstrap core JS-->
   
</body>
</html>