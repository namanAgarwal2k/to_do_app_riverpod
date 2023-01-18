import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/database_provider.dart';
import '../models/todo_model.dart';

// final futureProvider = FutureProvider<int>((ref)async
// {  return ref.watch(databaseProvider).deleteTodo(id);
// }
// );
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final readState = ref.read(databaseProvider);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('TO-Do APP'),
      ),
      body: FutureBuilder(
        future: DatabaseController.db.getTodo(),
        builder: (context, AsyncSnapshot todoData) {
          if (todoData.connectionState == ConnectionState.done) {
            if (todoData.data == null) {
              // print(todoData.data);
              return const Center(
                child: Text("You don't have any task yet"),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: todoData.data.length,
                  itemBuilder: (context, index) {
                    String title = todoData.data[index]['title'];
                    String body = todoData.data[index]['body'];
                    //        String date = todoData.data[index]['date'];
                    int id = todoData.data[index]['id'];
                    return Card(
                      child: ListTile(
                        onTap: ()  {
                           Navigator.pushNamed(
                            context,
                            "/OpenTodo",
                            arguments: TodoModel(
                              title: title,
                              body: body,
                            ),
                          );
                        },
                        title: Text(title),
                        subtitle: Text(body),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              DatabaseController.db.deleteTodo(id);
                            });
                            // ref.watch(databaseProvider).deleteTodo(id);

                            // setState(() {
                            //   DatabaseProvider.db.deleteTodo(id);
                            // });
                          },
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/NewTodo");
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../models/database_provider.dart';
// import '../models/todo_model.dart';
// class MyHomePage extends  HookConsumerWidget {
//   const MyHomePage({super.key,  this.title});
//
//   final String? title;
//
//
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//     final state = ref.read(databaseProvider.notifier);
//
//     getTodo() async{
//       final todo = state.getTodo();
//       //  final todo = await DatabaseController.db.getTodo();
//       return todo;
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         title:const Text( 'TO-Do APP'),
//       ),
//       body:
//       FutureBuilder(
//         future: ref.watch(databaseProvider.notifier).getTodo(),
//         builder: (context,AsyncSnapshot todoData){
//           if(todoData.connectionState == ConnectionState.done)  {
//             if(todoData.data == null) {
//               // print(todoData.data);
//               return const Center(child: Text("You don't have any task yet"),);
//             }else {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GridView.builder(
//                   itemCount:todoData.data.length,
//                   itemBuilder: (context,index){
//                     String title = todoData.data[index]['title'];
//                     String body = todoData.data[index]['body'];
//                     //        String date = todoData.data[index]['date'];
//                     int id = todoData.data[index]['id'];
//                     return Card(
//                       child: ListTile(
//                         onTap: (){
//                           Navigator.pushNamed(context,"/OpenTodo", arguments:TodoModel(
//                             title: title,
//                             body: body,
//                           ) );
//                         },
//                         title: Text(title),
//                         subtitle: Text(body),
//
//                         trailing: IconButton(
//                           icon:const Icon(Icons.delete), onPressed: () {
//                           state.deleteTodo(id);
//                           // setState(() {
//                           //   DatabaseProvider.db.deleteTodo(id);
//                           // });
//                         },
//                         ),
//                       ),
//                     );
//                   }, gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                 ),
//               );
//             }
//           }
//           else{
//             return const CircularProgressIndicator();
//           }
//         },
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           Navigator.pushNamed(context,"/NewTodo");
//         },
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
