import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/todo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

var databaseProvider = Provider<DatabaseController>(
        (ref) {
          return DatabaseController(
          );});

class DatabaseController  {
    static final DatabaseController db = DatabaseController();
   Database? _database;
 // final read ;
 //  DatabaseController(this.read);

  Future<Database?> get database async{
    if(_database !=null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    return await openDatabase(join(await getDatabasesPath(),"todo.db"),
    onCreate: (db,version)async{
      //new table
      await db.execute('''
      CREATE TABLE todo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      body TEXT,
      date DATE
      )''');
    },version: 1
    );
  }

  addNewTodo(TodoModel todo)async{
    final db = await database;
    db!.insert('todo', todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
 //    notifyListeners();
  }

  Future<dynamic> getTodo() async{
    final db = await database;
    var res = await db!.query('todo');
    if(res.isEmpty){
      return null;
    }else{
      var resultMap=res.toList();
       // read.setList(resultMap);
   //   notifyListeners();
      return  resultMap.isNotEmpty ? resultMap:null;
    }
  }


  Future<int> deleteTodo(int id) async{
    final db =  await database;
    var res  = await db!.rawDelete("DELETE FROM todo WHERE id = ?",[id]);

    return res;

  }
}











































































































































//
//
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:to_do_app/models/todo_model.dart';
//
// class NewScreen extends HookConsumerWidget {
//   const NewScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final watchState = ref.watch(aProvider);
//
//     return Scaffold(
//       body: ListView.builder(
//           itemCount: watchState.todoModelList.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(
//                   "${watchState.todoModelList[index].title} ${watchState.todoModelList[index].id}"),
//               subtitle: Text(watchState.todoModelList[index].body ?? ''),
//               trailing: IconButton(
//                 icon: const Icon(Icons.delete),
//                 onPressed: () {
//                   ref
//                       .read(aProvider.notifier)
//                       .deleteItem(watchState.todoModelList[index]);
//                 },
//               ),
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           ref
//               .read(aProvider.notifier)
//               .addItem(TodoModel(title: "Testing", body: "Ayush Testing Todo"));
//         },
//       ),
//     );
//   }
// }
//
// final aProvider = StateNotifierProvider.autoDispose<A, TestState>(
//       (ref) => A(
//     TestState(
//       List<TodoModel>.empty(),
//       List<int>.empty(growable: true),
//     ),
//   ),
// );
//
// class TestState {
//   final List<TodoModel> todoModelList;
//   final List<int> testList;
//
//   TestState(this.todoModelList, this.testList);
// }
//
// class A extends StateNotifier<TestState> {
//   A(super.state) {
//     getTodo();
//   }
//
//   Database? database;
//
//   Future<Database?> databaseCall() async {
//     database = await initDb();
//     return database;
//   }
//
//   initDb() async {
//     return await openDatabase(join(await getDatabasesPath(), 'todo1.db'),
//         onCreate: (db, version) async {
//           //new table
//           await db.execute('''
//       CREATE TABLE todo1(
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       title TEXT,
//       body TEXT,
//       date DATE
//       )''');
//         }, version: 1);
//   }
//
//   void addItem(TodoModel i) async {
//     final db = await databaseCall();
//     db!.insert('todo1', i.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     getTodo();
//   }
//
//   void deleteItem(TodoModel todoModel) async {
//     final db = await databaseCall();
//     await db!.rawDelete("DELETE FROM todo1 WHERE id = ?", [todoModel.id]);
//     getTodo();
//   }
//
//   void getTodo() async {
//     final db = await databaseCall();
//     var res = await db!.query('todo1');
//         state = TestState(res.toList().map((e) => TodoModel.fromMap(e)).toList(),[1,2]);
//   }
// }
//
//
//
//
//
//








//copy2
// var databaseProvider = ChangeNotifierProvider<DatabaseController>(
//         (ref) {
//       return DatabaseController();});
//
// class DatabaseController extends ChangeNotifier{
//
//   // static final DatabaseController db = DatabaseController();
//   static Database? _database;
//
//   Future<Database?> get database async{
//     if(_database !=null){
//       return _database;
//     }
//     _database = await initDB();
//     return _database;
//   }
//
//   initDB() async{
//     return await openDatabase(join(await getDatabasesPath(),"todo.db"),
//         onCreate: (db,version)async{
//           //new table
//           await db.execute('''
//       CREATE TABLE todo(
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       title TEXT,
//       body TEXT,
//       date DATE
//       )''');
//         },version: 1
//     );
//   }
//
//   addNewTodo(TodoModel todo)async{
//     final db = await database;
//     db!.insert('todo', todo.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     notifyListeners();
//   }
//
//   Future<dynamic> getTodo() async{
//     final db = await database;
//     var res = await db!.query('todo');
//     if(res.isEmpty){
//       return null;
//     }else{
//       var resultMap=res.toList();
//       notifyListeners();
//       return resultMap.isNotEmpty ? resultMap:null;
//     }
//   }
//
//   Future<int> deleteTodo(int id) async{
//     final db =  await database;
//     var res  = await db!.rawDelete("DELETE FROM todo WHERE id = ?",[id]);
//     notifyListeners();
//     return res;
//
//   }
// }





























//
// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:to_do_app/models/todo_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// var databaseProvider = StateNotifierProvider.autoDispose<DatabaseController,TodoModel>(
//         (ref) {
//       return DatabaseController(TodoModel());});
//
// class DatabaseController extends StateNotifier<TodoModel>{
//
//   // static final DatabaseController db = DatabaseController();
//   static Database? _database;
//
//   DatabaseController(super.state);
//   Future<Database?> get database async{
//     if(_database !=null){
//       return _database;
//     }
//     _database = await initDB();
//     return _database;
//   }
//
//   initDB() async{
//     return await openDatabase(join(await getDatabasesPath(),"todo.db"),
//         onCreate: (db,version)async{
//           //new table
//           await db.execute('''
//       CREATE TABLE todo(
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       title TEXT,
//       body TEXT,
//       date DATE
//       )''');
//         },version: 1
//     );
//   }
//
//   addNewTodo(TodoModel todo)async{
//     final db = await database;
//     db!.insert('todo', todo.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<dynamic> getTodo() async{
//     final db = await database;
//     var res = await db!.query('todo');
//     if(res.isEmpty){
//       return null;
//     }else{
//       var resultMap=res.toList();
//       return resultMap.isNotEmpty ? resultMap:null;
//     }
//   }
//
//   Future<int> deleteTodo(int id) async{
//     final db =  await database;
//     var res  = await db!.rawDelete("DELETE FROM todo WHERE id = ?",[id]);
//     return res;
//   }
// }