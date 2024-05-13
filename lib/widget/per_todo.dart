import 'package:flutter/material.dart';
import 'package:todolist/model/to_do.dart';

//개별 todo(row에 해당)을 나타내는 클래스
class PerToDo extends StatefulWidget {
  Todo todo;
  Function onDoubleTap;
  PerToDo({super.key, required this.todo, required this.onDoubleTap});

  @override
  State<PerToDo> createState() => _PerToDoState();
}

class _PerToDoState extends State<PerToDo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onDoubleTap: () {
              widget.onDoubleTap(widget.todo);
            },
            child: IconButton(
              onPressed: null,
              icon: widget.todo.success
                  ? Icon(Icons.task_alt)
                  : Icon(Icons.radio_button_unchecked),
            ),
          ),
          Expanded(child: Text(widget.todo.content)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
        ],
      ),
    );
  }
}
