import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../utilities/utilities.dart';

class TaskProvider extends ManagementDataProvider {
  TaskProvider({
    required Database database,
  }) : super(database: database) {
    initialize();
  }

  @override
  Future<List<ManagementItemData>> getManagementDataList(
      Database database) async {
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

  @override
  Future<void> addManagementItemData(ManagementItemData data) async {
    managementDataList.add(data);
    await database.insert(
      DatabaseConstants.tableTask,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  @override
  Future<void> updateManagementItemData(ManagementItemData data) async {
    final index = managementDataList.indexWhere((task) => task.id == data.id);
    managementDataList[index] = data;

    await database.update(
      DatabaseConstants.tableTask,
      data.toMap(),
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [data.id],
    );
    notifyListeners();
  }

  @override
  Future<void> deleteManagementItemData(int id) async {
    final existingTaskIndex =
        managementDataList.indexWhere((task) => task.id == id);

    if (existingTaskIndex == -1) {
      return;
    }

    await database.delete(
      DatabaseConstants.tableTask,
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [id],
    );

    _shrinkAndSynchronizeDatabase(existingTaskIndex + 1);
    managementDataList.removeAt(existingTaskIndex);
    notifyListeners();
  }

  void _shrinkAndSynchronizeDatabase(int startIndex) async {
    for (var index = startIndex; index < managementDataList.length; index++) {
      final task = managementDataList[index].copyWith(
        id: index - 1,
      );
      managementDataList[index] = task;
      await database.update(
        DatabaseConstants.tableTask,
        task.toMap(),
        where: "${DatabaseConstants.columnId} = ?",
        whereArgs: [task.id],
      );
    }
  }
}
