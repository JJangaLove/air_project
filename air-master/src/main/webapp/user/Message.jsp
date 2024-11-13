<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject"%>
<jsp:include page="/Include/Header.jsp" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
// 서비스 신청 AJAX
$(document).ready(function() {
	  $("#sendVer").on("click", function(e) {
	    e.preventDefault(); // 기본 이벤트 동작 방지
	    alert("인증번호 발송이 완료되었습니다.")
	    var phoneNumber = $("#phoneNumber").val();
	    console.log(phoneNumber);
	    getVerificationCode(phoneNumber, function(certification) {
	      // 다른 함수에서 certification 변수 사용
	      $("#sendCer").click(function(e) {
	        e.preventDefault();
	        var certi = $("#certi").val();
	        console.log("사용자가 쓴 인증번호 : " + certi);
	        if (certification != null && certi != null && certification === certi) {
	          alert("인증에 성공하셨습니다.");
	          $("#hidd").val("success");
	          // $("#applyForm").submit();
	        } else {
	          alert("인증번호가 일치하지 않습니다.");
	        }
	      });
	    });
	  });
	});

	function getVerificationCode(phoneNumber, callback) {
	  $.ajax({
	    url: "../phone",
	    type: "post",
	    data: { phoneNumber: phoneNumber },
	    dataType: 'json',
	    success: function(resData) {
	      console.log("ajax으로 받아온 인증번호 : " + resData.certification);
	      callback(resData.certification);
	    },
	    error: function(request, status, error) {
	      alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	    }
	  });
	}
	
	// 서비스 해지 AJAX
	$(document).ready(function() {
		  $("#sendVer1").on("click", function(e) {
		    e.preventDefault(); // 기본 이벤트 동작 방지
		    alert("인증번호 발송이 완료되었습니다.")
		    var phoneNumber = $("#phoneNumber1").val();
		    getVerificationCode(phoneNumber, function(certification) {
		      // 다른 함수에서 certification 변수 사용
		      $("#sendCer1").click(function(e) {
		        e.preventDefault();
		        var certi1 = $("#certi1").val();
		        console.log("사용자가 쓴 인증번호 : " + certi1);
		        if (certification != null && certi1 != null && certification === certi1) {
		          alert("인증에 성공하셨습니다.");
		          $("#hidd1").val("success");
		          // $("#applyForm").submit();
		        } else {
		          alert("인증번호가 일치하지 않습니다.");
		        }
		      });
		    });
		  });
		});

		function getVerificationCode(phoneNumber, callback) {
		  $.ajax({
		    url: "../phone",
		    type: "post",
		    data: { phoneNumber: phoneNumber },
		    dataType: 'json',
		    success: function(resData) {
		      console.log("ajax으로 받아온 인증번호 : " + resData.certification);
		      callback(resData.certification);
		    },
		    error: function(request, status, error) {
		      alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		    }
		  });
		}

</script>

<div class="message_wrap">
	<div class="header_txt">
		<h1>문자서비스</h1>
		<h2>
			미세먼지 예보 등급이 <span class="red">"나쁨"</span> 이상일 경우에만 서비스가 제공됩니다
		</h2>
	</div>

	<div class="tab_wrap">
		<ul>
			<li class="btn_opt on">서비스 신청</li>
			<li class="btn_out">서비스 해지</li>
		</ul>
	</div>

	<div class="message_cont">
		<div class="message_opt">
			<form id="applyForm" action="../member" method="post">
				<table class="type1">
					<colgroup>
						<col width="20%">
						<col width="">
					</colgroup>

					<tbody>
						<tr>
							<th>이름</th>
							<td><input type="text" name="member_name" value=""
								placeholder=""></td>
							<td><input type="hidden" id="hidd" name="hidd" value=""></td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td><input id="phoneNumber" name="member_phone" type="text"
								value="" placeholder="- 제외하고 작성하세요.">
								<button class="phone_send" id="sendVer">인증번호 전송</button></td>
						</tr>
						<tr>
							<th>인증확인</th>
							<td><input id="certi" type="text" value="">
								<button class="phone_check" id="sendCer">인증번호 확인</button></td>

						</tr>
						<tr>
							<th>알림지역</th>
							<td>
								<div class="ipArea">
									<input type="checkbox" id="inputAbode" name="inputAbode"
										value="Y"><label for="inputAbode"> 전체 </label> <input
										type="checkbox" class="area" id="area_1" name="member_area"
										value="서울"><label for="area_1"> 서울 </label> <input
										type="checkbox" class="area" id="area_2" name="member_area"
										value="부산"><label for="area_2"> 부산 </label> <input
										type="checkbox" class="area" id="area_3" name="member_area"
										value="대구"><label for="area_3"> 대구 </label> <input
										type="checkbox" class="area" id="area_4" name="member_area"
										value="인천"><label for="area_4"> 인천 </label> <input
										type="checkbox" class="area" id="area_5" name="member_area"
										value="광주"><label for="area_5"> 광주 </label> <input
										type="checkbox" class="area" id="area_6" name="member_area"
										value="대전"><label for="area_6"> 대전 </label> <input
										type="checkbox" class="area" id="area_7" name="member_area"
										value="울산"><label for="area_7"> 울산 </label> <input
										type="checkbox" class="area" id="area_8" name="member_area"
										value="경기"><label for="area_8"> 경기 </label> <input
										type="checkbox" class="area" id="area_9" name="member_area"
										value="강원"><label for="area_9"> 강원 </label> <br /> <input
										type="checkbox" class="area" id="area_10" name="member_area"
										value="충북"><label for="area_10"> 충북 </label> <input
										type="checkbox" class="area" id="area_11" name="member_area"
										value="충남"><label for="area_11"> 충남 </label> <input
										type="checkbox" class="area" id="area_12" name="member_area"
										value="전북"><label for="area_12"> 전북 </label> <input
										type="checkbox" class="area" id="area_13" name="member_area"
										value="전남"><label for="area_13"> 전남 </label> <input
										type="checkbox" class="area" id="area_14" name="member_area"
										value="경북"><label for="area_14"> 경북 </label> <input
										type="checkbox" class="area" id="area_15" name="member_area"
										value="경남"><label for="area_15"> 경남 </label> <input
										type="checkbox" class="area" id="area_16" name="member_area"
										value="제주"><label for="area_16"> 제주 </label> <input
										type="checkbox" class="area" id="area_17" name="member_area"
										value="세종"><label for="area_17"> 세종 </label>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<span class="add_txt">* 미세먼지 예보 알림서비스는 먼지예보에서 발표하는 예보 정보를 문자로
					알려드리는 서비스입니다.</span>
				<div class="btn_wrap">
					<input type="submit" value="신청완료">
				</div>
			</form>
		</div>
		<!--//message_send-->

		<div class="message_out">
			<form action="../delete" method="post">
				<table class="type1">
					<colgroup>
						<col width="20%">
						<col width="">
					</colgroup>

					<tbody>
						<tr>
							<th>이름</th>
							<td><input type="text" value="" placeholder=""></td>
							<td><input type="hidden" id="hidd1" name="hidd1" value=""></td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td><input id="phoneNumber1" name="member_phone" type="text"
								value="" placeholder="- 제외하고 작성하세요.">
								<button class="phone_send" id="sendVer1">인증번호 전송</button></td>
						</tr>
						<tr>
							<th>인증확인</th>
							<td><input id="certi1" type="text" value="">
								<button class="phone_check" id="sendCer1">인증번호 확인</button></td>
						</tr>
					</tbody>
				</table>
				<span class="add_txt">* 본 서비스는 해지 후 고객님의 정보가 남지 않습니다.</span>
				<div class="btn_wrap">
					<input type="submit" value="신청해지">
				</div>
			</form>
		</div>
		<!--//message_out-->

	</div>

</div>

<jsp:include page="/Include/Footer.jsp" />