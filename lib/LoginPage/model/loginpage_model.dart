import 'dart:convert';

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

  //
  // Future _openDatabase() async {
  //   // Get a location using getDatabasesPath
  //   // var databasesPath = await getDatabasesPath();
  //   // String path = databasesPath + DBDetails.DBNAME;
  //   String path = DBDetails.DBPATH + DBDetails.DBNAME;
  //   print(path);
  //
  //
  //   // Check if the database exists
  //   var exists = await databaseExists(path);
  //
  //   if (!exists) {
  //     // Should happen only the first time you launch your application
  //     print("Creating new copy from asset");
  //
  //     // Make sure the parent directory exists
  //     try {
  //       await Directory(dirname(path)).create(recursive: true);
  //     } catch (_) {}
  //
  //     // Copy from asset
  //     ByteData data = await rootBundle.load(join("assets", "unnayan.db"));
  //     List<int> bytes =
  //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //
  //     // Write and flush the bytes written
  //     await File(path).writeAsBytes(bytes, flush: true);
  //
  //   } else {
  //     print("Opening existing database");
  //   }
  //   db = await openDatabase(path);
  //
  //   // db = await openDatabase(path, version: 1);
  //   if(db!.isOpen)
  //     {
  //       print("Database is Opended");
  //     }
  // }

  Future<LoginpageModel?> getUser(String? myuser, String? mypassword) async {
    // Get the records
    if (db == null) {
      db = await DBDetails.InitDatabase();
    }
    List<Map<String, dynamic?>>? list = await db?.rawQuery(
        "SELECT * FROM ${DBDetails.DBTable_USER} WHERE (username = '$myuser' OR email = '$myuser' OR phoneNumber = '$myuser') AND (password = '$mypassword')");
    // List<Map<String, dynamic?>>? list = await db?.rawQuery("SELECT * FROM user");
    if (list!.isNotEmpty) {
      print(list.length);

      if (list.length == 1) {
        print(list);

        try {
          var v = LoginpageModel.fromMap(list.first);
          if (v != null) {
            this.iduser = v.iduser;
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
        } catch (e) {
          return null;
        }
      }
    }

    return null;
  }

  Future close() async => db?.close();
}
