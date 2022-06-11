import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';

class LoginPageController extends ControllerMVC {
  factory LoginPageController() => _this ??= LoginPageController._();
  LoginPageController._()
      : model = LoginpageModel(),
        super();

  static LoginPageController? _this;
  final LoginpageModel model;

  void login() => setState(() {
        model.login();
      });
}
