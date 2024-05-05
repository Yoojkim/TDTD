import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/database/database.dart';
import 'package:todolist/model/to_do.dart';

class StandardDate with ChangeNotifier {
  DateTime _standardDate = DateTime.now();
  DateTime get standardDate => _standardDate;

  void changeDate(DateTime newDate) {
    _standardDate = newDate;
    notifyListeners();
  }
}

Map weekDayText = {
  1: '월',
  2: '화',
  3: '수',
  4: '목',
  5: '금',
  6: '토',
  7: '일',
};

class WeekDay {
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
}

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  WeekDay? weekDay;
  DateTime? standardDate;

  @override
  void initState() {
    super.initState();
    standardDate = DateTime.now();
    weekDay = WeekDay(standardDate!);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StandardDate()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'asset/image/logo.png',
            fit: BoxFit.cover,
          ),
          title: const Text('To do!'),
        ),
        body: SafeArea(
            child: Column(
          children: [
            DateNavigator(),
            const Padding(
              padding: EdgeInsets.all(
                5.0,
              ),
            ),
            ToDoList(date: standardDate),
          ],
        )),
      ),
    );
  }
}

class DateNavigator extends StatefulWidget {
  DateNavigator({super.key});

  @override
  State<DateNavigator> createState() => _DateNavigatorState();
}

class _DateNavigatorState extends State<DateNavigator> {
  WeekDay? weekDay;
  DateTime? readlNowDate;

  @override
  void initState() {
    super.initState();

    readlNowDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    StandardDate standardDateByProvider = Provider.of<StandardDate>(context);
    DateTime standardDate = standardDateByProvider.standardDate;
    weekDay = WeekDay(standardDate);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${standardDate.year}년 ${standardDate.month}월 ${standardDate.day}일',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    standardDateByProvider.changeDate(
                        standardDate.subtract(const Duration(days: 7)));

                    weekDay = WeekDay(standardDateByProvider.standardDate);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: () {
                    standardDateByProvider
                        .changeDate(standardDate.add(const Duration(days: 7)));

                    weekDay = WeekDay(standardDateByProvider.standardDate);
                    setState(() {});
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
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
          children: weekDay!.weekDateTime
              .map(
                (e) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        standardDateByProvider.changeDate(e!);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: standardDate.weekday != e?.weekday
                              ? Colors.grey[100]
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          '${weekDayText[e?.weekday]}',
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Text(
                      '${e?.day}',
                      style: TextStyle(
                        fontWeight: isSameDate(e, readlNowDate)
                            ? FontWeight.w800
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  bool isSameDate(DateTime? d1, DateTime? d2) {
    if (d1?.year == d2?.year && d1?.month == d2?.month && d1?.day == d2?.day) {
      return true;
    }

    return false;
  }
}

class ToDoList extends StatefulWidget {
  final dynamic date;
  const ToDoList({super.key, required this.date});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  DataBase? dataBase;
  DateTime? standardDate;
  Future<List<Todo>>? todos;

  @override
  void initState() {
    super.initState();
    dataBase = DataBase();
    standardDate = widget.date;
    todos = _fetchTodos();
  }

  Future<List<Todo>> _fetchTodos() async {
    return await dataBase!.getTodoByDate(standardDate!);
  }

  @override
  Widget build(BuildContext context) {
    StandardDate standardDateByProvider = Provider.of<StandardDate>(context);

    if (!isSameDate(standardDate, standardDateByProvider.standardDate)) {
      standardDate = standardDateByProvider.standardDate; //날짜 변경

      _fetchTodos();
    }
    return FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Expanded(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(80),
                    ),
                    const Text(
                      '아직 입력된 투두가 없어요!\n 버튼을 눌러 투두를 추가해주세요!',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        //Todo 추가
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    )
                  ],
                ),
              );
            } else {
              return const Text('완료');
            }
          } else {
            return const Text('미완료');
          }
        });
  }

  bool isSameDate(DateTime? d1, DateTime? d2) {
    if (d1?.year == d2?.year && d1?.month == d2?.month && d1?.day == d2?.day) {
      return true;
    }

    return false;
  }
}
