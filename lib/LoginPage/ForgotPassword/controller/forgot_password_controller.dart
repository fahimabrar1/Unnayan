import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/LoginPage/ForgotPassword/model/forgot_password_model.dart';

class ForgotPasswordController extends ControllerMVC {
  factory ForgotPasswordController() => _this ??= ForgotPasswordController._();

  ForgotPasswordController._()
      : model = ForgotPasswordModel(),
        super();
  static ForgotPasswordController? _this;
  final ForgotPasswordModel model;

  Future<bool> onVerifiedEmail(String? email) async {
    bool val = false;
    await model.onVerifiedEmail(email).then((value) {
      val = value;
    });
    return val;
  }

  Future<void> resetPass(
      String? pass, String? email, BuildContext context) async {
    await model.resetPass(pass, email, context);
  }
}
