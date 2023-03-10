<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<%@ include file="../include/header.jsp" %>
<style>
.promotion-wrap .card{
    margin: 0 auto;
}
</style>
	<section>
        <div class="container clearfix">
        	<hr>
            <h2 class="text-center mb-2 mt-2">프로모션 리스트</h2>            
            <div class="promotion-wrap">
                <hr>
                <div class="input-group mb-3">
				  <label class="input-group-text" for="hotelCode">지점선택</label>
				  <select class="form-select" id="hotelCode" name="hotelCode">
				    <option value="none" ${ param.hotelCode == "none" ? "selected" : "" }>전체</option>
				    <option value="10" ${ param.hotelCode == "10" ? "selected" : "" }>서울</option>
				    <option value="20" ${ param.hotelCode == "20" ? "selected" : "" }>부산</option>
				    <option value="30" ${ param.hotelCode == "30" ? "selected" : "" }>제주</option>
				  </select>
				  <span class="input-group-text">시작날짜</span>
                  <input type="date" aria-label="startDate" class="form-control" id="startDate" name="startDate" value="${ param.startDate }">
                  <span class="input-group-text">마침날짜</span>
                  <input type="date" aria-label="endDate" class="form-control" id="endDate" name="endDate" readonly>
				  <button id="listBtn" class="btn btn-outline-secondary" type="button">검색</button>
				</div>
                <!-- 프로모션 리스트 시작 지점 -->
                <c:forEach items="${ promotionList }" var="list">
                	<%-- <span id="promotionCode">${ list.promotionCode }</span> --%>
	                <div id="${ list.promotionCode }" class="card mb-3" style="max-width: 800px;">
	                    <div class="row g-0">
	                      <div class="col-md-4">
	                      	<div class="img-wrapper">
	                        	<img src="${pageContext.request.contextPath}/promotion/display?fileLocation=${ list.fileLocation }&fileName=${ list.fileName }" class="img-fluid rounded-start" alt="...">
	                        </div>
	                      </div>
	                      <div class="col-md-8">
	                        <div class="card-body clearfix">
	                          <h5 class="card-title">${ list.promotionName }</h5>
	                          <p class="card-text">${ list.promotionContent }</p>
	                          <span class="card-date"><fmt:formatDate value="${ list.startDate }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${ list.endDate }" pattern="yyyy-MM-dd"/></span><br>	                          
	                          <strong class="card-price"><fmt:formatNumber value="${ list.promotionPrice }" currencyCode="KO" />원</strong>
	                          <input type="hidden" class="geonwookPrice" value="${ list.promotionPrice }">	                          
	                          <button type="button" class="btn btn-primary modalBtn float-end" data-bs-toggle="modal" data-bs-target="#detailModal" data-promotion-code="${ list.promotionCode }">
                            	상세보기
                         	  </button>
	                        </div>
	                      </div>
	                    </div>
	                </div>
                </c:forEach>
                <!-- 프로모션 리스트 끝 지점 -->
            </div>
            <%-- 관리자로 로그인 했을때 보이게 하면 됩니다 --%>
            <c:if test="${ admin == true }">
            	<button type="button" class="btn btn-secondary float-end" onclick="location.href='${ pageContext.request.contextPath }/promotion/insert'">프로모션 등록</button>            
            </c:if>
        </div>
    </section>
    
    <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg"> <!-- modal 크기 조절 -->
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="detailModalLabel">프로모션 상세보기</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">              
                <div class="container-fluid">
                    <div class="p-3 mt-3" style="background-color: #eee; margin: 0 auto;">
                        <div class="mb-3 clearfix">
                            <div class="img-wrapper">
                                <img src="" class="img-fluid rounded-start" alt="...">                                
                            </div>
                            <span id="modalDate" class="float-start">dummy</span><span id="modalPrice" class="float-end">dummy</span>
                        </div>
                        <hr>
                        <div class="mb-3">
                            <strong id="modalName">dummy</strong>
                        </div>
                        <div class="mb-3">                                
                            <textarea class="form-control" id="modalContent" rows="3" style="resize: none;" disabled>dummy</textarea>
                        </div>                      
                    </div>
                </div>              
            </div>
            <div class="modal-footer">
            	<form id="menuListForm" action="#" method="get">
            		<input id="promotionCodeData" name="promotionCodeData" type="hidden">            		                  	
                  	<input type="hidden" name="capacity" value="2">
                  	<input type="hidden" name="category" value="hotels">
                  	<input type="hidden" name="daterange">
                  	<input type="hidden" name="price" >
            		<c:if test="${ admin == true }">
		                <!-- 관리자 로그인시에만 보이게 끔 c:if 사용 -->
		                <button id="updateBtn" type="button" class="btn btn-success">수정하기</button>
		                <button id="deleteBtn" type="button" class="btn btn-danger">삭제하기</button>
		                <!-- 관리자 로그인시에만 보이게 끔 c:if 사용 -->
	                </c:if>
	                <button id="resvBtn" type="button" class="btn btn-dark">예약하기</button>	                
	           </form>
            </div>
          </div>
        </div>
    </div>
    
    <script>
    
    	$(document).ready(function() {
    		
    		let paramPromotionCode = '${param.promotionCode}';
    		
    		$('.modalBtn').click(function() {
    			
    			// 프로모션 값 가지고 오기 + id 선택자까지
    			let promotionCode = '#' + $(this).data('promotionCode');
    			$('#promotionCodeData').val($(this).data('promotionCode'));
    			
    			if(paramPromotionCode !== '') {
    				promotionCode = '#' + '${param.promotionCode}';
    				$('#promotionCodeData').val('${param.promotionCode}');
    			}
    			
    			// 모달안에 값을 넣어주자
    			$('.modal-body .img-wrapper img').attr('src', $(promotionCode + ' .img-wrapper img').attr('src'));
    			$('#modalName').text($(promotionCode + ' .card-body .card-title').html());
    			$('#modalDate').text($(promotionCode + ' .card-body .card-date').text());
    			$('#modalContent').val($(promotionCode + ' .card-body .card-text').html());
    			$('#modalPrice').text($(promotionCode + ' .card-body .card-price').html());
    			$('input[name="price"]').val($(this).prev().val());
    			
    			$('input[name="daterange"]').val($('#startDate').val() + ' / ' + $('#endDate').val());
    			
    			paramPromotionCode = '';
    			
    		});
    		
    		if(paramPromotionCode !== '') {
    			$('.modalBtn').click();
    		}
    		
    		$('#updateBtn').click(function() {   			
    			const promotionCode = $('#promotionCodeData').val();
    			$(this).parent().attr('action', '${pageContext.request.contextPath}/promotion/update');
    			$(this).parent().submit();    			
    		});
    		
    		$('#deleteBtn').click(function() {    			
    			if(confirm('정말로 삭제하시겠습니까?')) {
    				const promotionCode = $('#promotionCodeData').val();
    				$(this).parent().attr('action', '${pageContext.request.contextPath}/promotion/delete');
    				$(this).parent().attr('method', 'post');
        			$(this).parent().submit();
    			} else {
    				return;
    			}
    			    			
    		});
    		
    		$('#listBtn').click(function(){
    			
    			if(($('#startDate').val() === '') || ($('#endDate').val() === '')) {
    				alert('날짜 선택을 전부 진행해주세요!');
    				return;
    			}
    			
    			location.href='${pageContext.request.contextPath}/promotion/list?hotelCode=' + $('#hotelCode').val() + '&startDate=' + $('#startDate').val() + '&endDate=' + $('#endDate').val();
    		});
    		
    		$('#resvBtn').click(function() {
    			
    			$('#menuListForm').attr('method', 'post');
    			$('#menuListForm').attr('action', '${pageContext.request.contextPath}/promotion/payment');
    			$('#menuListForm').submit();
    			
    		});
    		
    		
    		$('#startDate').change(function() {    			
    			const now = new Date();
    			const startDate = new Date($('#startDate').val());
    			
    			$('#endDate').val(getNextDay($('#startDate').val()));
    			
    			if(startDate < now) {
    				alert('오늘 날짜보다 과거로 돌아갈 수 없습니다.');
    				$('#startDate').val(getDate(false));
    				$('#endDate').val(getNextDay($('#startDate').val()));
    				return;
    			}
			});
    		
    		if('${param.startDate}' !== '') {
    			$('#startDate').val('${param.startDate}');
    		} else {
    			$('#startDate').val(getDate(false));
    		}
    		
    		
    		$('#endDate').val(getNextDay($('#startDate').val()));
    		
    		
    		// 오늘 날짜와 그 다음 날짜를 input type이 date인 값에 맞게 가져옴
    		// false시 오늘 날짜 / true시 내일 날짜
      	  	function getDate(isNextDay) {
      		  	const date = new Date();
      		  	
      		  	if(isNextDay) {
      		  		date.setDate(date.getDate() + 1);
      		  	}
      		  
      		  	let year = String(date.getFullYear());
                let month = String(date.getMonth() + 1);
                let day = String(date.getDate());

                if(month.length === 1) {
                  month = '0' + month;
                }

                if(day.length === 1) {
                  day = '0' + day;
                }         
                
                return year + '-' + month + '-' + day;
      	  	}
    		
    		function getNextDay(dateData) {
    			const date = new Date(dateData);
    			
    			date.setDate(date.getDate() + 1);
    			
      		  	let year = String(date.getFullYear());
                let month = String(date.getMonth() + 1);
                let day = String(date.getDate());

                if(month.length === 1) {
                  month = '0' + month;
                }

                if(day.length === 1) {
                  day = '0' + day;
                }         
                
                return year + '-' + month + '-' + day;
    		}
    		
    	}); // end jQuery
    	
    </script>
<%@ include file="../include/footer.jsp" %>