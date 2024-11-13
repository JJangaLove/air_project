<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.air.dao.PastdbDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.air.dao.PastdbDAO"%>
<jsp:include page="/Include/Header.jsp" />

<div class="monit_wrap">
	<div class="header_txt">
		<h1>먼지예보 모니터링</h1>
		<h2>미세먼지 지역별 월별차트정보를 확인하세요.</h2>
	</div>

	<div class="monitArea_wrap">
		<script>
			let pm10 = [];
			let pm25 = [];
			let so2 = [];
			let co = [];
			let o3 = [];
			let no2 = [];
			let mon = [];

			$(document).ready(function() {
				handleSelectChange(); // 페이지 로드 시 실행
			});

			function handleSelectChange() {
				var select_value = $("#select_value").val();

				if (select_value != null) {
					$
							.ajax({
								url : "../Past",
								type : "post",
								data : {
									select_value : select_value
								},
								dataType : "json",
								//async: false,
								success : function(data) {
									pm10 = [];
									pm25 = [];
									so2 = [];
									co = [];
									o3 = [];
									no2 = [];
									mon = [];
									// 가져온 이벤트 정보를 화면에 표시하는 코드 작성
									console.log("ajax으로 받아온 list : "
											+ data.list);
									for (let i = data.list.length - 12; i < data.list.length; i++) {
										pm10.push(data.list[i].PM10)
										pm25.push(data.list[i].PM25)
										so2.push(data.list[i].SO2)
										co.push(data.list[i].CO)
										o3.push(data.list[i].O3)
										no2.push(data.list[i].NO2)
										mon.push(data.list[i].MONTH + "월")

										console.log("PM10 : "
												+ data.list[i].PM10);
									}
									updateChart();

								},
								error : function(xhr, status, error) {
									console.error('Error fetching events:',
											error);
									console.log("오류다");
								}
							});
				}
			}
		</script>
		<div class="monitSelect">
			<select id="select_value" onchange="handleSelectChange()">
				<option value="광주" selected hidden>광주</option>
				<option value="광주">광주</option>
				<option value="서울">서울</option>
				<option value="인천">인천</option>
				<option value="대구">대구</option>
				<option value="대전">대전</option>
				<option value="세종">세종</option>
				<option value="부산">부산</option>
				<option value="울산">울산</option>
				<option value="강원영동">강원영동</option>
				<option value="강원영서">강원영서</option>
				<option value="경기남부">경기남부</option>
				<option value="경기북부">경기북부</option>
				<option value="충북">충청북도</option>
				<option value="충남">충청남도</option>
				<option value="전북">전라북도</option>
				<option value="전남">전라남도</option>
				<option value="경남">경상남도</option>
				<option value="경북">경상북도</option>
				<option value="제주">제주도</option>
			</select>
		</div>

		<div class="chartCont">
			<div class="chartTab">
				<ul>
					<li class="btn_chart01 on">미세먼지 (PM-10)</li>
					<li class="btn_chart02">초미세먼지 (PM-2.5)</li>
					<li class="btn_chart03">오존 (O₃)</li>
					<li class="btn_chart04">이산화질소 (NO₂)</li>
					<li class="btn_chart05">일산화탄소 (CO)</li>
					<li class="btn_chart06">아황산가스 (SO₂)</li>
				</ul>
			</div>
			<div class="chartWrap">
				<div class="chart01">
					<div class="labelWrap">
						<ul>
							<li><span class="bLabel"></span>
							<p>좋음 (0 ~ 30)</p></li>
							<li><span class="gLabel"></span>
							<p>보통 (31 ~ 80)</p></li>
							<li><span class="yLabel"></span>
							<p>나쁨 (81 ~ 150)</p></li>
							<li><span class="rLabel"></span>
							<p>매우나쁨 (151 ~ )</p></li>
						</ul>
					</div>
					<canvas id="PM10"></canvas>
				</div>
				<div class="chart02">
					<div class="labelWrap">
						<ul>
							<li><span class="bLabel"></span>
							<p>좋음 (0 ~ 15)</p></li>
							<li><span class="gLabel"></span>
							<p>보통 (16 ~ 35)</p></li>
							<li><span class="yLabel"></span>
							<p>나쁨 (36 ~ 75)</p></li>
							<li><span class="rLabel"></span>
							<p>매우나쁨 (76 ~ )</p></li>
						</ul>
					</div>
					<canvas id="PM2.5"></canvas>
				</div>
				<div class="chart03">
					<div class="labelWrap">
						<ul>
							<li><span class="bLabel"></span>
							<p>좋음 (0 ~ 0.03)</p></li>
							<li><span class="gLabel"></span>
							<p>보통 (0.031 ~ 0.09)</p></li>
							<li><span class="yLabel"></span>
							<p>나쁨 (0.091 ~ 0.15)</p></li>
							<li><span class="rLabel"></span>
							<p>매우나쁨 (0.151 ~ )</p></li>
						</ul>
					</div>
					<canvas id="O3"></canvas>
				</div>
				<div class="chart04">
					<div class="labelWrap">
						<ul>
							<li><span class="bLabel"></span>
							<p>좋음 (0 ~ 0.03)</p></li>
							<li><span class="gLabel"></span>
							<p>보통 (0.031 ~ 0.06)</p></li>
							<li><span class="yLabel"></span>
							<p>나쁨 (0.061 ~ 0.2)</p></li>
							<li><span class="rLabel"></span>
							<p>매우나쁨 (0.201 ~ )</p></li>
						</ul>
					</div>
					<canvas id="NO2"></canvas>
				</div>
				<div class="chart05">
					<div class="labelWrap">
						<ul>
							<li><span class="bLabel"></span>
							<p>좋음 (0 ~ 2)</p></li>
							<li><span class="gLabel"></span>
							<p>보통 (2.1 ~ 9)</p></li>
							<li><span class="yLabel"></span>
							<p>나쁨 (9.0 ~ 15)</p></li>
							<li><span class="rLabel"></span>
							<p>매우나쁨 (15.01 ~ )</p></li>
						</ul>
					</div>
					<canvas id="CO"></canvas>
				</div>
				<div class="chart06">
					<div class="labelWrap">
						<ul>
							<li><span class="bLabel"></span>
							<p>좋음 (0 ~ 0.02)</p></li>
							<li><span class="gLabel"></span>
							<p>보통 (0.021 ~ 0.05)</p></li>
							<li><span class="yLabel"></span>
							<p>나쁨 (0.051 ~ 0.15)</p></li>
							<li><span class="rLabel"></span>
							<p>매우나쁨 (0.151 ~ )</p></li>
						</ul>
					</div>
					<canvas id="SO2"></canvas>
				</div>
			</div>
		</div>



		<script>
			// 차트 객체를 저장할 변수
			let pm10Chart, pm25Chart, o3Chart, no2Chart, coChart, so2Chart;

			function updateChart() {
				const labels = mon;

				const pm10Data = {
					labels : labels,
					datasets : [ {
						labels : false,
						data : pm10,
						barThickness : 25,
						backgroundColor : function(context) {
							// context.index로 현재 인덱스에 해당하는 데이터를 가져올 수 있습니다.
							const pm10Value = pm10[context.dataIndex];
							// PM-10 값에 따라 색상을 지정합니다.
							if (pm10Value <= 30) {
								return '#93C9EE'; // 좋음
							} else if (pm10Value <= 80) {
								return '#52BF90'; // 보통
							} else if (pm10Value <= 150) {
								return '#ffc616'; // 나쁨
							} else {
								return '#df0606'; // 매우나쁨
							}
						},
					} ],

				};

				const pm25Data = {
					labels : labels,
					datasets : [ {
						label : false,
						data : pm25,
						barThickness : 25,
						backgroundColor : function(context) {
							// context.index로 현재 인덱스에 해당하는 데이터를 가져올 수 있습니다.
							const pm25Value = pm25[context.dataIndex];
							// PM-10 값에 따라 색상을 지정합니다.
							if (pm25Value <= 15) {
								return '#93C9EE'; // 좋음
							} else if (pm25Value <= 35) {
								return '#52BF90'; // 보통
							} else if (pm25Value <= 75) {
								return '#ffc616'; // 나쁨
							} else {
								return '#df0606'; // 매우나쁨
							}
						},
					} ]
				};

				const o3Data = {
					labels : labels,
					datasets : [ {
						label : '오존 O₃',
						data : o3,
						barThickness : 25,
						backgroundColor : function(context) {
							// context.index로 현재 인덱스에 해당하는 데이터를 가져올 수 있습니다.
							const o3Value = o3[context.dataIndex];
							// PM-10 값에 따라 색상을 지정합니다.
							if (o3Value <= 0.03) {
								return '#93C9EE'; // 좋음
							} else if (o3Value <= 0.09) {
								return '#52BF90'; // 보통
							} else if (o3Value <= 0.15) {
								return '#ffc616'; // 나쁨
							} else {
								return '#df0606'; // 매우나쁨
							}
						},
					} ]
				};

				const no2Data = {
					labels : labels,
					datasets : [ {
						label : '이산화질소 NO2',
						data : no2,
						barThickness : 25,
						backgroundColor : function(context) {
							// context.index로 현재 인덱스에 해당하는 데이터를 가져올 수 있습니다.
							const no2Value = no2[context.dataIndex];
							// PM-10 값에 따라 색상을 지정합니다.
							if (no2Value <= 0.03) {
								return '#93C9EE'; // 좋음
							} else if (no2Value <= 0.06) {
								return '#52BF90'; // 보통
							} else if (no2Value <= 0.2) {
								return '#ffc616'; // 나쁨
							} else {
								return '#df0606'; // 매우나쁨
							}
						},
					} ]
				};

				const coData = {
					labels : labels,
					datasets : [ {
						label : '일산화탄소 CO',
						data : co,
						barThickness : 25,
						backgroundColor : function(context) {
							// context.index로 현재 인덱스에 해당하는 데이터를 가져올 수 있습니다.
							const coValue = co[context.dataIndex];
							// PM-10 값에 따라 색상을 지정합니다.
							if (coValue <= 2) {
								return '#93C9EE'; // 좋음
							} else if (coValue <= 9) {
								return '#52BF90'; // 보통
							} else if (coValue <= 15) {
								return '#ffc616'; // 나쁨
							} else {
								return '#df0606'; // 매우나쁨
							}
						},
					} ]
				};

				const so2Data = {
					labels : labels,
					datasets : [ {
						label : '아황산가스 SO2',
						data : so2,
						barThickness : 25,
						backgroundColor : function(context) {
							// context.index로 현재 인덱스에 해당하는 데이터를 가져올 수 있습니다.
							const so2Value = so2[context.dataIndex];
							// PM-10 값에 따라 색상을 지정합니다.
							if (so2Value <= 0.002) {
								return '#93C9EE'; // 좋음
							} else if (so2Value <= 0.05) {
								return '#52BF90'; // 보통
							} else if (so2Value <= 0.15) {
								return '#ffc616'; // 나쁨
							} else {
								return '#df0606'; // 매우나쁨
							}
						},
					} ]
				};

				if (pm10Chart) {
					pm10Chart.destroy();
				}
				pm10Chart = new Chart(document.getElementById('PM10'), {
					type : 'bar',
					data : pm10Data,
					options : {
						plugins : {
							legend : {
								display : false
							},
						},
						scales : {
							y : {
								beginAtZero : true,
							}
						},

					}
				});

				if (pm25Chart) {
					pm25Chart.destroy();
				}
				pm25Chart = new Chart(document.getElementById('PM2.5'), {
					type : 'bar',
					data : pm25Data,
					options : {
						plugins : {
							legend : {
								display : false
							},
						},
						scales : {
							y : {
								beginAtZero : true
							},
						}
					}
				});

				if (o3Chart) {
					o3Chart.destroy();
				}
				o3Chart = new Chart(document.getElementById('O3'), {
					type : 'bar',
					data : o3Data,
					options : {
						plugins : {
							legend : {
								display : false
							},
						},
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});

				if (no2Chart) {
					no2Chart.destroy();
				}
				no2Chart = new Chart(document.getElementById('NO2'), {
					type : 'bar',
					data : no2Data,
					options : {
						plugins : {
							legend : {
								display : false
							},
						},
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});

				if (coChart) {
					coChart.destroy();
				}
				coChart = new Chart(document.getElementById('CO'), {
					type : 'bar',
					data : coData,
					options : {
						plugins : {
							legend : {
								display : false
							},
						},
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});

				if (so2Chart) {
					so2Chart.destroy();
				}
				so2Chart = new Chart(document.getElementById('SO2'), {
					type : 'bar',
					data : so2Data,
					options : {
						plugins : {
							legend : {
								display : false
							},
						},
						scales : {
							y : {
								beginAtZero : true
							}
						}
					}
				});
			}
		</script>

	</div>
</div>

<jsp:include page="/Include/Footer.jsp" />