import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/HomePage/homepage_view.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';

import '../../AlWids.dart';

class LoginPageController extends ControllerMVC {
  factory LoginPageController() => _this ??= LoginPageController._();

  LoginPageController._()
      : model = LoginpageModel(),
        super();

  static LoginPageController? _this;
  final LoginpageModel model;

  Future<void> login(
      BuildContext context, String? _user, String? password) async {
    log("Clicked Login 2: $_user and $password");

    LoginpageModel? user = await model.getUser(_user!.trim(), password!.trim());
    if (user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<LoginpageModel>.value(
              value: model,
              child: ChangeNotifierProvider<WidContainer>(
                  create: (_) => WidContainer(), child: const HomePageSTL()),
            ),
          ));
    } else {
      final snackBar = SnackBar(content: const Text('User Not Found'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
