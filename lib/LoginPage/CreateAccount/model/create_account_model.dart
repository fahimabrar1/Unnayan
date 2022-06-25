import 'dart:convert';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';

CreateAccountModel createAccountModelFromMap(String str) =>
    CreateAccountModel.fromMap(json.decode(str));

String createAccountModelToMap(CreateAccountModel data) =>
    json.encode(data.toMap());

class CreateAccountModel {
  CreateAccountModel({
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

  String? iduser;
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  String? userType;
  String? universityName;
  String? name;
  String? location;
  String? image;

  factory CreateAccountModel.fromMap(Map<String, dynamic> json) =>
      CreateAccountModel(
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

  Database? db;

  Future<void> createAcccountForUser(
      {String? username,
      String? email,
      String? phoneNumber,
      String? password,
      String? userType,
      List<int>? image,
      String? universityName,
      String? name,
      String? location}) async {
    db ??= await DBDetails.InitDatabase();
    String query =
        "INSERT INTO ${DBDetails.DBTable_USER}(username, email, phoneNumber, password, userType, image, universityName, name, location)VALUES (?,?,?,?,?,?,?,?,?)";

    int userId = await db!.rawInsert(query, [
      username,
      email,
      phoneNumber,
      password,
      userType,
      image,
      universityName,
      name,
      location
    ]);

    log("Inserted Into users :" + userId.toString());
  }

  Future<bool> checkUserNameFromDB(String username) async {
    db ??= await DBDetails.InitDatabase();
    List<Map<String, dynamic>> map = await db!.rawQuery(
        "select username from ${DBDetails.DBTable_USER} where (username = '$username')");

    if (map.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<void> createAccountForOrg(
      {String? username,
      String? email,
      String? phoneNumber,
      String? password,
      String? userType,
      List<int>? image,
      String? name,
      String? location,
      int? orgType}) async {
    db ??= await DBDetails.InitDatabase();
    String query =
        "INSERT INTO ${DBDetails.DBTable_USER}(username, email, phoneNumber, password, userType, image, name, location)VALUES (?,?,?,?,?,?,?,?)";

    int userId = await db!.rawInsert(query, [
      username,
      email,
      phoneNumber,
      password,
      userType,
      image,
      name,
      location
    ]);

    log("Inserted Into users :" + userId.toString());
    String queryForOrgType =
        "INSERT INTO ${DBDetails.DBTable_ORGANIZATIONS}(name, image, organizationTypeId, iduser)VALUES (?,?,?,?);";
    int orgzId =
        await db!.rawInsert(queryForOrgType, [name, image, orgType, userId]);

    log("Inserted Into Organizations :" + orgzId.toString());
  }
}
