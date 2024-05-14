import 'package:flutter/material.dart';
import 'package:todolist/widget/create_todo_sheet.dart';

class NotExistWidget extends StatelessWidget {
  final Function insertTodo;
  const NotExistWidget({super.key, required this.insertTodo});

  @override
  Widget build(BuildContext context) {
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
              showCreateTodoBottomShteet(
                  context: context, insertTodo: insertTodo);
            },
            icon: const Icon(
              Icons.add_circle_outline,
            ),
          )
        ],
      ),
    );
  }
}
