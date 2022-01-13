import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';

class TaskPageModel extends ChangeNotifier {
  TaskPageModel({
    required this.taskProvider,
  });

  final TaskProvider taskProvider;

  List<TaskItemData> get taskList => taskProvider.taskList;

  void deleteTask(int id) {
    taskProvider.deleteTask(id);
    notifyListeners();
  }

  void toggleTaskCompletion(TaskItemData togglingCompletionTask) {
    final isCompleted =
        TaskItemData.reverseCompletion(togglingCompletionTask.isCompleted);
    final createdAt = togglingCompletionTask.createdAt;
    final completedAt = TaskItemData.getCompletionStatus(isCompleted)
        ? DateTime.now().toIso8601String()
        : "";
    final updatedTodo = togglingCompletionTask.copyWith(
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
    taskProvider.updateTask(updatedTodo);
    notifyListeners();
  }
}
