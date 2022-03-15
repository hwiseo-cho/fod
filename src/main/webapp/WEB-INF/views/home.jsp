<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<script>
var latitude;
var longitude;
var map;
var points;
var infowindow;
var selectedMarker;
	
	$(function() {
		var markerList = JSON.parse('${markerList}');
		
		Kakao.init('b4fb5248ad811d92a174a67e993ad895');
		Kakao.isInitialized();
		
		navigator.geolocation.getCurrentPosition(
		function(result){
			latitude  = result.coords.latitude;	 // 경도 
			longitude = result.coords.longitude; // 위도
			
			
			
			var container = document.getElementById('map');
			var options = {
				center: new kakao.maps.LatLng(latitude, longitude),
				level: 3
			};
			map = new kakao.maps.Map(container, options);
			
			// 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다 
			points = [];
				
			for(var i=0; i<markerList.length; i++) {
				console.log(markerList[i]);
				points.push(
					{
						content:'<div style="padding:5px;font-size:12px;">' + markerList[i].PLACE_NAME + '</div>',
						latlng: new kakao.maps.LatLng(markerList[i].LATITUDE, markerList[i].LONGITUDE)
					}	
				);
			}
			
			// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
			var bounds = new kakao.maps.LatLngBounds();    

			for (var i = 0; i < points.length; i++) {
			    // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
			    var marker = new kakao.maps.Marker({ 
			    	position : points[i].latlng
			    });
			    
			    // 마커에 클릭이벤트를 등록합니다
		    	infowindow = new kakao.maps.InfoWindow({
		    		content: points[i].content
		    	});
			    
		    	kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		     	kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		     	
			    marker.setMap(map);
			    
				 // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
			    	console.log($(this)[0]);
			    });
			 
			    // LatLngBounds 객체에 좌표를 추가합니다
			    bounds.extend(points[i].latlng);
			}

			function setBounds() {
			    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
			    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
			    map.setBounds(bounds);
			}
			
			setBounds();
			
		},
		function(){
			console.log('error');
		});
		
		
		$('#searchBtn').on('click',function() {
			searchPlace();
		});
		
		$('#content').on('keyup keydown',function(event) {
			if(event.keyCode==13) {
				searchPlace();
			}
		});
	});

	function searchPlace() {
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		var text = $('#content').val();
		if(text == null || text == '') {
			alert('내용을 입력해주세요.');
			return;
		}
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(text, placesSearchCB); 

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}
	}
	
	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	    	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
</script>

<body>
   <!-- Product section-->
   <section class="py-5">
       <div class="container px-4 px-lg-5 my-5">
           <div class="row gx-4 gx-lg-5 align-items-center">
               <div class="col-md-6" id="map" style="width:100%;height:400px;"></div>
               <!-- <img class="card-img-top mb-5 mb-md-0" src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg" alt="..." /> -->
               <div class="col-md-6" style="width:100%; padding:0;">
               	   <div class="d-flex" style="width:100%; margin:10px 0; padding:0;">
                       <input id="content" class="form-control text-center me-3" type="text" value=""/>
                       <button id="searchBtn" class="btn btn-outline-dark flex-shrink-0" type="button">                           <!-- <i class="bi-cart-fill me-1"></i> -->
                           검색
                       </button>
                   </div>
                   <div class="small mb-1">SKU: BST-498</div>
                   <h1 class="display-5 fw-bolder">Shop item template</h1>
                   <div class="fs-5 mb-5">
                       <span class="text-decoration-line-through">$45.00</span>
                       <span>$40.00</span>
                   </div>
                   <p class="lead">Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium at dolorem quidem modi. Nam sequi consequatur obcaecati excepturi alias magni, accusamus eius blanditiis delectus ipsam minima ea iste laborum vero?</p>
                   
               </div>
           </div>
       </div>
   </section>
   <!-- Related items section-->
   <section class="py-5 bg-light">
       <div class="container px-4 px-lg-5 mt-5">
           <h2 class="fw-bolder mb-4">Related products</h2>
           <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
               <div class="col mb-5">
                   <div class="card h-100">
                       <!-- Product image-->
                       <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                       <!-- Product details-->
                       <div class="card-body p-4">
                           <div class="text-center">
                               <!-- Product name-->
                               <h5 class="fw-bolder">Fancy Product</h5>
                               <!-- Product price-->
                               $40.00 - $80.00
                           </div>
                       </div>
                       <!-- Product actions-->
                       <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                           <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                       </div>
                   </div>
               </div>
               <div class="col mb-5">
                   <div class="card h-100">
                       <!-- Sale badge-->
                       <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                       <!-- Product image-->
                       <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                       <!-- Product details-->
                       <div class="card-body p-4">
                           <div class="text-center">
                               <!-- Product name-->
                               <h5 class="fw-bolder">Special Item</h5>
                               <!-- Product reviews-->
                               <div class="d-flex justify-content-center small text-warning mb-2">
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                               </div>
                               <!-- Product price-->
                               <span class="text-muted text-decoration-line-through">$20.00</span>
                               $18.00
                           </div>
                       </div>
                       <!-- Product actions-->
                       <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                           <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                       </div>
                   </div>
               </div>
               <div class="col mb-5">
                   <div class="card h-100">
                       <!-- Sale badge-->
                       <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                       <!-- Product image-->
                       <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                       <!-- Product details-->
                       <div class="card-body p-4">
                           <div class="text-center">
                               <!-- Product name-->
                               <h5 class="fw-bolder">Sale Item</h5>
                               <!-- Product price-->
                               <span class="text-muted text-decoration-line-through">$50.00</span>
                               $25.00
                           </div>
                       </div>
                       <!-- Product actions-->
                       <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                           <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                       </div>
                   </div>
               </div>
               <div class="col mb-5">
                   <div class="card h-100">
                       <!-- Product image-->
                       <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                       <!-- Product details-->
                       <div class="card-body p-4">
                           <div class="text-center">
                               <!-- Product name-->
                               <h5 class="fw-bolder">Popular Item</h5>
                               <!-- Product reviews-->
                               <div class="d-flex justify-content-center small text-warning mb-2">
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                                   <div class="bi-star-fill"></div>
                               </div>
                               <!-- Product price-->
                               $40.00
                           </div>
                       </div>
                       <!-- Product actions-->
                       <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                           <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                       </div>
                   </div>
               </div>
           </div>
       </div>
   </section>
  <%@ include file="/WEB-INF/views/layout/footer.jsp" %>
   
</body>
</html>