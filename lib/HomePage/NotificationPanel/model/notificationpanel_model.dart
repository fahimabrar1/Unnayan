// To parse this JSON data, do
//
//     final notificationPageModel = notificationPageModelFromMap(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/my_vars.dart';

NotificationPageModel notificationPageModelFromMap(String str) =>
    NotificationPageModel.fromMap(json.decode(str));

String notificationPageModelToMap(NotificationPageModel data) =>
    json.encode(data.toMap());

class NotificationPageModel {
  NotificationPageModel({
    this.complainId,
    this.name,
    this.email,
    this.phone,
    this.detailsByUser,
    this.image,
    this.status,
    this.showNotiftoUser,
    this.showNotiftoOrg,
    this.iduser,
    this.organizationsId,
    this.detaiilsByOrg,
    this.repliedToUser,
    this.repliedToOrg,
  });

  int? complainId;
  String? name;
  String? email;
  String? phone;
  String? detailsByUser;
  List<int>? image;
  String? status;
  String? showNotiftoUser;
  String? showNotiftoOrg;
  int? iduser;
  int? organizationsId;
  String? detaiilsByOrg;
  String? repliedToUser;
  String? repliedToOrg;

  factory NotificationPageModel.fromMap(Map<String, dynamic> json) {
    return NotificationPageModel(
      complainId: json["complainId"],
      name: json["name"].toString(),
      email: json["email"].toString(),
      phone: json["phone"].toString(),
      detailsByUser: json["detailsByUser"].toString(),
      image: json["image"],
      status: json["status"].toString(),
      showNotiftoUser: json["showNotiftoUser"].toString(),
      showNotiftoOrg: json["showNotiftoOrg"].toString(),
      iduser: json["iduser"],
      organizationsId: json["organizationsId"],
      detaiilsByOrg: json["detaiilsByOrg"].toString(),
      repliedToUser: json["repliedToUser"].toString(),
      repliedToOrg: json["repliedToOrg"].toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        "complainId": complainId,
        "name": name,
        "email": email,
        "phone": phone,
        "detailsByUser": detailsByUser,
        "image": image,
        "status": status,
        "showNotiftoUser": showNotiftoUser,
        "showNotiftoOrg": showNotiftoOrg,
        "iduser": iduser,
        "organizationsId": organizationsId,
        "detaiilsByOrg": detaiilsByOrg,
        "repliedToUser": repliedToUser,
        "repliedToOrg": repliedToOrg,
      };

  Database? db;

  Future<void> open_Database() async {
    db = await DBDetails.InitDatabase();
  }

  Future<List<NotificationPageModel>?> showNotifications(int userId,
      NotificationEnum nEnum, String repliedToUser, String userType) async {
    if (db == null) {
      await open_Database();
    }
    List<Map<String, dynamic>>? maps;
    switch (nEnum) {
      case NotificationEnum.def:
        if (userType == 'user') {
          maps = await db?.rawQuery(
              "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId} AND repliedToUser = '${repliedToUser}')");
        } else {
          int newId = await getOrgId(userId);
          log("Org ID: " + newId.toString());
          maps = await db?.rawQuery(
              "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (organizationsId = ${newId} AND repliedToOrg = '${repliedToUser}')");
        }

        break;
      case NotificationEnum.userTotal:
        maps = await db?.rawQuery(
            "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId})");
        break;

      case NotificationEnum.userHistory:
        maps = await db?.rawQuery(
            "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId} AND status = 'solved')");
        break;
      case NotificationEnum.userPending:
        maps = await db?.rawQuery(
            "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId} AND status = 'pending')");
        break;

      ///
      ///
      /// ORG
      ///
      case NotificationEnum.orgTotal:
        int newId = await getOrgId(userId);
        log("Org ID: " + newId.toString());
        maps = await db?.rawQuery(
            "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (organizationsId = ${newId})");
        break;

      case NotificationEnum.orgRecent:
        int newId = await getOrgId(userId);
        log("Org ID: " + newId.toString());
        maps = await db?.rawQuery(
            "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (organizationsId = ${newId} AND status = 'solved')");
        break;
      case NotificationEnum.orgPending:
        int newId = await getOrgId(userId);
        log("Org ID: " + newId.toString());
        maps = await db?.rawQuery(
            "SELECT * from ${DBDetails.DBTable_COMPLAIN} where (organizationsId = ${newId} AND status = 'pending')");
        break;
    }
    List<NotificationPageModel> model = [];
    log(maps!.length.toString());

    if (maps.isNotEmpty) {
      for (var card in maps) {
        var nModel = NotificationPageModel.fromMap(card);
        model.add(nModel);
      }

      return model;
    }

    return null;
  }

  Future<List<int>?> getTileLogo(int id, BuildContext context) async {
    if (db != null) {
      db = await DBDetails.InitDatabase();
    }

    ///
    /// ?Wrong Query
    ///
    String query;
    if (context.read<LoginpageModel>().userType != 'user') {
      query =
          "SELECT image from ${DBDetails.DBTable_USER} where iduser = ${id}";
    } else {
      query =
          "SELECT image from ${DBDetails.DBTable_ORGANIZATIONS} where organizationsId = ${id}";
    }
    List<Map<String, dynamic>>? maps = await db?.rawQuery(query);
    if (maps!.length == 1) {
      List<int> img = maps.first['image'];
      return img;
    }
    return null;
  }

  Future<List<int>?> showUserLogo(int id) async {
    if (db != null) {
      db = await DBDetails.InitDatabase();
    }

    ///
    /// ?Wrong Query
    ///
    List<Map<String, dynamic>>? maps = await db?.rawQuery(
        "SELECT image from ${DBDetails.DBTable_USER} where iduser = ${id}");
    if (maps!.length == 1) {
      List<int> img = maps.first['image'];
      return img;
    }
    return null;
  }

  Future<void> updateComplainNotificationToUserToFalse(
      int complainId, String showNotifToUserStr) async {
    db ??= await DBDetails.InitDatabase();

    String query =
        "UPDATE complain SET showNotiftoUser = ? WHERE complainId = ?";

    int num = await db!.rawUpdate(query, [showNotifToUserStr, complainId]);
    log("Updated Row: " + num.toString());
  }

  Future<int> getOrgId(int userId) async {
    db ??= await DBDetails.InitDatabase();
    log("getTotalData for user :");
    List<Map<String, dynamic?>>? map = await db?.rawQuery(
        "SELECT organizationsId FROM ${DBDetails.DBTable_ORGANIZATIONS} WHERE (iduser = ${userId})");
    log(map!.length.toString());
    if (map != null) {
      return map.first['organizationsId'];
    }
    return 0;
  }

  Future<void> updateComplainNotificationToOrgToFalse(
      int complainId, String showNotifToUserStr) async {
    db ??= await DBDetails.InitDatabase();

    String query =
        "UPDATE complain SET showNotiftoOrg = ? WHERE complainId = ?";

    int num = await db!.rawUpdate(query, [showNotifToUserStr, complainId]);
    log("Updated Row: " + num.toString());
  }
}
