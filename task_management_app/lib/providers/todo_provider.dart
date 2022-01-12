import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import '../utilities/utilities.dart';

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
    final List<Map<String, dynamic>> maps =
        await database.query(DatabaseConstants.tableTodo);
    return List.generate(maps.length, (i) {
      return TodoItemData(
        id: maps[i][DatabaseConstants.columnId],
        title: maps[i][DatabaseConstants.columnTitle],
        tag: maps[i][DatabaseConstants.columnTag],
        isCompleted: maps[i][DatabaseConstants.columnIsCompleted],
        createdAt: maps[i][DatabaseConstants.columnCreatedAt],
        completedAt: maps[i][DatabaseConstants.columnCompletedAt],
        memo: maps[i][DatabaseConstants.columnMemo],
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
      DatabaseConstants.tableTodo,
      newTodo.toMap(),
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [newTodo.id],
    );
    notifyListeners();
  }

  // TODO: fix the way of pointing to the todo item to be deleted
  Future<void> deleteTodo(int targetTodoId) async {
    final existingTodoIndex =
        todoList.indexWhere((todo) => todo.id == targetTodoId);

    if (existingTodoIndex == -1) {
      return;
    }

    await database.delete(
      DatabaseConstants.tableTodo,
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [targetTodoId],
    );

    _shrinkAndSynchronizeDatabase(existingTodoIndex + 1);
    todoList.removeAt(existingTodoIndex);
    notifyListeners();
  }

  void _shrinkAndSynchronizeDatabase(int startIndex) async {
    for (var index = startIndex; index < todoList.length; index++) {
      final todo = todoList[index].copyWith(
        id: index - 1,
      );
      todoList[index] = todo;
      await database.update(
        DatabaseConstants.tableTodo,
        todo.toMap(),
        where: "${DatabaseConstants.columnId} = ?",
        whereArgs: [todo.id],
      );
    }
  }
}
