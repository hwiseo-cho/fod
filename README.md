# Dailyme
위치기반 날씨 웹

#### 1. Tech Stack
<img src="https://img.shields.io/badge/Sping%20Boot-6DB33F?style=flat&logo=Spring%20Boot&logoColor=555"/>&nbsp;
<img src="https://img.shields.io/badge/AWS-FF9900?style=flat&logo=Amazon&logoColor=555"/>&nbsp;
<img src="https://img.shields.io/badge/Linux-FCC624?style=flat&logo=Linux&logoColor=555"/>&nbsp;
<img src="https://img.shields.io/badge/Java-007396?style=flat&logo=Java&logoColor=555"/>

- Java 8
- AWS Ubuntu Server 20.04 LTS (HVM), SSD Volume Type(프리티어)

#### 2. Info

- 서버 주소: <https://dailyme.org>

Dailyme는 OpenWeatherMap API를 사용하여 현재 위치 기반 현재 날씨를 알 수 있는 웹이다.
 
웹사이트에 진입하게 되면 위치 동의 알림이 나오고 수락 했을 경우 현재 좌표값을 읽어 API에 요청하여 좌표에 맞는 날씨 정보를 응답받아 화면에 표시해준다. 해당 API는 https가 아니면(localhost제외) 정보를 응답해주지 않기 때문에 AWS 인증서를 적용하였다.   
