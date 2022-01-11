import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TodoEditDialogModel extends ChangeNotifier {
  TodoEditDialogModel({
    required this.todoProvider,
    required String title,
    String memo = "",
  }) {
    titleController.text = title;
    memoController.text = memo;
  }

  final TodoProvider todoProvider;
  final titleController = TextEditingController();
  final memoController = TextEditingController();

  void editTodo(TodoItemData editingTodo) {
    final updatedTodo = editingTodo.copyWith(
      title: titleController.text,
      memo: memoController.text,
    );
    todoProvider.updateTodo(updatedTodo);
    notifyListeners();
  }
}
