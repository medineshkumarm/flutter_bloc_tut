import 'package:bloc_demo/data/isar_todo.dart';
import 'package:bloc_demo/domain/repository/todo_repo.dart';
import 'package:isar/isar.dart';

import '../models/todo.dart';

class IsarTodoRepo extends TodoRepo{

  //database
  final Isar db;

  IsarTodoRepo(this.db);

  //get todos
  @override
  Future<List<Todo>> getTodos() async {
      final todos = await db.todoIsars.where().findAll();
      return todos.map((todoIsar) =>todoIsar.toDomain()).toList();
  }

  //add todo
@override
  Future<void> addTodo(Todo newTodo) {

    final todoIsar = TodoIsar.fromDomain(newTodo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> updateTodo(Todo todo) {
    final todoIsar = TodoIsar.fromDomain(todo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));

  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return db.writeTxn(() => db.todoIsars.delete(todo.id));
  }

}


