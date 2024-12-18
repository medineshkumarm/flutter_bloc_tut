import 'package:bloc_demo/presentation/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_demo/presentation/todo_cubit.dart';
import 'package:bloc_demo/presentation/todo_view.dart';

import 'domain/repository/sqlite_todo_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todoRepo = SqfliteTodoRepo();
  await todoRepo.init();

  runApp(MyApp(todoRepo: todoRepo));
}

class MyApp extends StatelessWidget {
  final SqfliteTodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => TodoCubit(todoRepo)..loadTodos(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TodoPage(todoRepo: todoRepo),
        ),
      ),
    );
  }
}

// import 'package:bloc_demo/data/isar_todo.dart';
// import 'package:bloc_demo/domain/repository/isar_todo_repo.dart';
// import 'package:bloc_demo/domain/repository/todo_repo.dart';
// import 'package:bloc_demo/presentation/todo_page.dart';
// import 'package:flutter/material.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // get directory path from storing data
//   final dir = await getApplicationDocumentsDirectory();
//
//   // open isar db
//   final isar = await Isar.open([TodoIsarSchema],
//       directory: dir.path);
//
//   // intialise the repo with isar db
//   final isarTodoRepo = IsarTodoRepo(isar);
//
//   runApp(
//       MyApp(todoRepo: isarTodoRepo,)
//   );
// }
//
// class MyApp extends StatelessWidget {
//   // db injections through the app
//   final TodoRepo todoRepo;
//
//   const MyApp({super.key,required this.todoRepo});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//       home: TodoPage(todoRepo: todoRepo),
//     );
//   }
// }
