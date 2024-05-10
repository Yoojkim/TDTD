import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/database/database.dart';
import 'package:todolist/model/to_do.dart';
import 'package:todolist/state/standard_date_provider.dart';
import 'package:todolist/widget/per_todo.dart';

/*
전체적으로 추가할 사항
- Bottom Sheet에 해당하는 부분 분리 
- 이외에 코드 부족한 부분 정리
- 코드 정리 필수적으로 수행.
- null이 들어가는 부분 해결.
 */

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  DataBase? dataBase;

  @override
  void initState() {
    super.initState();
    dataBase = DataBase();
  }

  ///여기서 Provider에서 얻어낸 standardDate에 해당하는 투두리스트 출력
  @override
  Widget build(BuildContext context) {
    StandardDate standardDateByProvider = Provider.of<StandardDate>(context);

    return FutureBuilder<List<Todo>>(
        future: dataBase!.getTodoByDate(standardDateByProvider.standardDate),
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
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        TextEditingController textEditingController =
                            TextEditingController();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SafeArea(
                              child: Container(
                                width: 400,
                                height: 250,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                    ),
                                    Text(
                                      'To do를 추가해주세요!',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30, top: 30),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.all(20.0),
                                            labelText: 'To do',
                                          ),
                                          controller: textEditingController,
                                        ),
                                      ),
                                    ),

                                    //todo: 아무 것도 입력되지 않을 때에는 활성화 되지 않도록
                                    ElevatedButton(
                                      onPressed: () async {
                                        await dataBase!.insert(Todo(
                                            success: false,
                                            content: textEditingController.text,
                                            date: standardDateByProvider
                                                .standardDate,
                                            isDeleted: false));

                                        Navigator.of(context).pop();

                                        setState(() {});
                                      },
                                      child: Text('등록하기'),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    )
                  ],
                ),
              );
            } else {
              List<Todo> finalTodos = snapshot.data!;

              return Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        IconButton(
                          onPressed: () {
                            TextEditingController textEditingController =
                                TextEditingController();
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                  child: Container(
                                    width: 400,
                                    height: 250,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                        ),
                                        Text(
                                          'To do를 추가해주세요!',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 30, right: 30, top: 30),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(20.0),
                                                labelText: 'To do',
                                              ),
                                              controller: textEditingController,
                                            ),
                                          ),
                                        ),

                                        //todo: 아무 것도 입력되지 않을 때에는 활성화 되지 않도록
                                        ElevatedButton(
                                          onPressed: () async {
                                            await dataBase!.insert(Todo(
                                                success: false,
                                                content:
                                                    textEditingController.text,
                                                date: standardDateByProvider
                                                    .standardDate,
                                                isDeleted: false));

                                            Navigator.of(context).pop();

                                            setState(() {});
                                          },
                                          child: Text('등록하기'),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.format_list_bulleted_add),
                        ),
                        const Text('추가하기'),
                      ],
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: finalTodos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PerToDo(
                          todo: finalTodos[index],
                          onDoubleTap: (Todo todo) async {
                            await dataBase!.updateSuccess(todo);
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
              //todo: 여기에 listview
            }
          } else {
            return const Text(
              '현재 시스템에 문제가 있어요!\n빠른 시일 내에 고칠게요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            );
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
