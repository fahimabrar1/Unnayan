import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/LoginPage/CreateAccount/model/create_account_model.dart';

class CreateAccountController extends ControllerMVC {
  factory CreateAccountController() => _this ??= CreateAccountController._();

  CreateAccountController._()
      : model = CreateAccountModel(),
        super();

  static CreateAccountController? _this;
  final CreateAccountModel model;

  Future<void> createAccountForUser(
      String? fullName,
      String? email,
      String? password,
      String? location,
      List<int>? image,
      String? username,
      String? cellNumber,
      String? userType,
      String? instituteName) async {
    await model.createAcccountForUser(
        username: username,
        email: email,
        phoneNumber: cellNumber,
        password: password,
        userType: userType,
        image: image,
        universityName: instituteName,
        name: fullName,
        location: location);
  }

  Future<bool> checkUserNameFromDB(String username) async {
    bool val = false;
    await model.checkUserNameFromDB(username).then((value) {
      val = value;
    });

    return val;
  }

  Future<void> createAccountForOrg(
      String? fullName,
      String? email,
      String? password,
      String? location,
      List<int>? image,
      String? username,
      String? cellNumber,
      String? userType,
      int? orgType) async {
    bool val = false;
    await model.createAccountForOrg(
        username: username,
        email: email,
        phoneNumber: cellNumber,
        password: password,
        userType: userType,
        image: image,
        name: fullName,
        location: location,
        orgType: orgType);
  }
}
