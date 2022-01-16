import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class ProjectEditDialog extends StatelessWidget {
  const ProjectEditDialog._({
    Key? key,
    required this.editingProject,
  }) : super(key: key);

  final ProjectItemData editingProject;

  static Widget withDependencies({
    required BuildContext context,
    required ProjectItemData editingProject,
    required String title,
    String tag = "",
    String memo = "",
  }) {
    return ChangeNotifierProvider(
      create: (_context) => ProjectEditDialogModel(
        projectProvider: Provider.of<ProjectProvider>(context),
        title: title,
        tag: tag,
        memo: memo,
      ),
      child: ProjectEditDialog._(editingProject: editingProject),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProjectEditDialogModel>(context, listen: false);
    return SimpleDialog(
      children: <Widget>[
        SimpleDialogOption(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: model.titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: model.tagController,
                decoration: const InputDecoration(
                  labelText: "Tag",
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: model.memoController,
                decoration: const InputDecoration(
                  labelText: "Memo",
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.blue,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      model.editProject(editingProject);
                    },
                    child: const Text("EDIT"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.blue,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("CANCEL"),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
