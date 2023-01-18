import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/models/database_provider.dart';
import 'package:to_do_app/models/state_controller.dart';
import 'package:to_do_app/models/todo_model.dart';
import 'package:to_do_app/screens/new.dart';

class NewTodo extends HookConsumerWidget {
     NewTodo({Key? key}) : super(key: key);

  String? title;
  String? description;
  DateTime? date;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final state = ref.read(stateControllerProvider);
    addTodo(TodoModel todoModel){
      state.add(todoModel);
      ref.read(databaseProvider).addNewTodo(todoModel);
    }

    return  Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:  [
             TextField(
               controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'TODO Title',
                hintStyle: TextStyle(color: Colors.grey)
              ),
               style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
            ),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Todo description'
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
       //   setState(() {
            title= titleController.text;
            description = descriptionController.text;
            date= DateTime.now();
         // }
            TodoModel todoModel = TodoModel(title: title,body: description);
           ref.read(aProvider.notifier).addItem(todoModel);

            // addTodo(todoModel);
            Navigator.pop(context);

        }, label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );

  }
}
































































// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:to_do_app/models/database_provider.dart';
// import 'package:to_do_app/models/todo_model.dart';
//
// class NewTodo extends HookConsumerWidget {
//   NewTodo({Key? key}) : super(key: key);
// //
// //   @override
// //   State<NewTodo> createState() => _NewTodoState();
// // }
// //
// // class _NewTodoState extends State<NewTodo> {
//
//   String? title;
//   String? description;
//   DateTime? date;
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     addTodo(TodoModel todoModel){
//       ref.read(databaseProvider.notifier).addNewTodo(todoModel);
//       //  DatabaseController.db.addNewTodo(todoModel);
//     }
//
//     return  Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children:  [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'TODO Title',
//                   hintStyle: TextStyle(color: Colors.grey)
//               ),
//               style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
//             ),
//             TextField(
//               controller: descriptionController,
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Todo description'
//               ),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: (){
//           setState(() {
//             title= titleController.text;
//             description = descriptionController.text;
//             date= DateTime.now();
//           });
//           TodoModel todoModel = TodoModel(title: title,body: description,date: date);
//           addTodo(todoModel);
//           Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
//
//         }, label: const Text("Save"),
//         icon: const Icon(Icons.save),
//       ),
//     );
//
//   }
// }