import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';

class ProjectPageModel extends ChangeNotifier {
  ProjectPageModel({
    required this.projectProvider,
  });

  final ProjectProvider projectProvider;

  List<ProjectItemData> get projectList => projectProvider.projectList;

  void deleteProject(int id) {
    projectProvider.deleteProject(id);
    notifyListeners();
  }

  void toggleProjectCompletion(ProjectItemData togglingCompletionProject) {
    final isCompleted = ProjectItemData.reverseCompletion(
        togglingCompletionProject.isCompleted);
    final createdAt = togglingCompletionProject.createdAt;
    final completedAt = ProjectItemData.getCompletionStatus(isCompleted)
        ? DateTime.now().toIso8601String()
        : "";
    final updatedProject = togglingCompletionProject.copyWith(
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
    projectProvider.updateProject(updatedProject);
    notifyListeners();
  }
}
