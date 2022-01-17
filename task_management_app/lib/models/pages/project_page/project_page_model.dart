import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../../utilities/utilities.dart';

class ProjectPageModel extends ChangeNotifier {
  ProjectPageModel({
    required this.projectProvider,
  });

  final ManagementDataProvider projectProvider;

  List<ManagementItemData> get projectList =>
      projectProvider.managementDataList;

  void deleteProject(int id) {
    projectProvider.deleteManagementItemData(id);
    notifyListeners();
  }

  void toggleProjectCompletion(ManagementItemData togglingCompletionProject) {
    final isCompleted =
        reverseCompletion(togglingCompletionProject.isCompleted);
    final createdAt = togglingCompletionProject.createdAt;
    final completedAt = getCompletionStatus(isCompleted)
        ? DateTime.now().toIso8601String()
        : "";
    final updatedProject = togglingCompletionProject.copyWith(
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
    projectProvider.updateManagementItemData(updatedProject);
    notifyListeners();
  }
}
