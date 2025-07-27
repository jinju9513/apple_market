# 🍎 Apple Market Clone

중고 거래 앱 "당근마켓"을 모티브로 한 Flutter 앱입니다.  
리스트 보기, 상세보기, 좋아요, 삭제, 스크롤 버튼 등 주요 기능을 포함합니다.

---

## 📸 스크린샷

<div style="display: flex; flex-wrap: nowrap; overflow-x: auto; gap: 10px; margin-bottom: 20px;">
  <img src="https://github.com/user-attachments/assets/f403238b-c22b-4a32-aa92-be9c785ac019" width="200" />
  <img src="https://github.com/user-attachments/assets/8a39cd43-f775-41e6-9253-b4c69e662839" width="200" />
</div>

---

## ⚙️ 기술 스택

- **Flutter 3.32.0**
- Dart
- CSV 데이터 로딩
- 상태 관리: StatefulWidget 사용

---

## 📁 프로젝트 구조
'''
lib/
├── data/ # CSV 데이터 로딩
├── models/ # Item 모델 클래스
├── pages/ # HomePage, DetailPage 등 주요 화면
│   ├── detail_page/
│   │   ├──widgets/ # 커스텀 UI 위젯
│   ├── home_page/
│   │   ├──widgets/ # 커스텀 UI 위젯
└── main.dart # 앱 진입점
'''
---

## 🧪 주요 기능

- 리스트 뷰로 상품 목록 표시
- 상품 상세 페이지 이동
- 좋아요 토글 기능 (상태 유지)
- 롱프레스 시 상품 삭제
- 스크롤 시 플로팅 버튼 표시 및 최상단 이동

---

## 🙌 만든 사람
- 이름: 전진주
