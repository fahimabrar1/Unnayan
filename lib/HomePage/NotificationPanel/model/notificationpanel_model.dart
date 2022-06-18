// To parse this JSON data, do
//
//     final notificationPageModel = notificationPageModelFromMap(jsonString);

import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';
import 'package:unnayan/my_vars.dart';

NotificationPageModel notificationPageModelFromMap(String str) => NotificationPageModel.fromMap(json.decode(str));

String notificationPageModelToMap(NotificationPageModel data) => json.encode(data.toMap());

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

  factory NotificationPageModel.fromMap(Map<String, dynamic> json)
  {
    // print("complainId: "+json["complainId"]);
    // print("name: "+json["name"]);
    // print("email: "+json["email"].toString());
    // print("phone: "+json["phone"].toString());
    // print("detailsByUser: "+json["detailsByUser"].toString());
    // print("status: "+json["status"].toString());
    // print("showNotiftoUser: "+json["showNotiftoUser"].toString());
    // print("showNotiftoOrg: "+json["showNotiftoOrg"].toString());
    // print("iduser: "+json["iduser"]);
    // print("organizationsId: "+json["organizationsId"]);
    // print("detaiilsByOrg:  "+json["detaiilsByOrg"].toString());

    // print("image"+json["image"]);
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
  };





  Database? db;

  Future<void> open_Database() async {
    db = await DBDetails.InitDatabase();
  }


  Future<List<NotificationPageModel>?> showNotifications(int userId, NotificationEnum nEnum) async
  {
    if(db==null)
    {
      await open_Database();
    }
    List<Map<String, dynamic>>? maps;
    switch(nEnum)
    {
      case NotificationEnum.def:
        maps = await db?.rawQuery("SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId})");
        break;
      case NotificationEnum.total:
        maps = await db?.rawQuery("SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId})");
        break;

        case NotificationEnum.recent:
        maps = await db?.rawQuery("SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId}) AND status = 'solved'");
        break;
      case NotificationEnum.pending:
        maps = await db?.rawQuery("SELECT * from ${DBDetails.DBTable_COMPLAIN} where (iduser = ${userId}) AND status = 'pending'");
        break;
    }
    List<NotificationPageModel> model =[];
    print(maps!.length);

    if(maps.length>0)
      {
        maps.forEach((card) {
          // print(card);
          // Map<String, dynamic> json = card;
          //
          // NotificationPageModel nModel = NotificationPageModel(
          //   complainId: json["complainId"],
          //   name: json["name"],
          //   email: json["email"],
          //   phone: json["phone"],
          //   detailsByUser: json["detailsByUser"],
          //   image: json["image"],
          //   status: json["status"],
          //   showNotiftoUser: json["showNotiftoUser"],
          //   showNotiftoOrg: json["showNotiftoOrg"],
          //
          // );
          //
          //
          // // print(nModel);
          // model.add(nModel);
          var nModel = NotificationPageModel.fromMap(card);
          // print("complainId: "+nModel.complainId.toString());
          // print("iduser: "+nModel.iduser.toString());
          // print("organizationsId: "+nModel.organizationsId.toString());
          // print("name: "+nModel.name.toString());
          // print("phone: "+nModel.phone.toString());
          // print("email: "+nModel.email.toString());
          // print("detaiilsByOrg: "+nModel.detaiilsByOrg.toString());
          // print("detailsByUser: "+nModel.detailsByUser.toString());
          // print("showNotiftoOrg: "+nModel.showNotiftoOrg.toString());
          // print("showNotiftoUser: "+nModel.showNotiftoUser.toString());
          //
          // print("");
          // print("");
          // print("");

          model.add(nModel);
        });
        // print(model.length);

        return model;

      }

    return null;
  }

}
