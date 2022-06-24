// To parse this JSON data, do
//
//     final complainPanelModel = complainPanelModelFromMap(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../../../dbdetails.dart';

ComplainPanelModel complainPanelModelFromMap(String str) =>
    ComplainPanelModel.fromMap(json.decode(str));

String complainPanelModelToMap(ComplainPanelModel data) =>
    json.encode(data.toMap());

class ComplainPanelModel {
  ComplainPanelModel({
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

  String? complainId;
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

  factory ComplainPanelModel.fromMap(Map<String, dynamic> json) =>
      ComplainPanelModel(
        complainId: json["complainId"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        detailsByUser: json["detailsByUser"],
        image: json["image"],
        status: json["status"],
        showNotiftoUser: json["showNotiftoUser"],
        showNotiftoOrg: json["showNotiftoOrg"],
        iduser: json["iduser"],
        organizationsId: json["organizationsId"],
      );

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

  Future insertByUser(ComplainPanelModel model) async {
    if (db == null) {
      await open_Database();
    }
    return await db!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          "INSERT INTO ${DBDetails.DBTable_COMPLAIN}(name,email,phone,detailsByUser,status,showNotiftoUser,showNotiftoOrg,iduser,organizationsId,image,repliedToUser,repliedToOrg) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            model.name,
            model.email,
            model.phone,
            model.detailsByUser,
            model.status,
            model.showNotiftoUser,
            model.showNotiftoOrg,
            model.iduser,
            model.organizationsId,
            model.image,
            model.repliedToUser,
            model.repliedToOrg
          ]);
      log('inserted1: $id1');
    });
  }
}
