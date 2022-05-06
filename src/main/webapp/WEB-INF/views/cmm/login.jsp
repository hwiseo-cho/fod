<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<!DOCTYPE html>
<html>

<script>

	$(function(){
		
		$('#loginBtn').on('click',function() {
			var ID  = $('#ID').val();
			var PWD = $('#PWD').val();
			
			if(ID == null || ID == '') {
				alert('아이디를 입력해주세요.');
				return;
			}
			if(PWD == null || PWD == '') {
				alert('비밀번호를 입력해주세요.');
				return;
			}
			
			var inParam = {};
			
			inParam.ID = ID;
			inParam.PWD = PWD;
			console.log(inParam);
			$.ajax({
				type: "POST", 
				url:"${contextPath}/cust/login.do",
				data:inParam,
				contentType: "application/json; charset=UTF-8", 
				success : function(result){
					console.log(result);
				},
				error : function(e){
					console.log(e);
				}
			});
		});
		
		
		$('#signUpBtn').on('click',function() {
			
		});
		
		$('#findIdBtn').on('click',function() {
			
		});
		
		$('#findPwdBtn').on('click',function() {
			
		});
		
	});

</script>

<style>
	.loginForm>div>input{text-align:left !important;}
	.loginForm_footer{text-align:center; color:gray; font-size:12px; padding-bottom: 24px;}
	.loginForm_footer>span{margin:0px 5px; cursor:pointer;}
	.login_btn{width:100%; background-color: rgba(var(--bs-dark-rgb), var(--bs-bg-opacity)) !important; color:#fff;}
</style>
<body>
	<!-- Related items section-->
   <section class="py-5 bg-light">
       <div class="container px-4 px-lg-5 mt-5">
           <h2 class="fw-bolder mb-4" style="text-align:center;">Login</h2>
           <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
               <div class="col mb-5" style="width:100%; max-width:500px;">
                   <div class="card h-100">
                       <!-- Product details-->
                       <div class="card-body p-4 loginForm">
                           <div class="text-center">
                               <!-- <h5 class="fw-bolder">Fancy Product</h5> -->
                               <input id="ID" class="form-control text-center me-3" type="text" placeholder="아이디" value=""/>
                               <input id="PWD" class="form-control text-center me-3" type="password" placeholder="비밀번호" value=""/>
                           </div>
                       </div> 
                       <!-- Product actions-->
                       <div class="card-footer p-4 pt-0 border-top-0 bg-transparent" style="width:100%;">
                           <div class="text-center"><div class="btn btn-outline-dark mt-auto login_btn" id="loginBtn">로그인</div></div>
                       </div>
                       <div class="loginForm_footer">
	                       <span id="signUpBtn">회원가입</span>
	                       <span>|</span>
	                       <span id="findIdBtn">아이디 찾기</span>
	                       <span>|</span>
	                       <span id="findPwdBtn">비밀번호 찾기</span>
                       </div>
                   </div>
               </div>
           </div>
       </div>
   </section>
	
	
	<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>