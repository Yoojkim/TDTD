import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final int width;
  final int height;
  const Logo({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/image/logo.png',
      width: width.toDouble(),
      height: height.toDouble(),
    );
  }
}
