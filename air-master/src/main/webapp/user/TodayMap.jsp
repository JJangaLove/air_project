<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<style>
.overlaybox {top:-50px; left:-50px; position:relative;width:100px;height:100px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}
.overlaybox .boxtitle {text-align:center; color:#fff;font-size:16px;font-weight:bold;margin-bottom:8px;}
.overlay { position: absolute; background-color: rgba(255, 255, 255, 0.8); padding: 5px; border-radius:29%; font-size: 14px; font-weight: bold; white-space: nowrap; width:43px; height:40px; text-align: center;}
</style>


</head>
<body>
<!-- jQuery 라이브러리 추가 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 카카오지도 API 스크립트 추가 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b0933834acbda4bfc86ac21d9643c87f&libraries=services,clusterer"></script>

<!-- 클러스터러 라이브러리 추가 -->
<script src="https://t1.daumcdn.net/mapjsapi/js/libs/clusterer/1.0.9/clusterer.js"></script>

<div class="map-wrap" style="position: absolute; left: 0; top: 0; right: 0; bottom: 60px;">
   <div id="todayMap" style="width:100%; height:100%"></div>
</div>
<script>

$(document).ready(function() {
    var mapContainer = document.getElementById('todayMap');
    var mapOption = {
        center: new daum.maps.LatLng(36.35041, 127.38454),
        level: 13,
        mapTypeId: daum.maps.MapTypeId.ROADMAP
    };

    var map = new daum.maps.Map(mapContainer, mapOption);
    var customOverlay = new daum.maps.CustomOverlay({});
    
    createCustomOverlays();
    
    var polygons = []; // 폴리곤 배열

    function getColorByPM10Value(pm10Value) {
        var pm10Int = parseInt(pm10Value, 10);
        console.log(typeof(pm10Int), pm10Int);

        if ( pm10Int <= 30 && pm10Int>0) {
            return '#0000FF'; // 파랑
        } else if (pm10Int <= 80 && pm10Int >30) {
            return '#00FF00'; // 초록
        } else if (pm10Int <= 150 && pm10Int >80) {
            return '#FFFF00'; // 노랑
        } else {
            return 'rgb(88 221 91)'; // 빨강
        }
    }

 	
    // 대한민국 지도 폴리곤 표시
    $.getJSON('gson.json', function(geojson) {
        var data = geojson.features;
        
        $.each(data, function(index, val) {
            var coordinates = val.geometry.coordinates;
            var name = val.properties.CTP_ENG_NM;           
            var pm10Value = val.properties[name]; // pm10Value 값 가져오기

  
            console.log("pm10Value in loop:", pm10Value); // pm10Value 값 출력
           // console.log("name in loop:", name); // pm10Value 값 출력

            displayMap(coordinates, name, pm10Value);
        });
    });
    
    
   
 // 대한민국 지도 폴리곤 표시 함수
    function displayMap(coordinates, name, pm10Value) {
    	///console.log("pm10Value in displayMap:", pm10Value);

        var path = [];

        $.each(coordinates[0], function(index, coordinate) {        
            path.push(new kakao.maps.LatLng(coordinate[1], coordinate[0]));
        });
        
        // 다각형 생성
       var polygon = new daum.maps.Polygon({
 		   map: map,
 		   path: path,
 		   strokeWeight: 1,
  		   strokeColor: '#888',
  		   strokeOpacity: 0.8,
 		   fillColor: getColorByPM10Value(pm10Value), 
  		   fillOpacity: 0.8
	});
        
        
        polygons.push(polygon);

        // 폴리곤에 마우스 이벤트 등록
        daum.maps.event.addListener(polygon, 'mouseover', function() { 		
    		   polygon.setOptions({
     	       fillColor: 'rgb(11 173 14)'
        });
   		

        // 커스텀 오버레이 설정
        var content = '<div class="overlaybox"><div class="boxtitle">' + name + '</div></div>';
        customOverlay.setContent(content);
        customOverlay.setPosition(centerMap(path));
        customOverlay.setMap(map);      		
        });
	

        daum.maps.event.addListener(polygon, 'mouseout', function() {         
            polygon.setOptions({
             fillColor: getColorByPM10Value(pm10Value)
        });               
          customOverlay.setMap(null);
        });
    

        daum.maps.event.addListener(polygon, 'click', function() {
            var level = map.getLevel() - 2;
            map.setLevel(level, {anchor: centerMap(path), animate: {duration: 350}});
        });
    } 

		 // 폴리곤의 중심 좌표 계산 함수
 	   function centerMap(path) {
      	  var area = 0, x = 0, y = 0;
     	   var len = path.length;

     	   for (var i = 0, j = len - 1; i < len; j = i++) {
       	     var p1 = path[i];
       	     var p2 = path[j];
       	     var f = p1.getLat() * p2.getLng() - p2.getLat() * p1.getLng();
       	     
             x += (p1.getLng() + p2.getLng()) * f;
             y += (p1.getLat() + p2.getLat()) * f;
             area += f * 3;
        }

        return new daum.maps.LatLng(x / area, y / area);
    }
    
    function createCustomOverlays() {  	
    	
    	  // 초기 실행 시 시도별 미세먼지 정보 API 호출
        var sidoUrl = "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst?itemCode=PM10&dataGubun=HOUR&pageNo=1&numOfRows=100&returnType=json&serviceKey=ekXFdR2FjlE7CSHqSbzORcwit3Ld200uGSLsMGenBP6GI3s%2BRz6rjxoGfwoHw0dq0pOwL%2FhUnJsq0rQAyF%2F7Ug%3D%3D";

        $.ajax({
            type: "GET",
            url: sidoUrl,
            data: {},
            success: function(response) {
            	 console.log("response", response); 
            	 
                if (response.response && response.response.body && response.response.body.items) {
                	
                    var items =  response.response.body.items[0]; // 첫 번째 item만 가져옴
                    var coordinates = {
                    		"seoul": new daum.maps.LatLng(37.8144, 126.9733),
                    	    "busan": new daum.maps.LatLng(35.1796, 129.0056),
                    	    "daegu": new daum.maps.LatLng(35.8714, 128.6014),
                    	    "incheon": new daum.maps.LatLng(37.4563, 126.7052),
                    	    "gwangju": new daum.maps.LatLng(35.1595, 126.8526),
                    	    "daejeon": new daum.maps.LatLng(36.3504, 127.3845),
                    	    "ulsan": new daum.maps.LatLng(35.5384, 129.3114),
                    	    "gyeonggi": new daum.maps.LatLng(37.4138, 127.5183),
                    	    "gangwon": new daum.maps.LatLng(37.8228, 128.1555),
                    	    "chungbuk": new daum.maps.LatLng(37.1157, 127.8912),
                    	    "chungnam": new daum.maps.LatLng(36.6588, 126.6723),
                    	    "jeonbuk": new daum.maps.LatLng(35.7175, 127.1530),
                    	    "jeonnam": new daum.maps.LatLng(34.8679, 126.5110),
                    	    "gyeongbuk": new daum.maps.LatLng(36.5761, 128.5055),
                    	    "gyeongnam": new daum.maps.LatLng(35.4606, 128.2132),
                    	    "jeju": new daum.maps.LatLng(33.4996, 126.2312),
                    	    "sejong": new daum.maps.LatLng(36.7808, 127.2892)
                    };
					var sidoNames={
							"seoul" : "서울",
							"busan" : "부산",
							"daegu" : "대구",
							"incheon": "인천",
							"gwangju" : "광주",
							"daejeon" : "대전",
							"ulsan" : "울산",
							"gyeonggi" : "경기",
							"gangwon" : "강원",
							"chungbuk" : "충북",
							"chungnam" : "충남",
							"jeonbuk": "전북",
							"jeonnam" :"전남",
							"gyeongbuk" :"경북",
							"gyeongnam" : "경남",
							"jeju" : "제주",
							"sejong" : "세종"
								
								
					}
                    
					 // 시도별 미세먼지 수치와 해당 시도의 위도 경도 좌표를 이용하여 지도에 표시
                    $.each(items, function(sidoName, pm10Value) {
                    	var koreanSidoName = sidoNames[sidoName]; // 영문 시도 이름을 한글로 변환
                        var coords = coordinates[sidoName.toLowerCase()]; // 시도명을 소문자로 변환하여 좌표 찾기
                        if (coords) {
                            // 커스텀 오버레이 생성 및 설정
                            var content = '<div class="overlay">' + koreanSidoName + '<br><span style="text-align: center; display: block;">' + pm10Value + '</span></div>';
                            var overlay = new daum.maps.CustomOverlay({
                            	map: map,
                                position: coords,
                                content: content
                            });
                            //displayMap(coords, koreanSidoName, pm10Value);
                            overlay.setMap(map);
                        }
                    });              
                }else{
                	console.log("if문 실행안됨");
                	//console.error("pm10Value is undefined for", koreanSidoName);
                }
            },
            error: function(xhr, status, error) {
                console.error("An error occurred while fetching sido data:", error);
            }
        });
    }
    
   daum.maps.event.addListener(map, 'zoom_changed', function() {
        var currentZoomLevel = map.getLevel();

        if (currentZoomLevel < 13) {
        	 $(".overlay").remove();
        	 console.log("if문 실행"); 
        	 
            var sidoList = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"];
            sidoList.forEach(function(sidoName) {
                var url = "https://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureSidoLIst?sidoName=" + encodeURIComponent(sidoName) + "&searchCondition=HOUR&pageNo=1&numOfRows=10000&returnType=json&serviceKey=ekXFdR2FjlE7CSHqSbzORcwit3Ld200uGSLsMGenBP6GI3s%2BRz6rjxoGfwoHw0dq0pOwL%2FhUnJsq0rQAyF%2F7Ug%3D%3D";

                // 미세먼지 API 호출
                $.ajax({
                    type: "GET",
                    url: url,
                    data: {},
                    success: function(response) {
                        console.log("response", response); // 데이터 확인

                        if (response.response && response.response.body && response.response.body.items) {
                            var markers = [];
                            $.each(response.response.body.items, function(index, item) {
                                var cityName = item.cityName; // 시군구명
                                var pm10Value = item.pm10Value; // 미세먼지 수치

                                // 시군구명을 주소로 변환하여 좌표 얻어오기
                                var geocoder = new daum.maps.services.Geocoder();
                                geocoder.addressSearch(cityName, function(result, status) {
                                    if (status === daum.maps.services.Status.OK) {
                                        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

                                        // 커스텀 오버레이 생성 및 설정
                                        var content = '<div class="overlay">' + cityName + '<br><span style="text-align: center; display: block;">' + pm10Value + '</span></div>';
                                        var overlay = new daum.maps.CustomOverlay({
                                            position: coords,
                                            content: content,
                                        });
                                        overlay.setMap(map);
                                    }
                                });

                            });
                        } else {
                            console.error("Invalid API response format");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("An error occurred:", error);
                    }
                });
            });
        }else{
        	 $(".overlay").remove();
        	console.log("if문 실행안됨");
        }
    }); 
});
</script>
</body>
</html>




