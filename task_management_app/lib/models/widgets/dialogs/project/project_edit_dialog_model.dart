import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class ProjectEditDialogModel extends ChangeNotifier {
  ProjectEditDialogModel({
    required this.projectProvider,
    required String title,
    String tag = "",
    String memo = "",
  }) {
    titleController.text = title;
    tagController.text = tag;
    memoController.text = memo;
  }

  final ManagementDataProvider projectProvider;
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final memoController = TextEditingController();

  void editProject(ManagementItemData editingProject) {
    final updatedProject = editingProject.copyWith(
      title: titleController.text,
      tag: tagController.text,
      memo: memoController.text,
    );
    projectProvider.updateManagementItemData(updatedProject);
    notifyListeners();
  }
}
