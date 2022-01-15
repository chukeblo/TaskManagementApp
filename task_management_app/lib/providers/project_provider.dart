import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import '../utilities/utilities.dart';

class ProjectProvider extends ChangeNotifier {
  ProjectProvider({
    required this.database,
  }) {
    initialize();
  }

  final Database database;
  List<ProjectItemData> projectList = [];

  Future<void> initialize() async {
    projectList = await getProjectList(database);
  }

  Future<List<ProjectItemData>> getProjectList(
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

  Future<void> addProject(ProjectItemData project) async {
    projectList.add(project);
    await database.insert(
      DatabaseConstants.tableProject,
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateProject(ProjectItemData newProject) async {
    final index =
        projectList.indexWhere((project) => project.id == newProject.id);
    projectList[index] = newProject;

    await database.update(
      DatabaseConstants.tableProject,
      newProject.toMap(),
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [newProject.id],
    );
    notifyListeners();
  }

  Future<void> deleteProject(int targetProjectId) async {
    final existingProjectIndex =
        projectList.indexWhere((project) => project.id == targetProjectId);

    if (existingProjectIndex == -1) {
      return;
    }

    await database.delete(
      DatabaseConstants.tableProject,
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [targetProjectId],
    );

    _shrinkAndSynchronizeDatabase(existingProjectIndex + 1);
    projectList.removeAt(existingProjectIndex);
    notifyListeners();
  }

  void _shrinkAndSynchronizeDatabase(int startIndex) async {
    for (var index = startIndex; index < projectList.length; index++) {
      final project = projectList[index].copyWith(
        id: index - 1,
      );
      projectList[index] = project;
      await database.update(
        DatabaseConstants.tableProject,
        project.toMap(),
        where: "${DatabaseConstants.columnId} = ?",
        whereArgs: [project.id],
      );
    }
  }
}
