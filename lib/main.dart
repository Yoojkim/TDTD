import 'package:flutter/material.dart';
import 'package:todolist/screen/splash_screen.dart';
import 'package:todolist/screen/to_do_list.dart';

void main() {
  //todo: 데이터베이스 정의
  runApp(MaterialApp(
    home: ToDoScreen(),
  ));
}
