import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/component/logo.dart';
import 'package:todolist/const/color.dart';

//todo: 3초 뒤 Todo_Screen으로 이동
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
        context.go('/todo');
      },
    );

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Logo(width: 600, height: 600),
        SizedBox(
          width: 200.0,
          child: LinearProgressIndicator(
            minHeight: 20.0,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: primartColor,
          ),
        ),
      ]),
    );
  }
}
