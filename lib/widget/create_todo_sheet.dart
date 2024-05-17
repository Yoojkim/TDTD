import 'package:flutter/material.dart';
import 'package:todolist/const/color.dart';

///todo: Sized Box 고려
Future<T?> showCreateTodoBottomShteet<T>({
  required BuildContext context,
  required Function insertTodo,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      TextEditingController textEditingController = TextEditingController();

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'To do를 추가해주세요!',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(20.0),
                    labelText: 'To do',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primartColor,
                      ),
                    ),
                  ),
                  controller: textEditingController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (textEditingController.text.isEmpty) {
                    return;
                  }

                  await insertTodo(textEditingController
                      .text); // and then setState() in insertTodo Function

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primartColor,
                  foregroundColor: Colors.black,
                ),
                child: const Text('등록하기'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
