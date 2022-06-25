import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';

class ComplainFeedBackPanelModel {
  ComplainFeedBackPanelModel({
    this.iduser,
    this.username,
    this.location,
    this.image,
  });

  int? iduser;
  String? username;
  List<int>? image;
  String? location;

  Database? db;

  factory ComplainFeedBackPanelModel.fromMap(Map<String, dynamic> json) {
    return ComplainFeedBackPanelModel(
      iduser: json["iduser"],
      username: json["username"].toString(),
      image: json["image"],
      location: json["location"],
    );
  }

  Future<ComplainFeedBackPanelModel?> getUserData(int ID) async {
    if (db == null) {
      db = await DBDetails.InitDatabase();
    }
    List<Map<String, dynamic>>? maps = await db!.rawQuery(
        "SELECT iduser,username,image,location from user where iduser = ${ID}");
    if (maps.length == 1) {
      ComplainFeedBackPanelModel user =
          ComplainFeedBackPanelModel.fromMap(maps[0]);
      // print(user.username);
      return user;
    }
    return null;
  }

  Future<void> insertFeedbackByOrg(int complainId, String detailsByOrg) async {
    db ??= await DBDetails.InitDatabase();
    String query =
        "UPDATE ${DBDetails.DBTable_COMPLAIN} SET status = ?,detaiilsByOrg = ? , showNotiftoUser= ?, repliedToUser =? WHERE complainId = ?";
    int updated = await db!
        .rawUpdate(query, ['solved', detailsByOrg, 'true', 'true', complainId]);
    if (updated == 1) {
      const SnackBar(
        content: Text('Submitted Feedback'),
      );
    } else {
      const SnackBar(
        content: Text('Error, Try Again later'),
      );
    }
  }
}
