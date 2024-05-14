import 'package:flutter/material.dart';
import 'package:todolist/model/to_do.dart';
import 'package:todolist/widget/create_todo_sheet.dart';
import 'package:todolist/widget/per_todo.dart';

class ExistTodoWidget extends StatelessWidget {
  final Function insertTodo;
  final Function updateTodo;
  final List<Todo> todos;
  const ExistTodoWidget(
      {super.key,
      required this.insertTodo,
      required this.todos,
      required this.updateTodo});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              IconButton(
                onPressed: () {
                  showCreateTodoBottomShteet(
                      context: context, insertTodo: insertTodo);
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
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return PerToDo(
                todo: todos[index],
                onDoubleTap: (Todo todo) async {
                  await updateTodo(todo);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
