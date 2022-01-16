import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/views/views.dart';

import './../../providers/providers.dart';
import '../../models/models.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage._({Key? key}) : super(key: key);

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_context) => ProjectPageModel(
          projectProvider: Provider.of<ProjectProvider>(context)),
      child: ProjectPage._(),
    );
  }

  List<ProjectItemData> projects = [];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProjectPageModel>(context);
    projects = model.projectList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("PROJECT"),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Card(
            color: ProjectItemData.getCompletionStatus(project.isCompleted)
                ? Colors.greenAccent
                : null,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${project.format(project.createdAt)} ~ ${project.format(project.completedAt)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              onTap: () {
                model.toggleProjectCompletion(project);
              },
              leading: ProjectItemData.getCompletionStatus(project.isCompleted)
                  ? const Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : null,
              trailing: Wrap(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      model.deleteProject(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showProjectEditDialog(
                        context: context,
                        editingProject: project,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProjectAddDialog(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showProjectAddDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProjectAddDialog.withDependencies(context: context);
      },
    );
  }

  void _showProjectEditDialog({
    required BuildContext context,
    required ProjectItemData editingProject,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProjectEditDialog.withDependencies(
            context: context,
            editingProject: editingProject,
          );
        });
  }
}
