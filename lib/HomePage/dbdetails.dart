import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:flutter/services.dart';




class DBDetails {
  /// Database Name
  static String DBPATH = "/data/data/com.example.unnayan/databases/";
  static String DBNAME = "unnayan.db";

  /// Database Table User

  static String DBTable_USER = "user";
  static String DBTable_COMPLAIN = "complain";
  static String DBTable_ORGANIZATIONS = "organizations";
  static String DBTable_ORGANIZATIONSTYPE = "organizationType";

  //Constrains
  static String DBTable_Where_ORGANIZATIONSTYPEID = "organizationTypeId";




  static Future<Database?> InitDatabase() async {
    Database db;
    String path = DBDetails.DBPATH + DBDetails.DBNAME;
    print(path);

    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "unnayan.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
    db = await openDatabase(path);
    return db;
  }
}
