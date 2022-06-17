// To parse this JSON data, do
//
//     final complainPanelModel = complainPanelModelFromMap(jsonString);

import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../../dbdetails.dart';

ComplainPanelModel complainPanelModelFromMap(String str) => ComplainPanelModel.fromMap(json.decode(str));

String complainPanelModelToMap(ComplainPanelModel data) => json.encode(data.toMap());

class ComplainPanelModel {
  ComplainPanelModel({
    this.complainId,
    this.name,
    this.email,
    this.phone,
    this.details,
    this.image,
    this.status,
    this.showNotiftoUser,
    this.showNotiftoOrg,
    this.iduser,
    this.organizationTypeId,
  });

  String? complainId;
  String? name;
  String? email;
  String? phone;
  String? details;
  List<int>? image;
  String? status;
  String? showNotiftoUser;
  String? showNotiftoOrg;
  int? iduser;
  int? organizationTypeId;

  factory ComplainPanelModel.fromMap(Map<String, dynamic> json) => ComplainPanelModel(
    complainId: json["complainId"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    details: json["details"],
    image: json["image"],
    status: json["status"],
    showNotiftoUser: json["showNotiftoUser"],
    showNotiftoOrg: json["showNotiftoOrg"],
    iduser: json["iduser"],
    organizationTypeId: json["organizationTypeId"],
  );

  Map<String, dynamic> toMap() => {
    "complainId": complainId,
    "name": name,
    "email": email,
    "phone": phone,
    "details": details,
    "image": image,
    "status": status,
    "showNotiftoUser": showNotiftoUser,
    "showNotiftoOrg": showNotiftoOrg,
    "iduser": iduser,
    "organizationTypeId": organizationTypeId,
  };




  Database? db;

  Future<void> open_Database() async {
    db = await DBDetails.InitDatabase();
  }



  Future insert(ComplainPanelModel model) async {
    if(db==null)
      {
        await open_Database();
      }
    return await db!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          "INSERT INTO ${DBDetails.DBTable_COMPLAIN}(name,email,phone,details,status,showNotiftoUser,showNotiftoOrg,iduser,organizationTypeId,image) VALUES(?,?,?,?,?,?,?,?,?,?)",[
        model.name,
        model.email,
        model.phone,
        model.details,
        model.status,
        model.showNotiftoUser,
        model.showNotiftoOrg,
        model.iduser,
        model.organizationTypeId,
        model.image
      ]);
      print('inserted1: $id1');

    });

  }

}
