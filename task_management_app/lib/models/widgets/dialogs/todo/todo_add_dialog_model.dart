import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TodoAddDialogModel extends ChangeNotifier {
  TodoAddDialogModel({
    required this.todoProvider,
  }) {
    titleController.text = "";
    memoController.text = "";
  }

  final TodoProvider todoProvider;
  final titleController = TextEditingController();
  final memoController = TextEditingController();

  void addTodo() {
    final todo = TodoItemData(
      id: todoProvider.todoList.length,
      title: titleController.text,
      isCompleted: false,
      createdAt: DateTime.now().toIso8601String(),
      memo: memoController.text,
    );

    todoProvider.addTodo(todo);
    notifyListeners();
  }
}
