<%@page import="com.air.dao.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.air.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/Include/Header.jsp" />

<%
String id = (String) session.getAttribute("loginId");
%>
<script>
	$(document).ready(function() {
		mainNotice(); // 페이지 로드시 공지사항 실행
		sendRequest(0); // 페이지 로드시 미세먼지 나쁨일 때 문자 보냄
		main(); // 페이지 로드시 dust랑 mask 값 가져옴
	});
</script>
<div class="main_cont">
	<!-- 지도 -->
	<div class="mapArea">
		<div class="tab_wrap">
			<ul>
				<li class="btn_today on">오늘 대기정보</li>
				<li class="btn_yes">내일 대기정보</li>
			</ul>
		</div>

		<!--  오늘의 대기정보 지도영역 -->
		<div id="todayMap" style="width: 675px; height: 754px;">
			<jsp:include page="/user/TodayMap.jsp" />
		</div>

		<!-- 내일의 대기정보 지도영역 -->
		<div id="yesMap" style="width: 675px; height: 754px;">
			<jsp:include page="/user/yesMap.jsp" />
		</div>
	</div>
	<!--날씨/지역/공지사항-->
	<div class="mainInfo">
		<ul>
			<!-- 날씨 -->
			<li class="weatherInfo">
				<div class="vis-weather">
					<div class="weatherArea">
						<!-- <h3 class="viewRegion"></h3> -->
						<select id="regionSelect">
							<option value="" selected disabled hidden>광주</option>
							<option value="광주">광주</option>
							<option value="서울">서울</option>
							<option value="인천">인천</option>
							<option value="대구">대구</option>
							<option value="대전">대전</option>
							<option value="세종">세종</option>
							<option value="부산">부산</option>
							<option value="강원">강원도</option>
							<option value="경기">경기도</option>
							<option value="충북">충청북도</option>
							<option value="충남">충청남도</option>
							<option value="전북">전라북도</option>
							<option value="전남">전라남도</option>
							<option value="경남">경상남도</option>
							<option value="경북">경상북도</option>
							<option value="제주">제주도</option>
						</select>
					</div>

					<div class="todayWeather_cont">
						<h3 class="todayWeather"></h3>
						<div class="temp_wrap">
							<h4 class="temp"></h4>
							<span>℃</span>
						</div>
					</div>

					<div class="whDetail">
						<p class="uploadTime"></p>
					</div>

					<ul class="list-group list-group-item weather"
						style="font-weight: 600;">
						<li>
							<p>현재날씨</p> <span class="todayTxt"></span>
						</li>
						<li>
							<p>풍속</p> <span class="wind"></span>
						</li>
						<li>
							<p>강수확률</p> <span class="rainP"></span>
						</li>
						<li>
							<p>습도</p> <span class="hd"></span>
						</li>
					</ul>
				</div>
			</li>
			<li class="legendInfo">
				<div class="legendTab">
					<ul>
						<li class="depth02 active">미세먼지 (PM-10)</li>
						<li class="depth01">초미세먼지 (PM-2.5)</li>
						<li class="depth03">오존 (O₃)</li>
						<li class="depth04">이산화질소 (NO₂)</li>
						<li class="depth05">일산화탄소 (CO)</li>
						<li class="depth06">아황산가스 (SO₂)</li>
					</ul>
				</div> <!--초미세먼지-->
				<div class="depth_cont">
					<ul class="depth02C">
						<!--미세먼지-->
						<li><h5>좋음</h5> <span class="blue"></span>
							<p>(0 ~ 30)</p></li>
						<li><h5>보통</h5> <span class="green"></span>
							<p>(31 ~ 80)</p></li>
						<li><h5>나쁨</h5> <span class="yellow"></span>
							<p>(81 ~ 150)</p></li>
						<li><h5>매우나쁨</h5> <span class="red"></span>
							<p>(151 ~ )</p></li>
					</ul>
					<ul class="depth01C">
						<!--초미세먼지-->
						<li><h5>좋음</h5> <span class="blue"></span>
							<p>(0 ~ 15)</p></li>
						<li><h5>보통</h5> <span class="green"></span>
							<p>(16 ~ 35)</p></li>
						<li><h5>나쁨</h5> <span class="yellow"></span>
							<p>(36 ~ 75)</p></li>
						<li><h5>매우나쁨</h5> <span class="red"></span>
							<p>(76 ~ )</p></li>
					</ul>
					<ul class="depth03C">
						<!--오존-->
						<li><h5>좋음</h5> <span class="blue"></span>
							<p>(0 ~ 0.03)</p></li>
						<li><h5>보통</h5> <span class="green"></span>
							<p>(0.031 ~ 0.09)</p></li>
						<li><h5>나쁨</h5> <span class="yellow"></span>
							<p>(0.091 ~ 0.15)</p></li>
						<li><h5>매우나쁨</h5> <span class="red"></span>
							<p>(0.151 ~ )</p></li>
					</ul>
					<ul class="depth04C">
						<!--이산화질소-->
						<li><h5>좋음</h5> <span class="blue"></span>
							<p>(0 ~ 0.03)</p></li>
						<li><h5>보통</h5> <span class="green"></span>
							<p>(0.031 ~ 0.06)</p></li>
						<li><h5>나쁨</h5> <span class="yellow"></span>
							<p>(0.061 ~ 0.2)</p></li>
						<li><h5>매우나쁨</h5> <span class="red"></span>
							<p>(0.201 ~ )</p></li>
					</ul>
					<ul class="depth05C">
						<!--일산화탄소-->
						<li><h5>좋음</h5> <span class="blue"></span>
							<p>(0 ~ 2)</p></li>
						<li><h5>보통</h5> <span class="green"></span>
							<p>(2.1 ~ 9)</p></li>
						<li><h5>나쁨</h5> <span class="yellow"></span>
							<p>(9.0 ~ 15)</p></li>
						<li><h5>매우나쁨</h5> <span class="red"></span>
							<p>(15.01 ~ )</p></li>
					</ul>
					<ul class="depth06C">
						<!--이황산가스-->
						<li><h5>좋음</h5> <span class="blue"></span>
							<p>(0 ~ 0.02)</p></li>
						<li><h5>보통</h5> <span class="green"></span>
							<p>(0.021 ~ 0.05)</p></li>
						<li><h5>나쁨</h5> <span class="yellow"></span>
							<p>(0.051 ~ 0.15)</p></li>
						<li><h5>매우나쁨</h5> <span class="red"></span>
							<p>(0.151 ~ )</p></li>
					</ul>
				</div>
			</li>
			<li class="areaInfo">
				<div class="livingIndex">
					<div class="tit02">생활지수</div>
					<div>
						<select id="select_area_value" onchange="main()">
							<option value="광주" selected hidden>광주</option>
							<option value="광주">광주</option>
							<option value="서울">서울</option>
							<option value="인천">인천</option>
							<option value="대구">대구</option>
							<option value="대전">대전</option>
							<option value="세종">세종</option>
							<option value="부산">부산</option>
							<option value="강원">강원도</option>
							<option value="경기">경기도</option>
							<option value="충북">충청북도</option>
							<option value="충남">충청남도</option>
							<option value="전북">전라북도</option>
							<option value="전남">전라남도</option>
							<option value="경남">경상남도</option>
							<option value="경북">경상북도</option>
							<option value="제주">제주도</option>
						</select>
					</div>
					<div>
					<ul class="livingCont">
						<li><p>세차 지수</p><div><img src="<%=request.getContextPath()%>/images/living01.png" alt="세차아이콘"/></div><span class="car"></span></li>
						<li><p>마스크 지수</p><div><img src="<%=request.getContextPath()%>/images/living02.png" alt="마스크아이콘"/></div><span class="mask"></span></li>
						<li><p>야외활동 지수</p><div><img src="<%=request.getContextPath()%>/images/living03.png" alt="야외아이콘"/></div><span class="outdoorActivity"></span></li>
						<li><p>환기 지수</p><div><img src="<%=request.getContextPath()%>/images/living04.png" alt="환기아이콘"/></div><span class="ventilation"></span></li>
					</ul>
					</div>
				</div> <!-- 공지사항 미리보기 -->
				<div id="noticeTable">
					<div class="tit02">공지사항</div>
					<div class="noticeBtn">
						<a href="<%=request.getContextPath()%>/user/view.notice">더보기 +</a>
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>


<jsp:include page="/Include/Footer.jsp" />