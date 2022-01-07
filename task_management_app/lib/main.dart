import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/login/login_page_model.dart';

import 'views/pages/login_page.dart';

void main() {
  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Management App",
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<LoginPageModel>(
        create: (context) => LoginPageModel(),
        child: LoginPage(),
      ),
    );
  }
}
