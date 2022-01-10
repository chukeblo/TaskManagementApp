import 'package:flutter/material.dart';

import '../../../providers/providers.dart';
import '../../models.dart';

class TaskManagementHomePageModel extends ChangeNotifier {
  TaskManagementHomePageModel({
    required this.todoProvider,
  }) {
    nameController.text = "";
    memoController.text = "";
  }

  final TodoProvider todoProvider;
  final nameController = TextEditingController();
  final memoController = TextEditingController();

  List<TodoItemData> get todoList => todoProvider.todoList;

  void deleteTodo(int id) {
    todoProvider.deleteTodo(id);
    notifyListeners();
  }

  void toggleTodoCompletion(TodoItemData togglingCompletionTodo) {
    final isCompleted = !togglingCompletionTodo.isCompleted;
    final createdAt = togglingCompletionTodo.createdAt;
    final completedAt = isCompleted ? DateTime.now().toIso8601String() : "";
    final updatedTodo = togglingCompletionTodo.copyWith(
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
    todoProvider.updateTodo(updatedTodo);
    notifyListeners();
  }
}
