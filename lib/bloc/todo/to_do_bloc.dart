import 'package:bloc/bloc.dart';
import 'package:todo_bloc/bloc/todo/to_do_event.dart';
import 'package:todo_bloc/bloc/todo/to_do_state.dart';

import '../../models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoadInProgress()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<ToggleTodoCompletion>(_onToggleTodoCompletion);
    on<DeleteTodo>(_onDeleteTodo);
  }

  // Initial loading of todos
  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) {
    emit(TodoLoadSuccess());
  }

  // Handling the addition of a new todo
  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    if (state is TodoLoadSuccess) {
      final currentState = state as TodoLoadSuccess;
      final updatedTodos = List<Todo>.from(currentState.todos)
        ..add(Todo(id: event.id, title: event.title));
      emit(TodoLoadSuccess(updatedTodos));
    }
  }

  // Handling the toggling of a todo's completion status
  void _onToggleTodoCompletion(ToggleTodoCompletion event, Emitter<TodoState> emit) {
    if (state is TodoLoadSuccess) {
      final currentState = state as TodoLoadSuccess;
      final updatedTodos = currentState.todos.map((todo) {
        return todo.id == event.id
            ? todo.copyWith(isCompleted: !todo.isCompleted)
            : todo;
      }).toList();
      emit(TodoLoadSuccess(updatedTodos));
    }
  }

  // Handling the deletion of a todo
  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    if (state is TodoLoadSuccess) {
      final currentState = state as TodoLoadSuccess;
      final updatedTodos = currentState.todos.where((todo) => todo.id != event.id).toList();
      emit(TodoLoadSuccess(updatedTodos));
    }
  }
}
