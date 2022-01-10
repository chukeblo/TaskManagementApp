import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../views/views.dart';

class LoginPage extends StatelessWidget {
  LoginPage._({Key? key}) : super(key: key);

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_context) => LoginPageModel(),
      child: LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginPageModel>(
      builder: (context, model, child) => Scaffold(
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
                  controller: _userIdController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  controller: _passwordController,
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
                    if (_userIdController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      model.updateErrorMessage(LoginErrorType.lacksInformation);
                      return;
                    }
                    if (_userIdController.text == "fool" ||
                        _passwordController.text == "4649") {
                      model.updateErrorMessage(LoginErrorType.registering);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return TaskManagementHomePage.withDependencies(
                            context: context,
                            userId: _userIdController.text,
                          );
                        }),
                      );
                    }
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
                    if (_userIdController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      model.updateErrorMessage(LoginErrorType.lacksInformation);
                      return;
                    }
                    if (_userIdController.text == "fool" ||
                        _passwordController.text == "4649") {
                      model.updateErrorMessage(LoginErrorType.loggingIn);
                    } else {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return TaskManagementHomePage.withDependencies(
                            context: context,
                            userId: _userIdController.text,
                          );
                        }),
                      );
                    }
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
      ),
    );
  }
}
