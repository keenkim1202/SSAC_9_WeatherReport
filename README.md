# SSAC_9_WeatherReport
openWeather API를 가져와 현재 위치의 날씨를 알려주는 앱 입니다.

# Requirement
- WeatherInfo.plist에 [openWeather](https://openweathermap.org) 의 APIKEY 정보를 입력해주세요.

# Assigment (~10/11 오후 1시)
- [x] 참조이미지와 같이 화면 구성하기
- [x] DateFormatter르 통헤 원하는 형식의 날짜를 표시합니다.
- [x] APIKEY 정보를 숨김처리 하였습니다.
- [x] Alamofire를 통해 openWeather api의 json 형식으로 된 데이터를 가져왔습니다.
- [x] SwiftyJSON을 통해 JSON 형식의 데이터에서 원하는 정보를 파싱하여 뿌려주었습니다.

# 추가 구현 사항 
- [ ] 위치 권한 거부 시, respring을 하려하며 alert문을 띄워 위치 설정으 해줄 것을 알립니다.
- [ ] 위치 권한 alert에서 '설정'을 누르면 system setting 화면으로 넘어갑니다.

|참조 이미지||구현 앱 UI|
|:---:|:---:|:--:|
|<img width="75%" src="https://user-images.githubusercontent.com/59866819/138997683-cd68ff95-7da7-4522-8177-3b5ad1385194.png" />|<img width="120" src="https://user-images.githubusercontent.com/59866819/135194858-4405d3a0-0de3-4ca6-a594-3b08e0ae951b.png" />|<img width="60%" src="https://user-images.githubusercontent.com/59866819/138997690-f989ca31-33d7-4399-b0e4-eb7d8b8aeda1.png" />|

# 실행 영상
<p align="center"><img width="30%" src="https://user-images.githubusercontent.com/59866819/162690022-3a8b80bb-e9bd-4720-9034-9a846223ec69.gif" /></p>
