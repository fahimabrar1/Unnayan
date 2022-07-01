// To parse this JSON data, do
//
//     final complainPanelModel = complainPanelModelFromMap(jsonString);

import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sqflite/sqflite.dart';

import '../../../dbdetails.dart';

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
  // String? image;
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

  Map<String, dynamic> toMap(String filename) => {
        "complainId": complainId,
        "name": name,
        "email": email,
        "phone": phone,
        "detailsByUser": detailsByUser,
        "image": "gs://unnayan-e10b9.appspot.com/" + filename,
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

  Future insertByUser(ComplainPanelModel model, String filename) async {
    final storageRef = FirebaseStorage.instance.ref();

    final imgRef = storageRef.child(filename);
    try {
      CollectionReference users = FirebaseFirestore.instance
          .collection('db')
          .doc('unnayan')
          .collection('complain');
      log("THE IMAGE" + imgRef.toString());
      log("THE IMAGE NAME:" + imgRef.name);

      users.add(model.toMap(filename)).then((value) {
        users.doc(value.id).update({'complainId': value.id});
      });

      await imgRef.putData(Uint8List.fromList(model.image!));
    } catch (e) {}
    if (db == null) {
      await open_Database();
    }
  }
}
