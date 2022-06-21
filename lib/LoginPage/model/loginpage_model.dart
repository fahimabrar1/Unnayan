import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';

LoginpageModel loginpageModelFromMap(String str) =>
    LoginpageModel.fromMap(json.decode(str));

String loginpageModelToMap(LoginpageModel data) => json.encode(data.toMap());

class LoginpageModel extends ChangeNotifier {
  LoginpageModel({
    this.iduser,
    this.username,
    this.email,
    this.password,
    this.phoneNumber,
    this.userType,
    this.universityName,
    this.name,
    this.location,
    this.image,
  });

  int? iduser;
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  String? userType;
  String? universityName;
  String? name;
  String? location;
  List<int>? image;
  Database? db;

  factory LoginpageModel.fromMap(Map<String, dynamic> json) => LoginpageModel(
        iduser: json["iduser"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        userType: json["userType"],
        universityName: json["universityName"],
        name: json["name"],
        location: json["location"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "iduser": iduser,
        "username": username,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "userType": userType,
        "universityName": universityName,
        "name": name,
        "location": location,
        "image": image,
      };

  Future<LoginpageModel?> getUser(String? myUser, String? myPassword) async {
    db ??= await DBDetails.InitDatabase();

    db!.isOpen ? log("Opended") : log("False");

    log("Print: $myUser and $myPassword");
    String query =
        "SELECT * FROM ${DBDetails.DBTable_USER} WHERE (username = '$myUser' OR email = '$myUser' OR phoneNumber = '$myUser') AND (password = '$myPassword')";
    log(query);
    List<Map<String, dynamic>>? list = await db?.rawQuery(query);
    log("Print: ${list!.length}");
    if (list.isNotEmpty) {
      log(list.length.toString());

      if (list.length == 1) {
        log(list.toString());

        try {
          var v = LoginpageModel.fromMap(list.first);
          iduser = v.iduser;
          name = v.name;
          universityName = v.universityName;
          username = v.username;
          phoneNumber = v.phoneNumber;
          password = v.password;
          email = v.email;
          image = v.image;
          location = v.location;
          userType = v.userType;
          notifyListeners();
          return v;
        } catch (e) {
          return null;
        }
      }
    }

    return null;
  }

  Future close() async => db?.close();
}
