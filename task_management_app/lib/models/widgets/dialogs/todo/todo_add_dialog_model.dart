import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/todo_provider.dart';

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

  late String _title;
  late String _memo = "";

  void addTodo() {
    final todo = TodoItemData(
      id: todoProvider.todoList.length,
      title: _title,
      isCompleted: false,
      createdAt: DateTime.now().toIso8601String(),
      memo: _memo,
    );

    todoProvider.addTodo(todo);
    notifyListeners();
  }

  void onTitleChanged(String text) {
    _title = text;
    notifyListeners();
  }

  void onMemoChanged(String text) {
    _memo = text;
    notifyListeners();
  }
}
