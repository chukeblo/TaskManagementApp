import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../views/views.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key? key}) : super(key: key);

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_context) => LoginPageModel(),
      child: const LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginPageModel>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "UserID",
                ),
                controller: model.userIdController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                controller: model.passwordController,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(model.errorMessage),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.infinity),
                  primary: Colors.lightBlue,
                  onPrimary: Colors.blue,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  if (!model.isUserInputValid()) {
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return TaskManagementHomePage.withDependencies(
                        context: context,
                        userId: model.userId,
                      );
                    }),
                  );
                },
                child: const Text(
                  "REGISTER",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.infinity),
                  primary: Colors.lightBlue,
                  onPrimary: Colors.blue,
                ),
                onPressed: () async {
                  if (!model.isUserInputValid()) {
                    return;
                  }
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TaskManagementHomePage.withDependencies(
                          context: context,
                          userId: model.userId,
                        );
                      },
                    ),
                  );
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
