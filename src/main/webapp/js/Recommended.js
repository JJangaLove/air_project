async function getWeather(city) {
	return new Promise((resolve, reject) => {
		// 한글 지역명과 그에 해당하는 좌표 데이터 매핑
		var korea = [
			{ 'region': '서울', 'nx': 60, 'ny': 127 },
			{ 'region': '부산', 'nx': 98, 'ny': 76 },
			{ 'region': '대구', 'nx': 89, 'ny': 90 },
			{ 'region': '인천', 'nx': 55, 'ny': 124 },
			{ 'region': '광주', 'nx': 58, 'ny': 74 },
			{ 'region': '대전', 'nx': 67, 'ny': 100 },
			{ 'region': '경기', 'nx': 60, 'ny': 121 },
			{ 'region': '강원', 'nx': 92, 'ny': 131 },
			{ 'region': '충북', 'nx': 69, 'ny': 106 },
			{ 'region': '충남', 'nx': 68, 'ny': 100 },
			{ 'region': '전북', 'nx': 63, 'ny': 89 },
			{ 'region': '전남', 'nx': 50, 'ny': 67 },
			{ 'region': '경북', 'nx': 91, 'ny': 106 },
			{ 'region': '경남', 'nx': 90, 'ny': 77 },
			{ 'region': '제주', 'nx': 52, 'ny': 38 },
			{ 'region': '세종', 'nx': 66, 'ny': 103 }
		];

		// 선택된 지역에 대한 API 호출을 위한 URL 생성
		// AJAX 호출 부분을 직접 Promise 객체로 감싸서 처리
		var apiKey = "C6q7EQAL%2Bcdo0R8PGy%2FkCVR2J%2Fbr6UFW0EB067UIv82h6CquDJYRMOUfnZ%2BYf9bYCGxJSv3XX7qBOKACbjRcsQ%3D%3D";
		var nx = korea.find((item) => item.region === city)?.nx;
		var ny = korea.find((item) => item.region === city)?.ny;

		if (nx === undefined || ny === undefined) {
			reject(new Error("해당 도시의 좌표를 찾을 수 없습니다."));
			return;
		}


		var today = new Date();
		var week = ['일', '월', '화', '수', '목', '금', '토'];
		var year = today.getFullYear();
		var month = today.getMonth() + 1;
		var day = today.getDate();
		var hours = today.getHours();
		var hours_al = ['02', '05', '08', '11', '14', '17', '20', '23'];
		var now = '';
		for (var i = 0; i < hours_al.length; i++) {
			var h = hours_al[i] - hours;
			if (h == -1 || h == 0 || h == -2) {
				now = hours_al[i];
			}
			if (hours == 0) {
				now = hours_al[7];
			}
		}
		if (hours < 10) {
			hours = '0' + hours;
		}
		if (month < 10) {
			month = '0' + month;
		}
		if (day < 10) {
			day = '0' + day;
		}
		today = year + "" + month + "" + day;

		var forecastGribURL = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
		forecastGribURL += "?ServiceKey=" + apiKey;
		forecastGribURL += "&pageNo=2";
		forecastGribURL += "&base_date=" + today;
		forecastGribURL += "&base_time=" + now + "00";
		forecastGribURL += "&nx=" + nx + "&ny=" + ny;

		$.ajax({
			url: forecastGribURL,
			type: 'GET',
			dataType: 'XML',
			success: function(data) {
				var $data = $(data).find("response>body>items>item");
				var cate = '';
				var sky = '';
				var rain = '';

				$.each($data, function(i, o) {
					cate = $(o).find("category").text(); // 카테고리

					if (cate == 'SKY') {
						sky = $(o).find("fcstValue").text(); // 하늘상태
					}
					if (cate == 'PTY') {
						rain = $(o).find("fcstValue").text(); // 강수형태
					}
				});

				var weatherCondition = '';
				if (rain != 0) {
					switch (rain) {
						case '1':
							weatherCondition = "비";
							break;
						case '2':
							weatherCondition = "비/눈";
							break;
						case '3':
							weatherCondition = "눈";
							break;
					}
				} else {
					switch (sky) {
						case '1':
							weatherCondition = "맑음";
							break;
						case '2':
							weatherCondition = "구름 조금";
							break;
						case '3':
							weatherCondition = "구름 많음";
							break;
						case '4':
							weatherCondition = "흐림";
							break;
						default:
							weatherCondition = "알 수 없음";
					}
				}

				resolve(weatherCondition); // 날씨 정보를 resolve하여 완료 처리
			},
			error: function() {
				reject(new Error("날씨 정보를 가져올 수 없습니다.")); // 오류 처리
			}
		});

	});
}

async function getDust(city) {
	return new Promise((resolve, reject) => {
		var xhr = new XMLHttpRequest();
		var url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty'; //URL
		var queryParams = '?'
			+ encodeURIComponent('serviceKey')
			+ '='
			+ 'bMAqgcYbgyzwocDJ8kfGODrLvCYnm2%2BfnI2r2HG7AZolC3hb%2BgbkHxFuiy2Rk9hrqGUWt8%2F1usofP0BHyi4tkQ%3D%3D'; //Service Key
		queryParams += '&' + encodeURIComponent('returnType') + '='
			+ encodeURIComponent('json');
		queryParams += '&' + encodeURIComponent('sidoName') + '='
			+ encodeURIComponent(city);

		xhr.open('GET', url + queryParams);
		xhr.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				//alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
				var value = JSON.parse(this.responseText);
				var pm10Values = value.response.body.items.map(item => {
					// '-'나 null인 경우 0으로 변환하여 반환
					var pm10 = item.pm10Value;
					return (pm10 === '-' || pm10 === null) ? 0 : parseInt(pm10, 10);
				});
				averagePm10 = pm10Values.reduce((acc, cur) => acc + cur, 0) / pm10Values.length;
				//console.log(city + "의 평균 미세먼지 농도 : " + averagePm10.toFixed(2));
				resolve(averagePm10); // 프로미스를 이용하여 값을 반환

			}
		}
		xhr.send();
	});
}


async function calculateScore(weather, airQuality) {
	// 여기에 점수 계산 로직 추가
	// 날씨 정보
	var weatherScore = 0;
	switch (weather) {
		case '맑음':
			weatherScore = 10;
			break;
		case '구름 조금':
			weatherScore = 20;
			break;
		case '구름 많음':
			weatherScore = 30;
			break;
		case '흐림':
			weatherScore = 40;
			break;
		case '비':
			weatherScore = 80;
			break;
		case '비/눈':
			weatherScore = 80;
			break;
		case '눈':
			weatherScore = 80;
			break;
		default:
			weatherScore = 0;
	}


	return weatherScore + airQuality; // 임시로 0.0 반환
}

function main(weatherData, airQualityData) {




	
}

async function main() {
	var select_area_value = $("#select_area_value").val();

	// 날씨 정보 가져오기
	let weatherData = await getWeather(select_area_value);
	//console.log(select_area_value + "의 날씨 정보: " + weatherData);

	// 미세먼지 정보 가져오기
	let airQualityData = await getDust(select_area_value);

	// 점수 계산
	let score = await calculateScore(weatherData, airQualityData);

	var dust;
	var mask;
	if (score < 91) {
		dust = "추천";
	} else {
		dust = "추천하지 않음";
	}
	if (airQualityData < 71) {
		mask = "추천하지 않음";
	} else {
		mask = "추천";
	}
	
	// 서버로 데이터 전송
	$.ajax({
		type: "POST",
		url: "./Index.jsp",
		data: { dust: dust, mask: mask },
		success: function(response) {
			// 서버로부터의 응답 처리
			console.log("데이터 전송 완료");
			console.log("dust : " + dust);
			console.log("mask : " + mask);
			
			// 받은 데이터를 이용하여 페이지 업데이트
            //var dust = response.dust;
            //var mask = response.mask;

            // 페이지에 출력
            $(".car").empty().append("<span style='color: " + (dust === '추천' ? 'blue' : 'red') + ";'>" + dust + "</span>");
            $(".mask").empty().append("<span style='color: " + (mask === '추천' ? 'blue' : 'red') + ";'>" + mask + "</span>");
            $(".outdoorActivity").empty().append("<span style='color: " + (dust === '추천' ? 'blue' : 'red') + ";'>" + dust + "</span>");
            $(".ventilation").empty().append("<span style='color: " + (dust === '추천' ? 'blue' : 'red') + ";'>" + dust + "</span>");
		},error: function(xhr, status, error) {
            // 에러 처리
            console.error("에러 발생:", error);
        }
	});
}

