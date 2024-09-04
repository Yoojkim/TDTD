#  🗓️ ㅌㄷㅌㄷ
![ㅌㄷㅌㄷ2 001](https://github.com/user-attachments/assets/4b4e0357-9cd5-4521-9ecd-e8568541df9d)

## 프로젝트 소개
- ㅌㄷㅌㄷ는 별도의 서버 저장 없이, 내부 DB를 통해 투두리스트를 관리하는 어플리케이션 입니다.
- 상단의 날짜 위젯을 통해 원하는 날짜로 이동할 수 있고, 오늘 날짜로 돌아오는 버튼을 통해 쉽게 돌아올 수 있습니다.
- 기교 없이 투두리스트 관리에만 초점을 둔 어플리케이션입니다. 

## 개발 환경
- Flutter
- inner DB

## 프로젝트 구조
```
📦lib
 ┣ 📂component
 ┃ ┗ 📜logo.dart
 ┣ 📂const
 ┃ ┗ 📜color.dart
 ┣ 📂database
 ┃ ┗ 📜database.dart
 ┣ 📂model
 ┃ ┣ 📜to_do.dart
 ┃ ┗ 📜week_day.dart
 ┣ 📂router
 ┃ ┗ 📜router.dart
 ┣ 📂screen
 ┃ ┣ 📜splash_screen.dart
 ┃ ┗ 📜todo_screen.dart
 ┣ 📂state
 ┃ ┗ 📜standard_date_provider.dart
 ┣ 📂widget
 ┃ ┣ 📜create_todo_sheet.dart
 ┃ ┣ 📜date_widget.dart
 ┃ ┣ 📜error_database.dart
 ┃ ┣ 📜exist_todo.dart
 ┃ ┣ 📜loading_widget.dart
 ┃ ┣ 📜not_exist_todo.dart
 ┃ ┣ 📜per_todo.dart
 ┃ ┗ 📜todo_widget.dart
 ┗ 📜main.dart
```

## 개발 기간 
전체 개발 기간: 9일 (2024년 5월 5일~2024년 5월 14일)

## 프로젝트 소감
플러터를 사용하기로 결정한 후, 별도의 공부 없이 맨땅에 해딩하기 위해 만든 프로젝트입니다. 부족한 부분으로는

- 코드가 분리가 잘 되어있지 않음
- riverpod을 사용하지 않아 코드가 중구난방임
- 상세한 에러 처리나 예외 dialog를 사용자에게 반환하지 않음
- 세밀한 기능 부재
- 위젯의 크기가 모두 상대 크기가 아닌 절대 크기로 구현함
  
과 같은 개선점이 있습니다. 
이후 프로젝트에서는 이러한 개선점을 모두 반영하여 구현하였습니다. ㅌㄷㅌㄷ 프로젝트를 통해 상태관리의 중요성, 코드 분리로 인한 재사용의 경험 등 Flutter로 어플리케이션을 작성할 때 고려해야 할 점을 처음 알게 되었습니다. 

