import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/database/database.dart';
import 'package:todolist/model/to_do.dart';
import 'package:todolist/state/standard_date_provider.dart';
import 'package:todolist/widget/error_database.dart';
import 'package:todolist/widget/exist_todo.dart';
import 'package:todolist/widget/loading_widget.dart';
import 'package:todolist/widget/not_exist_todo.dart';

/*
전체적으로 추가할 사항
- Bottom Sheet에 해당하는 부분 분리 
- 이외에 코드 부족한 부분 정리
- 코드 정리 필수적으로 수행.
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
    StandardDate standardDate = Provider.of<StandardDate>(context);

    return FutureBuilder<List<Todo>>(
        future: dataBase!.getTodoByDate(standardDate.standardDate),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return NotExistWidget(
                insertTodo: insertTodo,
              );
            } else {
              List<Todo> todos = snapshot.data!;
              return ExistTodoWidget(
                insertTodo: insertTodo,
                updateTodo: updateTodo,
                todos: todos,
              );
            }
          } else if (snapshot.hasError) {
            return const DataBaseErrorWidget();
          } else {
            return const LoadingWidget();
          }
        });
  }

  //Todo 내용을 insert하고 현재 todo_widget을 재build 하는 것
  void insertTodo(String content) async {
    Todo todo = Todo(
        success: false,
        content: content,
        date: DateTime.now(),
        isDeleted: false);

    await dataBase!.insert(todo);

    setState(() {});
  }

  ///Todo 내용 업데이트 후 현재 todo_widget 재build
  void updateTodo(Todo todo) async {
    await dataBase!.updateSuccess(todo);

    setState(() {});
  }

  bool isSameDate(DateTime? d1, DateTime? d2) {
    if (d1?.year == d2?.year && d1?.month == d2?.month && d1?.day == d2?.day) {
      return true;
    }

    return false;
  }
}
