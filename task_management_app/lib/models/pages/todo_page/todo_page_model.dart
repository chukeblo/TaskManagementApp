import 'package:flutter/material.dart';

import '../../../providers/providers.dart';
import '../../../utilities/utilities.dart';
import '../../models.dart';

class TodoPageModel extends ChangeNotifier {
  TodoPageModel({
    required this.todoProvider,
  });

  final ManagementDataProvider todoProvider;

  List<ManagementItemData> get todoList => todoProvider.managementDataList;

  void deleteTodo(int id) {
    todoProvider.deleteManagementItemData(id);
    notifyListeners();
  }

  void toggleTodoCompletion(ManagementItemData togglingCompletionTodo) {
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
