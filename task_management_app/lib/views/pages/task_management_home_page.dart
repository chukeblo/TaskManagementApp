import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../views/views.dart';

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
      body: Center(
        child: ElevatedButton.icon(
          label: const Text("TODO"),
          icon: const Icon(Icons.check_box_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return TodoPage.withDependencies(context: context);
              }),
            );
          },
        ),
      ),
    );
  }
}
