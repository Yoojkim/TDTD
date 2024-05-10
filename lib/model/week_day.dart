class WeekDay {
  static Map weekDayText = {
    1: '월',
    2: '화',
    3: '수',
    4: '목',
    5: '금',
    6: '토',
    7: '일',
  };
  List<DateTime?> weekDateTime = [];

  WeekDay(DateTime standardDate) {
    Map<int, DateTime> weekDay = {};
    int todayWeekDay = standardDate.weekday;

    for (int i = todayWeekDay; i >= 1; i--) {
      weekDay[i] = standardDate.subtract(Duration(days: (todayWeekDay - i)));
    }

    for (int i = todayWeekDay + 1; i <= 7; i++) {
      weekDay[i] = standardDate.add(Duration(days: i - todayWeekDay));
    }

    for (int i = 1; i <= 7; i++) {
      weekDateTime.add(weekDay[i]);
    }
  }

  static String getWeekTextFromIndex(int index) {
    return weekDayText[index];
  }

  static String getWeekTextFromDateTime(DateTime dateTime) {
    return weekDayText[dateTime.weekday];
  }
}
