import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    if (db!.isOpen) {
      print("Database is Opended");
    }
  }

  Future open(String path) async {}

  Future<ProfileModel?> getUser(String? myuser, String? mypassword) async {
    // Get the records
    db ??= await DBDetails.InitDatabase();
    List<Map<String, dynamic?>>? list = await db?.rawQuery(
        "SELECT * FROM ${DBDetails.DBTable_USER} WHERE (username = '$myuser' OR email = '$myuser' OR phoneNumber = '$myuser') AND (password = '$mypassword')");
    log(list.toString());
    if (list!.length == 1) {
      return ProfileModel.fromMap(list.first);
    }
    return null;
  }

  Future close() async => db?.close();

  Future<int> getTotalUserData(int id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('db')
        .doc('unnayan')
        .collection('complain')
        .where('iduser', isEqualTo: id)
        .get();

    final data = querySnapshot.docs.map((e) => e).toList();

    if (data.isNotEmpty) {
      log("data not empty");
      return data.length;
    }
    return 0;
  }

  // Future<int> getTotalUserData(int id) async {
  //   db ??= await DBDetails.InitDatabase();
  //   log("getTotalData for user :");
  //   List<Map<String, dynamic?>>? map = await db?.rawQuery(
  //       "SELECT * FROM ${DBDetails.DBTable_COMPLAIN} WHERE (iduser = ${id})");
  //   log(map!.length.toString());
  //   if (map != null) {
  //     return map.length;
  //   }
  //   return 0;
  // }

  Future<int> getHistoryUserData(int id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('db')
        .doc('unnayan')
        .collection('complain')
        .where('iduser', isEqualTo: id)
        .where('status', isEqualTo: 'solved')
        .get();
    final data = querySnapshot.docs.map((e) => e).toList();

    if (data.isNotEmpty) {
      return data.length;
    }
    return 0;
  }

  Future<int> getPendingUserData(int id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('db')
        .doc('unnayan')
        .collection('complain')
        .where('iduser', isEqualTo: id)
        .where('status', isEqualTo: 'pending')
        .get();
    final data = querySnapshot.docs.map((e) => e).toList();

    if (data.isNotEmpty) {
      return data.length;
    }
    return 0;
  }

  ///
  ///
  /// Organizations Quries.
  ///
  ///

  Future<int> getOrgId(int id) async {
    db ??= await DBDetails.InitDatabase();
    log("getTotalData for user :");
    List<Map<String, dynamic?>>? map = await db?.rawQuery(
        "SELECT organizationsId FROM ${DBDetails.DBTable_ORGANIZATIONS} WHERE (iduser = ${id})");
    log(map!.length.toString());

    if (map != null) {
      return map.first['organizationsId'];
    }
    return 0;
  }

  Future<int> getRecentOrgData(int id) async {
    db ??= await DBDetails.InitDatabase();
    log("getTotalData for user :");
    int newId = await getOrgId(id);
    List<Map<String, dynamic?>>? map = await db?.rawQuery(
        "SELECT * FROM ${DBDetails.DBTable_COMPLAIN} WHERE (organizationsId = ${newId} AND status = 'solved')");
    log(map!.length.toString());
    if (map != null) {
      return map.length;
    }
    return 0;
  }

  Future<int> getPendingOrgData(int id) async {
    db ??= await DBDetails.InitDatabase();
    log("getTotalData for user :");
    int newId = await getOrgId(id);

    List<Map<String, dynamic?>>? map = await db?.rawQuery(
        "SELECT * FROM ${DBDetails.DBTable_COMPLAIN} WHERE (organizationsId = ${newId}) AND status = 'pending'");
    log(map!.length.toString());
    if (map != null) {
      return map.length;
    }
    return 0;
  }

  Future<int> getTotalOrgData(int id) async {
    db ??= await DBDetails.InitDatabase();
    log("getTotalData for user :");
    int newId = await getOrgId(id);

    List<Map<String, dynamic?>>? map = await db?.rawQuery(
        "SELECT * FROM ${DBDetails.DBTable_COMPLAIN} WHERE (organizationsId = ${newId})");
    log(map!.length.toString());
    if (map != null) {
      return map.length;
    }
    return 0;
  }
}
