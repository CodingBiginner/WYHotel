<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ include file="../include/header.jsp" %>


    <style>
        /* reservations page css */
        a {
            color: inherit;
            text-decoration: none;
        }

        .reservations{
            margin: 50px auto;
            
        }
        
        .resv-select{
            text-align: center;
            border: none;
        }

        .resv-select li {
            
            height: 50px;
            line-height: 50px;
            background: #ccc;
            border-bottom: none;
        }

        #pills-tab li a {
            border: 1px solid black;
            color: #8c8c8c;
            display: block;
            width: 100%;
            height: 100%;
            line-height: 30px;
            border-radius: 0px;
        }

        #pills-tab .active {
            background-color: white;
            color: #000;
            border-radius: 0px;
            border-bottom: none;
        }

        .tab-content .active {color: black;}

        .date-inp {
            width: 20%;
            display: inline;
            border: 1px solid black;
            text-align: center;
        }

        .hotel-select {
            width: 20%;
            display: inline;
            border: 1px solid black;
            text-align: center;
        }

        .date-search-form{
            background: #f0f0f0;
            width: 100%;
            padding: 10px;
            text-align: center;
        }

        .date-search-form .btn {
            background: white;
            display: inline;
            width: 10%;
            border: 1px solid black;
            border-radius: 5px;
        }

        .reservation-title {
            margin-top: 30px;
            border-bottom: 1px solid #c8c8c8;
            padding-bottom: 20px;
        }

        .my-reservations-table {
            margin-top: 20px;
            text-align: center;
            width: 100%;
            
        }

        .my-reservations-table thead th {
            font-weight: 400;
            padding-bottom: 5px;
        }

        .my-reservations-table tbody {
            font-size: 0.8em;
            padding-bottom: 5px;
        }

        .my-reservations-table tbody tr:hover {
            cursor: pointer;
            transform: scale(1.01);
            transition: 0.5s;
        }



        /*reservation modal*/
        #reservationModal .modal-content {
            border-radius: 20px;
        }

        .reservation-modal-title {
            text-align: center;
            margin: 0 auto;
            padding: 20px;
            font-weight: 400;
        }

        #modifyReservation .reservation-modify-table {
            margin: 0 auto;
        }

        #modifyReservation .reservation-modify-table tr td {
            padding: 15px 0;
        }

        #modifyReservation .reservation-modify-table strong {
            padding-left: 30px;
            box-sizing: border-box;
        }

        #modifyReservation input, #modifyReservation select {
            width: 100%;
        }

        #reservationModal .btn-close {
            position: absolute;
            top: 40px;
            right: 40px;
        }

        #modifyBtn, #updateBtn {
            width: 50%;
            display: block;
            margin: 10px auto;
        }       
        
        footer {
	        position: fixed;
	    	bottom: 0;
	    	width: 100%;
		}

    </style>

    <!-- 메인영역 각자 할꺼 여기서 부터 적으세용 -->
     <section>

        <div class="container">

            <div class="row">

                <div class="col-sm-12 col-md-10 col-lg-9 reservations">

                    <ul class="nav nav-pills mb-3 resv-select" id="pills-tab" role="tablist">
                        <li class="nav-item col-sm-12 col-md-6" role="presentation">
                          <a class="nav-link active" id="pills-hotel-tab" data-bs-toggle="pill" data-bs-target="#reservationsHotel" type="button" role="tab" aria-controls="pills-hotel" aria-selected="true">HOTEL</a>
                        </li>
                        <li class="nav-item col-sm-12 col-md-6" role="presentation">
                          <a class="nav-link" id="pills-dining-tab" data-bs-toggle="pill" data-bs-target="#reservationsDining" type="button" role="tab" aria-controls="pills-dining" aria-selected="false">DINE &amp; DRINKS</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        
                        <!--hotel toggle begin-->
                        <div class="tab-pane fade show active" id="reservationsHotel" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">    
                            <form action="#" method="post" id="resvCheck">
                                <p class="date-search-form"> 
                                    <b class="paragraph-strong">기간 검색</b> &ensp;&ensp; 
                                    <input type="date" class="form-control date-inp" id="startDate"> &ensp; - &ensp; 
                                    <input type="date" class="form-control date-inp" id="endDate"> &ensp;
                                    <select name="hotel" class="form-control hotel-select" id="hotelSelect">
                                        <option value="entire">전체</option>
                                        <option value="seoul">WY호텔 서울</option>
                                        <option value="busan">WY호텔 부산</option>
                                        <option value="jeju">WY호텔 제주</option>
                                    </select> &ensp;&ensp;
                                    <button type="button" class="btn form-control">조회</button>
                                </p>
                            </form>

                            <h4 class="reservation-title">내 호텔 예약정보</h4>

                            <table class="my-reservations-table hotel-reservations">
                                <thead>
                                    <tr>
                                        <th class="col-md-2">예약번호</th>
                                        <th class="col-md-2">예약지점</th>
                                        <th class="col-md-2">예약객실</th>
                                        <th class="col-md-1">인원</th>
                                        <th class="col-md-1">투숙일</th>
                                        <th class="col-md-2">체크인</th>
                                        <th class="col-md-2">체크아웃</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr data-resv-num="221220swsum1001">
                                        <td>221220slsum1001</td>
                                        <td>WY호텔 서울지점</td>
                                        <td>Suite</td>
                                        <td>1</td>
                                        <td>2박</td>
                                        <td>2022-12-23</td>
                                        <td>2022-12-25</td>
                                    </tr>
                                    <tr data-resv-num="221200bnbdm1001">
                                        <td>221220slsum1001</td>
                                        <td>WY호텔 부산지점</td>
                                        <td>Business Delux</td>
                                        <td>1</td>
                                        <td>2박</td>
                                        <td>2022-12-26</td>
                                        <td>2022-12-27</td>
                                    </tr>
                                </tbody>

                            </table>


                        </div>
                        <!--hotel toggle end-->

                        <!--dining toggle begin-->
                        <div class="tab-pane fade" id="reservationsDining" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
                            <form action="#" method="post" id="diningResvCheck">
                                <p class="date-search-form"> 
                                    <b class="paragraph-strong">기간 검색</b> &ensp;&ensp; 
                                    <input type="date" class="form-control date-inp" id="startDate"> &ensp; - &ensp; 
                                    <input type="date" class="form-control date-inp" id="endDate"> &ensp;
                                    <select name="hotel" class="form-control hotel-select" id="hotelSelect">
                                        <option value="entire">전체</option>
                                        <option value="seoul">WY호텔 서울</option>
                                        <option value="busan">WY호텔 부산</option>
                                        <option value="jeju">WY호텔 제주</option>
                                    </select> &ensp;&ensp;
                                    <button type="button" class="btn form-control">조회</button>
                                </p>
                            </form>

                            <h4 class="reservation-title">내 다이닝 예약정보</h4>

                            <table class="my-reservations-table dining-reservations">
                                <thead>
                                    <tr>
                                        <th class="col-md-2">예약번호</th>
                                        <th class="col-md-3">예약지점</th>
                                        <th class="col-md-3">다이닝 선택</th>
                                        <th class="col-md-1">인원</th>
                                        <th class="col-md-2">예약일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr data-resv-num="221220s3m1001">
                                        <td>221220s3m1001</td>
                                        <td>WY호텔 서울지점</td>
                                        <td>존맛탱 다이닝</td>
                                        <td>4</td>
                                        <td>2022-12-25</td>
                                    </tr>
                                    
                                </tbody>

                            </table>
                        </div>
                        <!--dining toggle end-->

                    </div> <!--end tab contents-->
                    

                </div>

            </div>

        </div>



    </section>
    
    <%@ include file="./reservationModal.jsp" %>    
    
    <script>

        $(document).ready(function(){

            /**
             * 호텔 예약버튼
            */
            $('.hotel-reservations tbody').on('click', 'tr', function(e){
                const resvNum = $(this).data('resvNum');
                console.log(resvNum);
                
                $('.reservation-modal-title').text('호텔 예약 상세');
                $('.hotelForm #reservationCode').val(resvNum);
                $('.hotelForm').attr('hidden', false);
                $('.diningForm').attr('hidden', true);
                $('#reservationModal').modal('show');

            }); // 호텔 예약확인 버튼처리 끝

            /**
             * 다이닝 예약버튼
            */
            $('.dining-reservations tbody').on('click', 'tr', function(e){
                const resvNum = $(this).data('resvNum');
                console.log(resvNum);
                
                $('.reservation-modal-title').text('다이닝 예약 상세');
                $('.diningForm #reservationCode').val(resvNum);
                $('.hotelForm').attr('hidden', true);
                $('.diningForm').attr('hidden', false);
                $('#reservationModal').modal('show');

            });// 다이닝 예약확인 버튼처리 끝

            // 예약변경버튼
            $('#reservationModal').on('click', '#modifyBtn', function(){
                const trs = [...$(this)[0].parentNode.children[0].children[0].children];
                trs.forEach(tr => {
                    const $inp = tr.children[1].firstElementChild;
                    if ($inp.getAttribute('id') !== 'reservationCode' && $inp.getAttribute('id') !== 'hotelCode')
                        $inp.removeAttribute('readonly');
                    if ($inp.matches('select') && $inp.getAttribute('id') !== 'hotelCode') {
                        $inp.removeAttribute('onFocus');
                        $inp.removeAttribute('onChange');
                    }
                });
                $(this).text('변경사항 저장');
                $(this).attr('id', 'updateBtn');
            }); //예약변경버튼 종료

            // 변경사항 저장 버튼 클릭이벤트
            $('#reservationModal').on('click', '#updateBtn', function(){
                const trs = [...$(this)[0].parentNode.children[0].children[0].children];
                trs.forEach(tr => {
                    const $inp = tr.children[1].firstElementChild;
                    if ($inp.getAttribute('id') !== 'reservationCode' && $inp.getAttribute('id') !== 'hotelCode')
                        $inp.setAttribute('readonly', true);
                    if ($inp.matches('select') && $inp.getAttribute('id') !== 'hotelCode') {
                        $inp.setAttribute('onFocus', 'this.initialSelect = this.selectedIndex;');
                        $inp.setAttribute('onChange', 'this.selectedIndex = this.initialSelect;');
                    }
                });

                $(this).text('예약 변경하기');
                $(this).attr('id', 'modifyBtn');
            });
            
        });
        
    </script>
    
    <%@ include file="../include/footer.jsp" %>
    