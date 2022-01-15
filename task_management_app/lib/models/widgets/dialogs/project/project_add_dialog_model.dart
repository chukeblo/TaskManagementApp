import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class ProjectAddDialogModel extends ChangeNotifier {
  ProjectAddDialogModel({
    required this.projectProvider,
  }) {
    titleController.text = "";
    tagController.text = "";
    memoController.text = "";
  }

  final ProjectProvider projectProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void addProject() {
    final project = ProjectItemData(
      id: projectProvider.projectList.length,
      title: titleController.text,
      tag: tagController.text,
      isCompleted: ProjectItemData.intFalse,
      createdAt: DateTime.now().toIso8601String(),
      memo: memoController.text,
    );

    projectProvider.addProject(project);
    notifyListeners();
  }
}
