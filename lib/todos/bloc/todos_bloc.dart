import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_hive_bloc/services/todo.dart';
import '../../model/task.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emitter) {
      final todos = _todoService.getTasks(event.username);

      emit(TodosLoadedState(todos));
    });
  }
}
