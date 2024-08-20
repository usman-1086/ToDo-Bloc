import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo/to_do_bloc.dart';
import '../bloc/todo/to_do_event.dart';
import '../bloc/todo/to_do_state.dart';
import '../widgets/todo_items_widgets.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        buildWhen: (previous, current) => current is TodoLoadSuccess,
        builder: (context, state) {
          if (state is TodoLoadSuccess) {
            if (state.todos.isEmpty) {
              return const Center(
                child: Text('No to-dos yet. Add some!'),
              );
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: () {
                    context
                        .read<TodoBloc>()
                        .add(ToggleTodoCompletion(id: todo.id));
                  },
                  onDelete: () {
                    context
                        .read<TodoBloc>()
                        .add(DeleteTodo(id: todo.id));
                  },
                );
              },
            );
          }
          // Show a blank screen initially
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To-Do'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter to-do title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  context.read<TodoBloc>().add(AddTodo(
                    id: DateTime.now().toString(),
                    title: _controller.text,
                  ));
                  _controller.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
