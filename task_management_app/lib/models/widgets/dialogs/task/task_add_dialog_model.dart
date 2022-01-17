import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';
import '../../../../utilities/utilities.dart';

class TaskAddDialogModel extends ChangeNotifier {
  TaskAddDialogModel({
    required this.taskProvider,
  }) {
    titleController.text = "";
    tagController.text = "";
    memoController.text = "";
  }

  final ManagementDataProvider taskProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void addTask() {
    final task = TaskItemData(
      id: taskProvider.managementDataList.length,
      title: titleController.text,
      tag: tagController.text,
      isCompleted: intFalse,
      createdAt: DateTime.now().toIso8601String(),
      memo: memoController.text,
    );

    taskProvider.addManagementItemData(task);
    notifyListeners();
  }
}
