import 'package:go_router/go_router.dart';
import 'package:todolist/screen/splash_screen.dart';
import 'package:todolist/screen/todo_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/todo',
      name: 'todo',
      builder: (context, state) => ToDoScreen(),
    ),
  ],
);
