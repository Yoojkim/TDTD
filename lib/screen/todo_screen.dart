import 'package:flutter/material.dart';
import 'package:todolist/component/logo.dart';
import 'package:todolist/widget/date_widget.dart';
import 'package:todolist/widget/todo_widget.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Logo(width: 30, height: 30),
        title: const Text('To do!'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          DateNavigator(
            today: today,
          ),
          const Padding(
            padding: EdgeInsets.all(
              5.0,
            ),
          ),
          ToDoList(),
        ],
      )),
    );
  }
}
