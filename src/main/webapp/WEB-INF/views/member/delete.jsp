<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ include file="../include/header.jsp" %>

 <!-- start member_delete -->
 <section>
    <div class="container"> 
      <div class="row">
     <div class="titlebox">
         회원 탈퇴
     </div>
     <div class="row"> 
         <!-- 목록 -->
         <div class="col-3">
             <ul class="list-group col-12">
                 <li class="list-group"><h4>마이페이지</h4></li>
                 <hr>
                 <li class="list-group-item"> <a href="${pageContext.request.contextPath}/member/modify" class="text-secondary">내정보 수정</a></li>
                 <li class="list-group-item"> <a href="${pageContext.request.contextPath}/member/pwModify" class="text-secondary">비밀번호 수정</a></li>
                 <li class="list-group-item"> <a href="${pageContext.request.contextPath}/member/delete" class="text-secondary">회원탈퇴</a></li>
             </ul>
         </div>
         
         <div class="col-lg-1"></div>
         <div class="col-lg-6 align-self-center">
             <form id="loginForm" class="">
                 <div class="input-group mb-3 delete-input">
                     <input type="password" class="form-control" placeholder="비밀번호를 입력하세요." aria-label="Recipient's username" aria-describedby="button-addon2">
                     <button class="btn btn-outline-secondary btn-dark deleteBtn" type="button" id="button-addon2">확인</button>
                 </div>
             </form>
         </div>            
         </div>
     </div>
         </div>
      </div>   
 </section>

    <%@ include file="../include/footer.jsp" %>