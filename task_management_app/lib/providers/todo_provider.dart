import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../utilities/utilities.dart';

class TodoProvider extends ManagementDataProvider {
  TodoProvider({
    required Database database,
  }) : super(database: database) {
    initialize();
  }

  @override
  Future<List<ManagementItemData>> getManagementDataList(
      Database database) async {
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

  @override
  Future<void> addManagementItemData(ManagementItemData data) async {
    managementDataList.add(data);
    await database.insert(
      DatabaseConstants.tableTodo,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  @override
  Future<void> updateManagementItemData(ManagementItemData data) async {
    final index = managementDataList.indexWhere((todo) => todo.id == data.id);
    managementDataList[index] = data;

    await database.update(
      DatabaseConstants.tableTodo,
      data.toMap(),
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [data.id],
    );
    notifyListeners();
  }

  @override
  Future<void> deleteManagementItemData(int id) async {
    final existingTodoIndex =
        managementDataList.indexWhere((todo) => todo.id == id);

    if (existingTodoIndex == -1) {
      return;
    }

    await database.delete(
      DatabaseConstants.tableTodo,
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [id],
    );

    _shrinkAndSynchronizeDatabase(existingTodoIndex + 1);
    managementDataList.removeAt(existingTodoIndex);
    notifyListeners();
  }

  void _shrinkAndSynchronizeDatabase(int startIndex) async {
    for (var index = startIndex; index < managementDataList.length; index++) {
      final todo = managementDataList[index].copyWith(
        id: index - 1,
      );
      managementDataList[index] = todo;
      await database.update(
        DatabaseConstants.tableTodo,
        todo.toMap(),
        where: "${DatabaseConstants.columnId} = ?",
        whereArgs: [todo.id],
      );
    }
  }
}
