import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

// Define abstract TodoState
abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

// State for when todos are being loaded
class TodoLoadInProgress extends TodoState {}

// State for when todos have been loaded successfully
class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  const TodoLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];
}

// State for when loading todos fails
class TodoLoadFailure extends TodoState {}
