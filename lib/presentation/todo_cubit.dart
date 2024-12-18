import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_demo/domain/models/todo.dart';
import 'package:bloc_demo/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]);

  Future<void> loadTodos() async {
    final todos = await todoRepo.getTodos();
    emit(todos);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );
    await todoRepo.addTodo(newTodo);
    await loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    await todoRepo.updateTodo(updatedTodo);
    await loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    await loadTodos();
  }
}
