// To parse this JSON data, do
//
//     final loginpageModel = loginpageModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';

LoginpageModel loginpageModelFromMap(String str) =>
    LoginpageModel.fromMap(json.decode(str));

String loginpageModelToMap(LoginpageModel data) => json.encode(data.toMap());

class LoginpageModel extends ChangeNotifier{
  LoginpageModel({
    this.username,
    this.email,
    this.password,
    this.phoneNumber,
    this.userType,
    this.universityName,
    this.name,
    this.location,
    this.image,
  }) {
    _openDatabase();
  }



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



  Future _openDatabase() async {
    // Get a location using getDatabasesPath
    // var databasesPath = await getDatabasesPath();
    // String path = databasesPath + DBDetails.DBNAME;
    String path = DBDetails.DBPATH + DBDetails.DBNAME;
    print(path);

    db = await openDatabase(path, version: 1);
    if(db!.isOpen)
      {
        print("Database is Opended");

      }
  }

  Future open(String path) async {}

  // Future<Todo> insert(Todo todo) async {
  //   todo.id = await db.insert(tableTodo, todo.toMap());
  //   return todo;
  // }

  Future<LoginpageModel?> getUser(String? myuser, String? mypassword) async {
    // Get the records
    List<Map<String, dynamic?>>? list = await db?.rawQuery("SELECT * FROM ${DBDetails.DBTable_USER} WHERE (username = '$myuser' OR email = '$myuser' OR phoneNumber = '$myuser') AND (password = '$mypassword')");
    print(list);
    if(list!.length == 1 ) {
      var v = LoginpageModel.fromMap(list.first);

      if (v != null) {
        this.name = v.name;
        this.universityName = v.universityName;
        this.username = v.username;
        this.phoneNumber = v.phoneNumber;
        this.password = v.password;
        this.email = v.email;
        this.image = v.image;
        this.location = v.location;
        this.userType = v.userType;
      }
      notifyListeners();
      return v;
    }
    return null;
  }

  // Future<int> delete(int id) async {
  //   return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  // }

  // Future<int> update(Todo todo) async {
  //   return await db.update(tableTodo, todo.toMap(),
  //       where: '$columnId = ?', whereArgs: [todo.id]);
  // }

  Future close() async => db?.close();
}
