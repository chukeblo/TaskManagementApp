import 'package:flutter/material.dart';

import '../../../providers/todo_provider.dart';
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
    final updatedTodo = togglingCompletionTodo.copyWith(
        isCompleted: !togglingCompletionTodo.isCompleted);
    todoProvider.updateTodo(updatedTodo);
    notifyListeners();
  }
}
