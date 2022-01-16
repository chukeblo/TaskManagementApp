import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../providers/providers.dart';
import '../../models/models.dart';
import '../views.dart';

class TodoPage extends StatelessWidget {
  TodoPage._({Key? key}) : super(key: key);

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_context) =>
          TodoPageModel(todoProvider: Provider.of<TodoProvider>(context)),
      child: TodoPage._(),
    );
  }

  List<TodoItemData> todos = [];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TodoPageModel>(context);
    todos = model.todoList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("TODO"),
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
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Card(
            color: TodoItemData.getCompletionStatus(todo.isCompleted)
                ? Colors.greenAccent
                : null,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${todo.format(todo.createdAt)} ~ ${todo.format(todo.completedAt)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              onTap: () {
                model.toggleTodoCompletion(todo);
              },
              leading: TodoItemData.getCompletionStatus(todo.isCompleted)
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
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return TodoEditDialog.withDependencies(
            context: context,
            editingTodo: editingTodo,
          );
        });
  }
}
