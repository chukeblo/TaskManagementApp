import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../../views/views.dart';

class TaskPage extends StatelessWidget {
  TaskPage._({Key? key}) : super(key: key);

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_context) => TaskPageModel(
        taskProvider: Provider.of<TaskProvider>(context),
      ),
      child: TaskPage._(),
    );
  }

  List<TaskItemData> tasks = [];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskPageModel>(context);
    tasks = model.taskList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("TASK"),
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
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: TodoItemData.getCompletionStatus(task.isCompleted)
                ? Colors.greenAccent
                : null,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${task.format(task.createdAt)} ~ ${task.format(task.completedAt)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              onTap: () {
                model.toggleTaskCompletion(task);
              },
              leading: TodoItemData.getCompletionStatus(task.isCompleted)
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
                      model.deleteTask(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showTaskEditDialog(
                        context: context,
                        editingTask: task,
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
          _showTaskAddDialog(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTaskAddDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskAddDialog.withDependencies(context: context);
      },
    );
  }

  void _showTaskEditDialog({
    required BuildContext context,
    required TaskItemData editingTask,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TaskEditDialog.withDependencies(
            context: context,
            editingTask: editingTask,
          );
        });
  }
}
