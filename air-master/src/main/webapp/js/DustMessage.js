var locations = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원",
	"충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"];
async function sendRequest(index) {
	var xhr = new XMLHttpRequest();
	var url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty'; /*URL*/
	var queryParams = '?'
		+ encodeURIComponent('serviceKey')
		+ '='
		+ 'bMAqgcYbgyzwocDJ8kfGODrLvCYnm2%2BfnI2r2HG7AZolC3hb%2BgbkHxFuiy2Rk9hrqGUWt8%2F1usofP0BHyi4tkQ%3D%3D'; /*Service Key*/
	queryParams += '&' + encodeURIComponent('returnType') + '='
		+ encodeURIComponent('json'); /**/
	queryParams += '&' + encodeURIComponent('sidoName') + '='
	+ encodeURIComponent(locations[index]); /**/
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
			var averagePm10 = pm10Values.reduce((acc, cur) => acc + cur, 0) / pm10Values.length;
			console.log(locations[index] + "의 평균 미세먼지 농도 : " + averagePm10.toFixed(2));
			if (averagePm10 > 80) {
				// 서블릿에 값을 전달하는 코드 작성
				// 예를 들어, XMLHttpRequest를 사용하여 서블릿에 요청을 보내고 값을 전달할 수 있습니다.
				var servletUrl = '../dustCon';
				var params = 'location=' + encodeURIComponent(locations[index]);
				var xhr = new XMLHttpRequest();
				xhr.open('POST', servletUrl);
				xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						console.log('서블릿에 값 전송 완료');
					}
				};
				xhr.send(params);
			}
			// 요청이 마지막 지역까지 완료된 경우에만 추가 동작 수행
			if (index === locations.length - 1) {
				console.log("모든 지역의 미세먼지 농도를 조회했습니다.");
			} else {
				// 다음 지역에 대한 요청 보내기
				sendRequest(index + 1);
			}
		}
	};
	xhr.send('');
}
//초기 요청 보내기
	//sendRequest(0);