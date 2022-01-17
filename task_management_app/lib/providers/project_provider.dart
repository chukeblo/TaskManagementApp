import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../utilities/utilities.dart';

class ProjectProvider extends ManagementDataProvider {
  ProjectProvider({
    required Database database,
  }) : super(database: database) {
    initialize();
  }

  @override
  Future<List<ManagementItemData>> getManagementDataList(
    Database database,
  ) async {
    final List<Map<String, dynamic>> maps =
        await database.query(DatabaseConstants.tableProject);
    return List.generate(maps.length, (i) {
      return ProjectItemData(
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
      DatabaseConstants.tableProject,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  @override
  Future<void> updateManagementItemData(ManagementItemData data) async {
    final index =
        managementDataList.indexWhere((project) => project.id == data.id);
    managementDataList[index] = data;

    await database.update(
      DatabaseConstants.tableProject,
      data.toMap(),
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [data.id],
    );
    notifyListeners();
  }

  @override
  Future<void> deleteManagementItemData(int id) async {
    final existingProjectIndex =
        managementDataList.indexWhere((project) => project.id == id);

    if (existingProjectIndex == -1) {
      return;
    }

    await database.delete(
      DatabaseConstants.tableProject,
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [id],
    );

    _shrinkAndSynchronizeDatabase(existingProjectIndex + 1);
    managementDataList.removeAt(existingProjectIndex);
    notifyListeners();
  }

  void _shrinkAndSynchronizeDatabase(int startIndex) async {
    for (var index = startIndex; index < managementDataList.length; index++) {
      final project = managementDataList[index].copyWith(
        id: index - 1,
      );
      managementDataList[index] = project;
      await database.update(
        DatabaseConstants.tableProject,
        project.toMap(),
        where: "${DatabaseConstants.columnId} = ?",
        whereArgs: [project.id],
      );
    }
  }
}
