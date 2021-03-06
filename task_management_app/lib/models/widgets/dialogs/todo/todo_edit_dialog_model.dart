import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TodoEditDialogModel extends ChangeNotifier {
  TodoEditDialogModel({
    required this.todoProvider,
    required String title,
    String tag = "",
    String memo = "",
  }) {
    titleController.text = title;
    tagController.text = tag;
    memoController.text = memo;
  }

  final ManagementDataProvider todoProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void editTodo(ManagementItemData editingTodo) {
    final updatedTodo = editingTodo.copyWith(
      title: titleController.text,
      tag: tagController.text,
      memo: memoController.text,
    );
    todoProvider.updateManagementItemData(updatedTodo);
    notifyListeners();
  }
}
