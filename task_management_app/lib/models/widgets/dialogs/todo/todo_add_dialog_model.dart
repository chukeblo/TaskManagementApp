import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';
import '../../../../utilities/utilities.dart';

class TodoAddDialogModel extends ChangeNotifier {
  TodoAddDialogModel({
    required this.todoProvider,
  }) {
    titleController.text = "";
    tagController.text = "";
    memoController.text = "";
  }

  final ManagementDataProvider todoProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void addTodo() {
    final todo = TodoItemData(
      id: todoProvider.managementDataList.length,
      title: titleController.text,
      tag: tagController.text,
      isCompleted: intFalse,
      createdAt: DateTime.now().toIso8601String(),
      memo: memoController.text,
    );

    todoProvider.addManagementItemData(todo);
    notifyListeners();
  }
}
