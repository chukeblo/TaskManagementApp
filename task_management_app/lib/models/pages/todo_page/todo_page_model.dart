import 'package:flutter/material.dart';

import '../../../providers/providers.dart';
import '../../models.dart';

class TodoPageModel extends ChangeNotifier {
  TodoPageModel({
    required this.todoProvider,
  });

  final TodoProvider todoProvider;

  List<TodoItemData> get todoList => todoProvider.todoList;

  void deleteTodo(int id) {
    todoProvider.deleteTodo(id);
    notifyListeners();
  }

  void toggleTodoCompletion(TodoItemData togglingCompletionTodo) {
    final isCompleted =
        TodoItemData.reverseCompletion(togglingCompletionTodo.isCompleted);
    final createdAt = togglingCompletionTodo.createdAt;
    final completedAt = TodoItemData.getCompletionStatus(isCompleted)
        ? DateTime.now().toIso8601String()
        : "";
    final updatedTodo = togglingCompletionTodo.copyWith(
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
    todoProvider.updateTodo(updatedTodo);
    notifyListeners();
  }
}
