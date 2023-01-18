import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo_model.dart';

class OpenTodo extends StatelessWidget {
  const OpenTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final TodoModel todo = ModalRoute.of(context)!.settings.arguments as TodoModel;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(todo.title.toString()),
          Text(todo.body.toString())
        ],
      ),
    );
  }
}
