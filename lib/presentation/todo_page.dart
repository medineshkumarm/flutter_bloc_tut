import 'package:bloc_demo/domain/repository/todo_repo.dart';
import 'package:bloc_demo/presentation/todo_cubit.dart';
import 'package:bloc_demo/presentation/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo;

  const TodoPage({super.key, required this.todoRepo});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TodoCubit(todoRepo),
    child: const TodoView(),
    );
  }
}
