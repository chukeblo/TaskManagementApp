import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TaskAddDialogModel extends ChangeNotifier {
  TaskAddDialogModel({
    required this.taskProvider,
  }) {
    titleController.text = "";
    tagController.text = "";
    memoController.text = "";
  }

  final TaskProvider taskProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void addTask() {
    final task = TaskItemData(
      id: taskProvider.taskList.length,
      title: titleController.text,
      tag: tagController.text,
      isCompleted: TodoItemData.intFalse,
      createdAt: DateTime.now().toIso8601String(),
      memo: memoController.text,
    );

    taskProvider.addTask(task);
    notifyListeners();
  }
}
