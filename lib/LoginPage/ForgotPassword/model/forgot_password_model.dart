import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';
import 'package:unnayan/LoginPage/view/loginpage_view.dart';

class ForgotPasswordModel {
  String? Email;
  Database? db;

  ForgotPasswordModel({this.Email});

  Future<bool> onVerifiedEmail(String? email) async {
    db ??= await DBDetails.InitDatabase();

    String query =
        "SELECT email from ${DBDetails.DBTable_USER} where email = '$email'";
    List<Map<String, dynamic>>? map = await db!.rawQuery(query);

    if (map.isNotEmpty) {
      log("E true");
      return true;
    }
    log("E false");

    return false;
  }

  Future<void> resetPass(
      String? pass, String? email, BuildContext context) async {
    db ??= await DBDetails.InitDatabase();

    String query =
        "UPDATE ${DBDetails.DBTable_USER} SET password = ? WHERE email = ?";
    int count = await db!.rawUpdate(query, [pass, email]);

    if (count == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => LoginPage())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
