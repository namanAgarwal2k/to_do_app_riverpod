import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/todo_model.dart';

class NewScreen extends HookConsumerWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchState = ref.watch(aProvider);

    return Scaffold(
      body: ListView.builder(
          itemCount: watchState.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${watchState[index].title} "),
              subtitle: Text(watchState[index].body ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(aProvider.notifier).deleteItem(watchState[index]);
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/NewTodo");
        },
      ),
    );
  }
}

final aProvider =
    StateNotifierProvider.autoDispose<A, List<TodoModel>>((ref) => A(
          List<TodoModel>.empty(),
        ));
class Test{
  final List<TodoModel> todoModelList;
  final List<int> testList;

  Test(this.todoModelList, this.testList);
}
class A extends StateNotifier<List<TodoModel>> {
  A(super.state){
    getTodo();
  }

  Database? database;

  Future<Database?> databaseCall() async {
    database = await initDb();
    return database;
  }

  initDb() async {
    return await openDatabase(join(await getDatabasesPath(), 'todo1.db'),
        onCreate: (db, version) async {
      //new table
      await db.execute('''
      CREATE TABLE todo1(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      body TEXT,
      date DATE
      )''');
    }, version: 1);
  }

  void addItem(TodoModel i) async {
    final db = await databaseCall();
    db!.insert('todo1', i.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    getTodo();
  }

  void deleteItem(TodoModel todoModel) async {
    final db = await databaseCall();
    await db!.rawDelete("DELETE FROM todo1 WHERE id = ?", [todoModel.id]);
    getTodo();
  }

  void getTodo() async {
    final db = await databaseCall();
    var res = await db!.query('todo1');
    state = res.toList().map((e) => TodoModel.fromMap(e)).toList();
  }
}
