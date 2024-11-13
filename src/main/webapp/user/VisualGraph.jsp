<%@ page import="com.air.dao.BoardDTO"%>
<%@ page import="com.air.dao.BoardDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/Include/Header.jsp" />

<div class="visual_wrap">
	<div class="header_txt">
		<h1>먼지예보 시각화자료</h1>
		<h2>대기환경기준물질과 다양한 데이터와 상관관계를 확인하세요.</h2>
	</div>

	<div class="visual_cont">
		<div class="visTab">
			<ul>
				<li class="btn_vchart01 on">강수량</li>
				<li class="btn_vchart02">기온</li>
				<li class="btn_vchart03">풍속</li>
				<li class="btn_vchart04">습도</li>
				<li class="btn_vchart05">대기압</li>
			</ul>
		</div>
		<div class="visChart_wrap">
			<div class="visChart visChart01">
				<div class="visChartImg"><img src="${pageContext.request.contextPath}/images/visChart01.png" alt="강수량 그래프" /></div>
				<span>강수량에 따른 미세먼지 수치 결과</span>
				<p>강수량과 미세먼지 농도 사이의 상관관계는 대체로 강수가 미세먼지를 대기에서 제거하는 데 도움이 된다는 점에서 음의 상관관계(negative correlation)를 가진다고 볼 수 있습니다.
				이는 강수 과정에서 비 또는 눈이 대기 중의 미세먼지와 다른 오염물질을 씻어내리기 때문입니다.
				강수량이 많을수록 대기 중 미세먼지가 물방울에 흡수되어 지면으로 가라앉는 '세정 효과(Washout effect)'가 더 크게 나타납니다.</p>
			</div>
			
			<div class="visChart visChart02">
				<div class="visChartImg"><img src="${pageContext.request.contextPath}/images/visChart02.png" alt="기온 그래프" /></div>
				<span>기온에 따른 미세먼지 수치 결과</span>
				<p>기온이 낮거나 높을수록 미세먼지가 크게 줄어들고 8도~20도(중간온도) 일때 가장 높게 나타났습니다. <br />
					1. 대기 순환 : 더운 여름철, 대기 상층으로의 열기 이동이 활발해져 대기 순환이 촉진될 수 있습니다. 이는 미세먼지와 같은 오염물질이 대기 중으로 흩어지게 하여 농도를 낮출 수 있습니다. <br />
					2. 또한 기온이 영하로 떨어지면 공기 중의 수분이 얼어 붙어 미세먼지 입자들을 무겁게 만들어 지표로 가라앉게 하는 효과가 있습니다. <br />
					3. 난방 사용의 감소: 매우 추운 날씨에는 사람들이 실내에 머무르는 시간이 늘어납니다. 이는 외부에서의 활동 감소와 연관이 있으며, 결과적으로 자동차나 공장 등에서 발생하는 미세먼지의 양도 감소할 수 있습니다.</p>
			</div>
			
			<div class="visChart visChart03">
				<div class="visChartImg"><img src="${pageContext.request.contextPath}/images/visChart03.png" alt="풍속 그래프" /></div>
				<span>풍속에 따른 미세먼지 수치 결과</span>
				<p>풍속이 빨라질 때 미세먼지 감소: 풍속이 증가하면 대기 중의 미세먼지가 더 원활하게 분산되고, 이동하여 농도가 낮아집니다. 빠른 바람은 지상 근처의 미세먼지를 상층 대기로 옮겨 대기 중에 더 넓게 퍼지게 하며,
				 이는 미세먼지 농도 감소로 이어집니다. 또한, 빠른 풍속은 미세먼지가 다른 지역으로 이동하게 해 지역적으로 미세먼지 농도를 낮출 수 있습니다.
				풍속이 느려질 때 미세먼지 증가: 반대로 풍속이 느려지면 대기 중의 미세먼지가 적절히 분산되지 못하고 한 곳에 머물게 됩니다. 이는 해당 지역에서 미세먼지 농도가 증가하는 결과를 초래할 수 있습니다. 특히, 대기가 안정되고 바람이 거의 불지 않는 날에는 지상 근처의 미세먼지가 제거되지 않고 농도가 증가할 가능성이 높습니다.</p>
			</div>
			
			<div class="visChart visChart04">
				<div class="visChartImg"><img src="${pageContext.request.contextPath}/images/visChart04.png" alt="습도 그래프" /></div>
				<span>습도에 따른 미세먼지 수치 결과</span>
				<p>뚜렷한 경향성 없지만, 습도 20% 미만일때 미세먼지 농도가 낮음. <br />
				입자 분산:  습도가 낮아지면 미세먼지 입자들이 서로 결합하지 않고 더 작은 상태로 남아 있게 됩니다. 이는 바람에 의해 더 쉽게 분산될 수 있으며, 결과적으로 미세먼지 농도가 감소할 수 있습니다.<br />
				안개와 대기 안정화:  높은 습도는 안개를 형성할 수 있으며, 이는 대기를 안정화시키는 역할을 합니다. 안정된 대기에서는 미세먼지가 지면 근처에 머무르기 쉽고, 바람이 없으면 농도가 높아질 수 있습니다.<br />
				습도는 미세먼지 농도에 여러 가지 방식으로 영향을 미치며, 이는 다른 기상 조건과의 상호작용에 따라 복합적으로 나타납니다. </p>
			</div>
			
			<div class="visChart visChart05">
				<div class="visChartImg"><img src="${pageContext.request.contextPath}/images/visChart05.png" alt="대기압 그래프" /></div>
				<span>대기압에 따른 미세먼지 수치 결과</span>
				<p>
고압 상태일 때, 대기가 안정되고 정체되는 경향이 있습니다. 이러한 조건에서는 공기가 하강하며, 이 과정에서 공기 중의 미세먼지가 지면 가까이 머물게 되어 미세먼지 농도가 증가할 수 있습니다.
고압 지역은 풍속이 약해지는 경향이 있으며, 이는 미세먼지가 대기 중에 머무르게 하고 충분히 퍼지지 못하게 합니다. 결과적으로, 미세먼지 농도가 높아질 수 있습니다.<br />

저압 상태일 때는 대기가 불안정해지고, 공기가 상승하는 경향이 있습니다. 이로 인해 미세먼지가 상층으로 이동하고, 대기 중에 더 잘 퍼질 수 있게 되어 미세먼지 농도가 감소할 수 있습니다.
저압 지역은 풍속이 강해지는 경향이 있으며, 이는 미세먼지의 이동과 분산을 촉진합니다. 이는 미세먼지 농도를 낮출 수 있는 요인입니다.</p>
			</div>
		</div>
		

		
		

		




		
		
	</div><!-- //visual_cont -->
</div><!-- //visual_wrap -->


<jsp:include page="/Include/Footer.jsp" />