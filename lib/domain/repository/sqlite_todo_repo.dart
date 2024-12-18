import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bloc_demo/domain/models/todo.dart';
import 'package:bloc_demo/domain/repository/todo_repo.dart';

class SqfliteTodoRepo extends TodoRepo {
  late Database db;

  Future<void> init() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, text TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<List<Todo>> getTodos() async {
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        text: maps[i]['text'],
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  @override
  Future<void> addTodo(Todo newTodo) async {
    await db.insert(
      'todos',
      {
        'id': newTodo.id,
        'text': newTodo.text,
        'isCompleted': newTodo.isCompleted ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await db.update(
      'todos',
      {
        'text': todo.text,
        'isCompleted': todo.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}
