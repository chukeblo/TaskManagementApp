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
    _title = title;
    _memo = memo;
  }

  final TodoProvider todoProvider;
  final titleController = TextEditingController();
  final memoController = TextEditingController();

  late String _title = "";
  late String _memo = "";

  void editTodo(TodoItemData editingTodo) {
    final updatedTodo = editingTodo.copyWith(title: _title, memo: _memo);
    todoProvider.updateTodo(updatedTodo);
    notifyListeners();
  }

  void onTitleChanged(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void onMemoChanged(String text) {
    _memo = text;
    notifyListeners();
  }
}
