import 'package:flutter/material.dart';

import 'login_error_type.dart';

class LoginPageModel extends ChangeNotifier {
  String errorMessage = "";

  void updateErrorMessage(LoginErrorType type) {
    switch (type) {
      case LoginErrorType.lacksInformation:
        errorMessage = "both userid and password are required";
        break;
      case LoginErrorType.registering:
        errorMessage = "failed to register user info";
        break;
      case LoginErrorType.loggingIn:
        errorMessage = "failed to log in";
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
