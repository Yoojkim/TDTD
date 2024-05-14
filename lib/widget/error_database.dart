import 'package:flutter/material.dart';

class DataBaseErrorWidget extends StatelessWidget {
  const DataBaseErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '현재 시스템에 문제가 있어요!\n빠른 시일 내에 고칠게요!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }
}
