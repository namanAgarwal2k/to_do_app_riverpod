import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/screens/my_home_page.dart';
import 'package:to_do_app/screens/new.dart';
import 'package:to_do_app/screens/open_todo.dart';
import 'screens/new_todo_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     initialRoute: '/',
      routes: {
       "/":(context)=>  NewScreen(),
        "/NewTodo":(context)=>  NewTodo(),
        "/OpenTodo":(context)=>  OpenTodo(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}


