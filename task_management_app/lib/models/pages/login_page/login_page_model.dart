import 'package:flutter/material.dart';

import 'login_error_type.dart';

class LoginPageModel extends ChangeNotifier {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String get userId => userIdController.text;

  void _updateErrorMessage(LoginErrorType type) {
    switch (type) {
      case LoginErrorType.none:
        _errorMessage = "";
        break;
      case LoginErrorType.lacksInformation:
        _errorMessage = "both userid and password are required";
        break;
      case LoginErrorType.registering:
        _errorMessage = "failed to register user info";
        break;
      case LoginErrorType.loggingIn:
        _errorMessage = "failed to log in";
        break;
      default:
        throw Exception("not supported login error type");
    }
    notifyListeners();
  }

  bool isUserInputValid() {
    if (userIdController.text.isEmpty || passwordController.text.isEmpty) {
      _updateErrorMessage(LoginErrorType.lacksInformation);
      return false;
    }
    _updateErrorMessage(LoginErrorType.none);
    return true;
  }
}
