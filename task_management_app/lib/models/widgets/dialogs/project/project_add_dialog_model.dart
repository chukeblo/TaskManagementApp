import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';
import '../../../../utilities/utilities.dart';

class ProjectAddDialogModel extends ChangeNotifier {
  ProjectAddDialogModel({
    required this.projectProvider,
  }) {
    titleController.text = "";
    tagController.text = "";
    memoController.text = "";
  }

  final ManagementDataProvider projectProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void addProject() {
    final project = ProjectItemData(
      id: projectProvider.managementDataList.length,
      title: titleController.text,
      tag: tagController.text,
      isCompleted: intFalse,
      createdAt: DateTime.now().toIso8601String(),
      memo: memoController.text,
    );

    projectProvider.addManagementItemData(project);
    notifyListeners();
  }
}
