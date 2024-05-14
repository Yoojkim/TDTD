import 'package:flutter/material.dart';
import 'package:todolist/const/color.dart';

///todo: Sized Box 고려
Future<T?> showCreateTodoBottomShteet<T>({
  required BuildContext context,
  required Function insertTodo,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      TextEditingController textEditingController = TextEditingController();

      return SafeArea(
        child: Container(
          width: 400,
          height: 250,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
              ),
              const Text(
                'To do를 추가해주세요!',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(20.0),
                      labelText: 'To do',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGreen,
                        ),
                      ),
                    ),
                    controller: textEditingController,
                  ),
                ),
              ),

              //todo: 아무 것도 입력되지 않을 때에는 활성화 되지 않도록
              ElevatedButton(
                onPressed: () async {
                  if (textEditingController.text.isEmpty) {
                    return;
                  }

                  await insertTodo(textEditingController
                      .text); // and then setState() in insertTodo Function

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  } // mount 검사해서 하면 된다고 하는데 ... <- 뭔지 알기
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreen,
                  foregroundColor: Colors.black,
                ),
                child: const Text('등록하기'),
              )
            ],
          ),
        ),
      );
    },
  );
}
