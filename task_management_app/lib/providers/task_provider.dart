import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import '../utilities/utilities.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider({
    required this.database,
  }) {
    initialize();
  }

  final Database database;
  List<TaskItemData> taskList = [];

  Future<void> initialize() async {
    taskList = await getTaskList(database);
  }

  Future<List<TaskItemData>> getTaskList(
    Database database,
  ) async {
    final List<Map<String, dynamic>> maps =
        await database.query(DatabaseConstants.tableTask);
    return List.generate(maps.length, (i) {
      return TaskItemData(
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

  Future<void> addTask(TaskItemData task) async {
    taskList.add(task);
    await database.insert(
      DatabaseConstants.tableTask,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateTask(TaskItemData newTask) async {
    final index = taskList.indexWhere((task) => task.id == newTask.id);
    taskList[index] = newTask;

    await database.update(
      DatabaseConstants.tableTask,
      newTask.toMap(),
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [newTask.id],
    );
    notifyListeners();
  }

  Future<void> deleteTask(int targetTaskId) async {
    final existingTaskIndex =
        taskList.indexWhere((task) => task.id == targetTaskId);

    if (existingTaskIndex == -1) {
      return;
    }

    await database.delete(
      DatabaseConstants.tableTodo,
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [targetTaskId],
    );

    _shrinkAndSynchronizeDatabase(existingTaskIndex + 1);
    taskList.removeAt(existingTaskIndex);
    notifyListeners();
  }

  void _shrinkAndSynchronizeDatabase(int startIndex) async {
    for (var index = startIndex; index < taskList.length; index++) {
      final task = taskList[index].copyWith(
        id: index - 1,
      );
      taskList[index] = task;
      await database.update(
        DatabaseConstants.tableTask,
        task.toMap(),
        where: "${DatabaseConstants.columnId} = ?",
        whereArgs: [task.id],
      );
    }
  }
}
