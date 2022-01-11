import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

class TodoProvider with ChangeNotifier {
  TodoProvider({
    required this.database,
  }) {
    initialize();
  }

  final Database database;
  List<TodoItemData> todoList = [];

  Future<void> initialize() async {
    todoList = await getTodoList(database);
  }

  Future<List<TodoItemData>> getTodoList(
    Database database,
  ) async {
    final List<Map<String, dynamic>> maps = await database.query("todo");
    return List.generate(maps.length, (i) {
      return TodoItemData(
        id: maps[i]["id"],
        title: maps[i]["title"],
        tag: maps[i]["tag"],
        isCompleted: maps[i]["isCompleted"],
        createdAt: maps[i]["createdAt"],
        completedAt: maps[i]["completedAt"],
        memo: maps[i]["memo"],
      );
    });
  }

  Future<void> addTodo(TodoItemData todo) async {
    todoList.add(todo);
    await database.insert(
      "todo",
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateTodo(TodoItemData newTodo) async {
    final index = todoList.indexWhere((todo) => todo.id == newTodo.id);
    todoList[index] = newTodo;

    await database.update(
      "todo",
      newTodo.toMap(),
      where: "id = ?",
      whereArgs: [newTodo.id],
    );
    notifyListeners();
  }

  // TODO: fix the way of pointing to the todo item to be deleted
  Future<void> deleteTodo(int targetTodoId) async {
    final existingTodoIndex =
        todoList.indexWhere((todo) => todo.id == targetTodoId);
    todoList.removeAt(existingTodoIndex);

    await database.delete(
      "todo",
      where: "id = ?",
      whereArgs: [targetTodoId],
    );
    notifyListeners();
  }
}
