import 'package:bloc_demo/domain/models/todo.dart';
import 'package:bloc_demo/presentation/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  //show dialog box for user to type
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //   cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),

          //   add button
          TextButton(
              onPressed: () {
                todoCubit.addTodo(textController.text.trim());
                Navigator.of(context).pop();
              },
              child: const Text('Add'))
        ],
      ),
    );
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    // todo cubit
    final todoCubit = context.read<TodoCubit>();
    //     SCAFFOLD
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBox(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          //   list view
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              //   get individual todo from todo list
              final todo = todos[index];

              //   list title UI
              return ListTile(
                title: Text(todo.text),

                //   check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),

                //   delete button
                trailing: IconButton(
                    onPressed: () => todoCubit.deleteTodo(todo),
                    icon: const Icon(Icons.cancel)),
              );
            },
          );
        },
      ),
    );
  }
}
