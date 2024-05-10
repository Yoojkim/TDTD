import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screen/splash_screen.dart';
import 'package:todolist/state/standard_date_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StandardDate()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    ),
  );
}
