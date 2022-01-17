import 'package:flutter/material.dart';

import '../../../providers/providers.dart';
import '../../../utilities/utilities.dart';
import '../../models.dart';

class TaskManagementHomePageModel extends ChangeNotifier {
  TaskManagementHomePageModel({
    required this.todoProvider,
  }) {
    nameController.text = "";
    memoController.text = "";
  }

  final ManagementDataProvider todoProvider;
  final nameController = TextEditingController();
  final memoController = TextEditingController();

  List<ManagementItemData> get todoList => todoProvider.managementDataList;

  void deleteTodo(int id) {
    todoProvider.deleteManagementItemData(id);
    notifyListeners();
  }

  void toggleTodoCompletion(TodoItemData togglingCompletionTodo) {
    final isCompleted = reverseCompletion(togglingCompletionTodo.isCompleted);
    final createdAt = togglingCompletionTodo.createdAt;
    final completedAt = getCompletionStatus(isCompleted)
        ? DateTime.now().toIso8601String()
        : "";
    final updatedTodo = togglingCompletionTodo.copyWith(
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
    todoProvider.updateManagementItemData(updatedTodo);
    notifyListeners();
  }
}
