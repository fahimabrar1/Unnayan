import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/HomePage/homepage_view.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';

class LoginPageController extends ControllerMVC {
  factory LoginPageController() => _this ??= LoginPageController._();
  LoginPageController._()
      : model = LoginpageModel(),
        super();

  static LoginPageController? _this;
  final LoginpageModel model;

  Future<void> login(BuildContext context,String? _user, String? password) async {
    print("Clicked Login 2");
    LoginpageModel? user = await model.getUser(_user, password);
  if(user != null)
    {
      model.close();
      print("Ex");
        Navigator.push(
          context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<LoginpageModel>.value(
                value: model,
                child: HomePageSTL(),
              ),
            )
        );
      print("E");
    }else
      {

        final snackBar = SnackBar(
        content: const Text('User Not Found')
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
  }
}
