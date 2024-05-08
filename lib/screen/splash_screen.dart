import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('asset/image/logo.png'),
        const SizedBox(
          width: 200.0,
          child: LinearProgressIndicator(
            minHeight: 20.0,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromRGBO(254, 204, 190, 100),
          ),
        ),
      ]),
    );
  }
}
