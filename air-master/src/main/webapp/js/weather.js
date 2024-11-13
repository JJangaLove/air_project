$(document).ready(function() {
        
    // 지역 선택 드롭다운에 대한 이벤트 리스너
    $('#regionSelect').change(function() {
        var selectedRegion = $(this).val(); // 선택된 지역을 가져옵니다.
        if (selectedRegion !== "") {
            // 선택된 지역에 대한 날씨 데이터를 가져오는 함수 호출
            fetchWeather(selectedRegion);
            console.log(selectedRegion)
        }
    });


    // 특정 지역에 대한 날씨 데이터를 가져오는 함수
    function fetchWeather(region) {
        // 현재 날짜 및 시간 정보 가져오기
        var today = new Date();
        var week = new Array('일', '월', '화', '수', '목', '금', '토');
        var year = today.getFullYear();
        var month = today.getMonth() + 1;
        var day = today.getDate();
        var hours = today.getHours();
        var minutes = today.getMinutes();
        var hours_al = new Array('02', '05', '08', '11', '14', '17', '20', '23');
        var now = '';

        /* 동네예보 시간이 0200 0500 ... 3시간 단위로 23시까지 */
        for (var i = 0; i < hours_al.length; i++) {
            var h = hours_al[i] - hours;
            if (h == -1 || h == 0 || h == -2) {
                var now = hours_al[i];
            }
            if (hours == 00) {
                var now = hours_al[7];
            }
        }

        // 한자릿수 시간은 앞에 0추가 코드
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
        console.log(today);

        // AJAX를 통해 API 호출
        // 선택된 지역에 대한 API 호출을 위한 URL 생성
        var apiKey = "C6q7EQAL%2Bcdo0R8PGy%2FkCVR2J%2Fbr6UFW0EB067UIv82h6CquDJYRMOUfnZ%2BYf9bYCGxJSv3XX7qBOKACbjRcsQ%3D%3D";
        var selectedRegionIndex = regionIndexMap[region];
        var nx = korea[selectedRegionIndex].nx;
        var ny = korea[selectedRegionIndex].ny;

        var forecastGribURL = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
        forecastGribURL += "?ServiceKey=" + apiKey;
        forecastGribURL += "&pageNo=2";
        forecastGribURL += "&base_date=" + today;
        forecastGribURL += "&base_time=" + now + "00";
        forecastGribURL += "&nx=" + nx + "&ny=" + ny;
        console.log(now)
        $.ajax({
            url: forecastGribURL,
            type: 'GET',
            dataType: 'XML',
            success: function(data) {
                var $data = $(data).find("response>body>items>item");
                var cate = '';
                var temp = '';
                var sky = '';
                var rain = '';
                var hd = '';
                var wind = '';
                var rainP = '';
                console.log(data);
                console.log(forecastGribURL);

                $.each($data, function(i, o) {
                    cate = $(o).find("category").text(); // 카테고리

                    if (cate == 'TMP') {
                        temp = $(o).find("fcstValue").text(); // 온도
                    }
                    if (cate == 'SKY') {
                        sky = $(o).find("fcstValue").text(); // 하늘상태
                        console.log("맑음"+sky)
                    }
                    if (cate == 'PTY') {
                        rain = $(o).find("fcstValue").text(); // 강수형태
                        console.log("비" + rain)
                    }
                    if (cate == 'WSD') {
                        wind = $(o).find("fcstValue").text(); // 풍속
                    }
                    if (cate == 'REH') {
                        hd = $(o).find("fcstValue").text(); // 습도
                    }
                    if (cate == 'POP') {
                        rainP = $(o).find("fcstValue").text(); // 강수확률
                    }
                });
                // 하늘 상태를 기준으로 아이콘과 함께 표시
        var skyIcon = '';
        var rainIcon = ''
        var weatherCondition = '';
            if (rain != 0) {
                    switch (rain) {
                        case '1':
                            rainIcon = '<img src="../images/weather/pty01.png">';
                            weatherCondition = "비";
                            break;
                        case '2':
                            rainIcon = '<img src="../images/weather/pty02.png">';
                            weatherCondition = "비/눈";
                            break;
                        case '3':
                            rainIcon = '<img src="../images/weather/pty03.png">';
                            weatherCondition = "눈";
                            break;
                    }
                } else {
                    switch (sky) {
                        case '1':
                            skyIcon = '<img src="../images/weather/sky01.png">';
                            weatherCondition = "맑음";
                            break;
                        case '2':
                            skyIcon = '<img src="../images/weather/sky02.png">';
                            weatherCondition = "구름 조금";
                            break;
                        case '3':
                            skyIcon = '<img src="../images/weather/sky03.png">';
                            weatherCondition = "구름 많음";
                            break;
                        case '4':
                            skyIcon = '<img src="../images/weather/sky04.png">';
                            weatherCondition = "흐림";
                            break;
                        default:
                            skyIcon = '';
                            weatherCondition = "알 수 없음";
                    }
                }//if 종료

                // 가져온 날씨 데이터를 화면에 표시
                var regionDisplay = region;
                // var weatherDisplay = weatherCondition + "&nbsp; 풍속 " + wind + "m/s &nbsp; 강수확률 " + rainP + "% &nbsp; 습도 " + hd + "%";
                // $('.weather').empty().append('<li class="list-group-item">' + weatherDisplay + '</li>');

                $('.viewRegion').empty().append(regionDisplay); //지역명
                $('.uploadTime').empty().append("업데이트 : " + now + "시"); //업데이트시간
                
                $('.temp').empty().append(temp); //온도
                $('.wind').empty().append(wind + " m/s"); //풍속
                $('.rainP').empty().append(rainP + " %"); //강수
                $('.hd').empty().append(hd + " %"); //습도
                $('.todayTxt').empty().append(weatherCondition); // 하늘 상태 텍스트 표시

                $('.todayWeather').empty().append(skyIcon, rainIcon); // 하늘 상태 아이콘
                
            },//success func 종료
            error: function() {
                $('.weather').empty().append('<li class="list-group-item">날씨 정보를 가져올 수 없습니다.</li>');
            }

        });
    }


    // 한글 지역명과 그에 해당하는 좌표 데이터 매핑
    var korea = [
        {'region': '서울', 'nx': 60, 'ny': 127},
        {'region': '인천', 'nx': 55, 'ny': 124},
        {'region' : '경기도','nx' : 60,'ny' : 121}, 
        {'region' : '강원도','nx' : 92,'ny' : 131}, 
        {'region' : '충청북도','nx' : 69,'ny' : 106}, 
        {'region' : '충청남도','nx' : 68,'ny' : 100},
        {'region' : '전라북도','nx' : 63,'ny' : 89}, 
        {'region' : '전라남도','nx' : 50,'ny' : 67}, 
        {'region' : '경상남도','nx' : 90,'ny' : 77}, 
        {'region' : '경상북도','nx' : 91,'ny' : 106}, 
        {'region' : '제주도','nx' : 52,'ny' : 38},
        {'region' : '광주','nx' : 58,'ny' : 74},
        {'region' : '경기도','nx' : 60,'ny' : 120},
        {'region' : '인천','nx' : 55,'ny' : 124},
        {'region' : '대전','nx' : 67,'ny' : 100},
        {'region' : '대구','nx' : 89,'ny' : 90},
        {'region' : '세종','nx' : 66,'ny' : 103},
        {'region' : '부산','nx' : 98,'ny' : 76}

    ];

    // 지역명과 좌표 데이터의 인덱스 매핑
    var regionIndexMap = {};
    for (var i = 0; i < korea.length; i++) {
        regionIndexMap[korea[i].region] = i;
    }

    fetchWeather("광주", regionIndexMap);
});