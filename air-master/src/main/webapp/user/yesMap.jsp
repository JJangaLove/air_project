<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="fonts.css">
	<meta charset="UTF-8">
	<title>내일 미세, 초미세먼지</title>
	<script src="https://code.highcharts.com/maps/highmaps.js"></script>
	<script src="https://code.highcharts.com/mapdata/countries/kr/kr-all.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<select id="pollutionType">
    <option value="pm10">PM-10</option>
    <option value="pm25">PM-2.5</option>
</select>
<div id="container" style="width: 675px; height: 754px; margin: 0 auto"></div>

<script>
	$(document).ready(function() {
		// 선택 상자 값 변경 시 이벤트 핸들러
		$("#pollutionType").change(function() {
        var selectedType = $(this).val(); // 선택된 값(PM10 또는 PM2.5)
        var apiUrl = 'http://192.168.0.70:5000/predict'; // 기본 API 주소(서버ip)

        // 선택된 타입에 따라 API 주소 업데이트
        if(selectedType === 'pm25') {
            apiUrl += '25'; // PM2.5 데이터 요청 주소
        } else {
            apiUrl += '10'; // PM10 데이터 요청 주소
        }

        // 변경된 API 주소로 데이터 요청 및 지도 업데이트
	 $.ajax({
	 url: apiUrl,
	 type: 'GET',
	 dataType: 'json', // 응답 데이터 타입  
	 success: function(data) {
		// 응답 데이터 처리 
	   console.log(data); // 콘솔에 응답 로그 출력
	   var regionData = [
           { name: '강원', code: 'kr-kw'},
           { name: '인천', code: 'kr-in'},
           {name: '서울', code: 'kr-so'}, // 서울
           {name: '경기', code: 'kr-kg'}, // 경기도
           {name: '충남', code: 'kr-gn'}, // 충청남도
           {name: '충북', code: 'kr-gb'}, // 충청북도
           {name: '세종', code: 'kr-sj'}, // 세종
           {name: '대전', code: 'kr-tj'}, // 대전 코드 맞음
           {name: '경북', code: 'kr-2688'}, // 경상북도
           {name: '대구', code: 'kr-tg'}, // 대구
           {name: '울산', code: 'kr-ul'}, // 울산
           {name: '부산', code: 'kr-pu'}, // 부산
           {name: '경남', code: 'kr-kn'}, // 경상남도
           {name: '전북', code: 'kr-cb'}, // 전라북도
		   {name: '전남', code: 'kr-2685'}, // 전라남도
           {name: '광주', code: 'kr-kj'}, // 광주
           {name: '제주', code: 'kr-cj'}, // 제주
       ];
	// 선택된 타입에 따라 미세먼지 농도 설정
       var pollutionLevels;
       if(selectedType === 'pm25') {
           // 초미세먼지(PM2.5) 카테고리 기준
           pollutionLevels = [{
               from: 0,
               to: 30,
               color: '#7BC9FF',
               category: '좋음'
           }, {
               from: 31,
               to: 50,
               color: '#58dd5b',
               category: '보통'
           }, {
               from: 51,
               to: 150,
               color: '#FDF56A',
               category: '나쁨'
           }, {
               from: 151,
               color: '#FF8A89',
               category: '매우나쁨'
           }];
       } else {
           // 미세먼지(PM10) 카테고리 기준
           pollutionLevels = [{
               from: 0,
               to: 30,
               color: '#7BC9FF',
               category: '좋음'
           }, {
               from: 31,
               to: 80,
               color: '#58dd5b',
               category: '보통'
           }, {
               from: 81,
               to: 150,
               color: '#FDF56A',
               category: '나쁨'
           }, {
               from: 151,
               color: '#FF8A89',
               category: '매우나쁨'
           }];
       }
	   
    // 미세먼지 농도값에 따른 색상과 카테고리 결정 함수
       function getColorAndCategoryForValue(value) {
           var result = pollutionLevels.find(level => value <= level.to || typeof level.to === 'undefined');
           return result ? { color: result.color, category: result.category } : {};
       }

    //미세먼지 데이터 처리
	var processedData = regionData.map(function(region, index) {
    var value = data[index];
    var { color, category } = getColorAndCategoryForValue(value);
    
    // 서울과 충남의 데이터 따로 처리
    if (region.name === '서울') {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category,
            dataLabels: {
            	x: +10,
                y: -15 // 서울의 텍스트 위치 위로 조정
            }
        };
    } else if (region.name === '충남') {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category,
            dataLabels: {
            	x: -10, //충남의 텍스트 위치 왼쪽으로 조정
                y: -20 // 위로 조정
            }
        };
    } else if (region.name === '세종') {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category,
            dataLabels: {
                y: -20 // 위로 조정
            }
        };
    } else if (region.name === '대전') {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category,
            dataLabels: {
            	x: +10,
                y: +20 // 대전의 텍스트 위치 아래로 조정 
            }
        };
    } else if (region.name === '경북') {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category,
            dataLabels: {
                y: -30 // 경북의 텍스트 위치 아래로 조정 
            }
        };
    } else if (region.name === '울산') {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category,
            dataLabels: {
                x: +20,  
                y: -20
            }
        };
    } else if (region.name === '전남') {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category,
            dataLabels: {      
                y: +30 // 아래로 이동
            }
        };
    } else {
        return {
            name: region.name,
            code: region.code,
            color: color,
            category: category
        };
    }
});
    
	// Highcharts 지도 차트 생성 코드
		Highcharts.mapChart('container', {
			chart: {
		        map: 'countries/kr/kr-all',
		        plotBackgroundColor: '#c1dfec', // 배경색 지정
		        margin: [0, 0, 0, 0]
		    },
			title : {
				text : null
			},
			legend : { // 범례 삭제
				enabled : false
			},
			mapNavigation: { // 마우스 스크롤 비활성화
	            enabled: false
	        },
	        colorAxis: {
                dataClasses: pollutionLevels
            },
			series : [{
				name : null,
				borderColor: 'gray', // 테두리 색상
			    borderWidth: 1, // 테두리 두께
				dataLabels : {
					enabled : true,
					useHTML : true,
					formatter: function() {
					    return '<span style="border: 1px solid white; padding: 2px 10px; border-radius: 29%; background-color: rgba(255, 255, 255, 0.85); display: inline-block; text-align: center;">' + 
					    this.point.name + '<br><span style="font-weight: bold;">' + this.point.category + '</span></span>';
					},
					style: {
						fontSize: '14px', // 글꼴 크기
						fontWeight: 'normal', // 글꼴 굵기
						color: 'black',  // 글꼴 색상
						fontFamily: 'SUITE-Regular, sans-serif' // 'SUITE-Regular' 웹폰트 또는 기본 sans-serif 글꼴 사용
					},   
				},
				tooltip: {
					headerFormat: '',
			        pointFormat: '{point.name} <b>{point.category}</b>'
			    },
				allAreas : false,
				joinBy: ['hc-key', 'code'],
				data : processedData,
				point: {
				    events: {
				        mouseOver: function() {
				            this.graphic.css({
				                filter: 'brightness(95%)'
				            });
				        },
				        mouseOut: function() {
				            this.graphic.css({
				                filter: ''
				            });
				        }
				    }    
				}
			}]
		}); // 하이차트 지도생성 끝
	 },
	 error: function(request, status, error) {
	 	alert('API 호출 실패: ' + error);
	 }
   	 }); //ajax 끝
   	 
}); //이벤트 핸들러 끝
	 // 초기 페이지 로딩 시 PM10 데이터로 지도 로드
	 $("#pollutionType").trigger('change');
}); //document 끝
</script>

</body>
</html>