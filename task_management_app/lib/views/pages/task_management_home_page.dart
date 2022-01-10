import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/views/widgets/dialogs/todo_add_dialog.dart';
import 'package:task_management_app/views/widgets/dialogs/todo_edit_dialog.dart';

import '../../models/models.dart';
import 'login_page.dart';

class TaskManagementHomePage extends StatelessWidget {
  const TaskManagementHomePage._({
    Key? key,
    required this.userId,
  }) : super(key: key);

  static Widget withDependencies({
    required BuildContext context,
    required String userId,
  }) {
    return ChangeNotifierProvider(
      create: (_context) => TaskManagementHomePageModel(
        todoProvider: Provider.of(context),
      ),
      child: TaskManagementHomePage._(userId: userId),
    );
  }

  final String userId;
  @override
  Widget build(BuildContext context) {
    final model =
        Provider.of<TaskManagementHomePageModel>(context, listen: false);
    final todos = model.todoList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Home"),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return LoginPage.withDependencies(context: context);
                }),
              );
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Card(
            color: todo.isCompleted ? Colors.greenAccent : null,
            child: ListTile(
              title: Text(todo.title),
              onTap: () {
                model.toggleTodoCompletion(todo);
              },
              leading: todo.isCompleted
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
                      model.deleteTodo(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showTodoEditDialog(
                        context: context,
                        editingTodo: todo,
                        title: todo.title,
                        memo: todo.memo,
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
          _showTodoAddDialog(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTodoAddDialog({
    required BuildContext context,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return TodoAddDialog.withDependencies(context: context);
        });
  }

  void _showTodoEditDialog({
    required BuildContext context,
    required TodoItemData editingTodo,
    required String title,
    String memo = "",
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return TodoEditDialog.withDependencies(
            context: context,
            editingTodo: editingTodo,
            title: title,
            memo: memo,
          );
        });
  }
}