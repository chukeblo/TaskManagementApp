import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TaskEditDialog extends StatelessWidget {
  const TaskEditDialog._({
    Key? key,
    required this.editingTask,
  }) : super(key: key);

  final ManagementItemData editingTask;

  static Widget withDependencies({
    required BuildContext context,
    required ManagementItemData editingTask,
  }) {
    return ChangeNotifierProvider(
      create: (_context) => TaskEditDialogModel(
        taskProvider: Provider.of<TaskProvider>(context),
        title: editingTask.title,
        tag: editingTask.tag,
        memo: editingTask.memo,
      ),
      child: TaskEditDialog._(editingTask: editingTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskEditDialogModel>(context, listen: false);
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
                      model.editTask(editingTask);
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
