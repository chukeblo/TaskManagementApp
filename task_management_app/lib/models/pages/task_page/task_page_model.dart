import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../../utilities/utilities.dart';

class TaskPageModel extends ChangeNotifier {
  TaskPageModel({
    required this.taskProvider,
  });

  final ManagementDataProvider taskProvider;

  List<ManagementItemData> get taskList => taskProvider.managementDataList;

  void deleteTask(int id) {
    taskProvider.deleteManagementItemData(id);
    notifyListeners();
  }

  void toggleTaskCompletion(ManagementItemData togglingCompletionTask) {
    final isCompleted = reverseCompletion(togglingCompletionTask.isCompleted);
    final createdAt = togglingCompletionTask.createdAt;
    final completedAt = getCompletionStatus(isCompleted)
        ? DateTime.now().toIso8601String()
        : "";
    final updatedTodo = togglingCompletionTask.copyWith(
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
    taskProvider.updateManagementItemData(updatedTodo);
    notifyListeners();
  }
}
