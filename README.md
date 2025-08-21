# Kiosk Practice 

이 프로젝트는 Flutter를 사용하여 다양한 종류의 키오스크 UI를 연습하기 위해 제작되었습니다.

공항, 음식점, 민원 발급 등 여러 시나리오를 시뮬레이션하는 것을 목표로 합니다. 

## 🌟 주요 기능

### ✈️ 공항 키오스크
- 언어 선택
- 항공편 조회 및 선택
- 여권 스캔 (UI)
- 좌석 선택
- 탑승권 발급 (UI)

### 🍔 음식점 키오스크
- 메뉴 탐색 (버거, 피자, 파스타 등)
- 세트 메뉴 및 단품 선택
- 주문 및 결제 시뮬레이션

### 📄 민원 발급 키오스크
- 본인 확인 (UI)
- 각종 증명서 발급 기능 (가족관계, 부동산, 세금 등 다양한 카테고리 포함)

## 🛠 사용한 기술
- **Framework:** Flutter
- **Language:** Dart

## 🚀 프로젝트 실행 방법
1. 저장소 복제

  git clone https://github.com/your-username/kiosk_practice.git

2. 프로젝트 폴더로 이동

  cd kiosk_practice

3. Flutter 패키지 설치

  flutter pub get

4. API key, Client ID 입력

  Google Cloud API(https://cloud.google.com/apis)에서 Places API를 선택 후 key를 발급받아 lib/main.dart의 11번째 줄 YOUR_API_KEY에 입력
  
  Naver Cloud Platform(https://www.ncloud.com/)에서 Maps의 Dynamic Map을 선택 후 Client ID를 발급받아 lib/main.dart의 17번째 줄 YOUR_CIENT_ID에 입력

5. 애플리케이션 실행(안드로이드로 실행 권장)

  flutter run
