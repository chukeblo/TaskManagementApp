import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'utilities/utilities.dart';
import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initializeDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(database: database),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(database: database),
        ),
        ChangeNotifierProvider(
          create: (_) => ProjectProvider(database: database),
        ),
      ],
      child: const TaskManagementApp(),
    ),
  );
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Management App",
      debugShowCheckedModeBanner: false,
      home: LoginPage.withDependencies(context: context),
    );
  }
}
