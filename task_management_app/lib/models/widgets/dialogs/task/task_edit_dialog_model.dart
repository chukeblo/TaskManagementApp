import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TaskEditDialogModel extends ChangeNotifier {
  TaskEditDialogModel({
    required this.taskProvider,
    required String title,
    String tag = "",
    String memo = "",
  }) {
    titleController.text = title;
    tagController.text = tag;
    memoController.text = memo;
  }

  final TaskProvider taskProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void editTask(TaskItemData editingTask) {
    final updatedTask = editingTask.copyWith(
      title: titleController.text,
      tag: tagController.text,
      memo: memoController.text,
    );
    taskProvider.updateTask(updatedTask);
    notifyListeners();
  }
}
