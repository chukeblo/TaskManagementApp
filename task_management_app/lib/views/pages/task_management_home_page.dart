import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/login/login_page_model.dart';

import 'login_page.dart';

class TaskManagementHomePage extends StatelessWidget {
  const TaskManagementHomePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Home"),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
                  return ChangeNotifierProvider<LoginPageModel>(
                    create: (context) => LoginPageModel(),
                    child: LoginPage(),
                  );
                }),
              );
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
      body: Center(
        child: Text("UserID = $userId"),
      ),
    );
  }
}
