import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/router/router.dart';
import 'package:todolist/state/standard_date_provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => StandardDate()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        )),
  );
}
