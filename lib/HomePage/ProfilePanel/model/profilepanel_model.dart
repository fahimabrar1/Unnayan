
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';

ProfileModel loginpageModelFromMap(String str) =>
    ProfileModel.fromMap(json.decode(str));

String loginpageModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  ProfileModel({
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
  }) {
    _openDatabase();
  }

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

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
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

    String path = DBDetails.DBPATH + DBDetails.DBNAME;
    print(path);

    db = await openDatabase(path, version: 1);
    if(db!.isOpen)
    {
      print("Database is Opended");

    }
  }

  Future open(String path) async {}


  Future<ProfileModel?> getUser(String? myuser, String? mypassword) async {
    // Get the records
    List<Map<String, dynamic?>>? list = await db?.rawQuery("SELECT * FROM ${DBDetails.DBTable_USER} WHERE (username = '$myuser' OR email = '$myuser' OR phoneNumber = '$myuser') AND (password = '$mypassword')");
    print(list);
    if(list!.length == 1 )
    {
      return ProfileModel.fromMap(list.first);
    }
    return null;
  }


  Future close() async => db?.close();
}
