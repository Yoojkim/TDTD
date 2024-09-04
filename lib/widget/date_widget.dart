import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/const/color.dart';
import 'package:todolist/model/week_day.dart';
import 'package:todolist/state/standard_date_provider.dart';

class DateNavigator extends StatefulWidget {
  final DateTime today;
  DateNavigator({
    super.key,
    required this.today,
  });

  @override
  State<DateNavigator> createState() => _DateNavigatorState();
}

class _DateNavigatorState extends State<DateNavigator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StandardDate standardDateByProvider = Provider.of<StandardDate>(context);
    DateTime standardDate = standardDateByProvider.standardDate;
    WeekDay weekDay = WeekDay(standardDate);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 9.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Text(
                  '${standardDate.year}년 ${standardDate.month}월 ${standardDate.day}일',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        standardDateByProvider.changeDate(
                            standardDate.subtract(const Duration(days: 7)));
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    IconButton(
                      onPressed: () {
                        standardDateByProvider.changeDate(
                            standardDate.add(const Duration(days: 7)));
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(
              3.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                createDaysWidget(weekDay, standardDateByProvider, widget.today),
          ),
        ],
      ),
    );
  }

  List<Column> createDaysWidget(
      WeekDay weekDay, StandardDate standardDate, DateTime today) {
    return weekDay.weekDateTime
        .map((e) => Column(children: [
              GestureDetector(
                onTap: () {
                  //탭한 곳이 standard면 변경하지 않음
                  if (e == standardDate.standardDate) {
                    return;
                  }
                  standardDate.changeDate(e);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: standardDate.standardDate != e
                        ? superLightPink
                        : lightPink,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    '${WeekDay.getWeekTextFromDateTime(e!)}',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Text(
                '${e.day}',
                style: TextStyle(
                  fontWeight: isSameDate(e, today)
                      ? FontWeight.w800
                      : FontWeight.normal,
                ),
              )
            ]))
        .toList();
  }

  bool isSameDate(DateTime? d1, DateTime? d2) {
    if (d1?.year == d2?.year && d1?.month == d2?.month && d1?.day == d2?.day) {
      return true;
    }

    return false;
  }
}
