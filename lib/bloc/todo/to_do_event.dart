import 'package:equatable/equatable.dart';

// Define abstract TodoEvent
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

// Event to load initial todos
class LoadTodos extends TodoEvent {}

// Event to add a new todo
class AddTodo extends TodoEvent {
  final String id;
  final String title;

  const AddTodo({required this.id, required this.title});

  @override
  List<Object> get props => [id, title];
}

// Event to toggle a todo's completion status
class ToggleTodoCompletion extends TodoEvent {
  final String id;

  const ToggleTodoCompletion({required this.id});

  @override
  List<Object> get props => [id];
}

// Event to delete a todo
class DeleteTodo extends TodoEvent {
  final String id;

  const DeleteTodo({required this.id});

  @override
  List<Object> get props => [id];
}
