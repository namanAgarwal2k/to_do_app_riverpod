import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/models/todo_model.dart';

final stateControllerProvider = StateNotifierProvider.autoDispose<StateController,List<TodoModel>>(
        (ref) {
          return StateController(
             List<TodoModel>.empty()
          );
        });


class StateController extends StateNotifier<List<TodoModel>>{
  StateController(List<TodoModel> list) : super([]);


 setList(List<TodoModel> list){
   state = list;
 }
  addInList(TodoModel todo){
    state = [...state,todo];
  }


}