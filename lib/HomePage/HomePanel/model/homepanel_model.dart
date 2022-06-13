// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromMap(jsonString);

import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';

HomePageGrid HomePageGridFromMap(String str) => HomePageGrid.fromMap(json.decode(str));

String homePageModelToMap(HomePageGrid data) => json.encode(data.toMap());


class HomePageModel {
  Database? db;


  Future<void> open_Database() async {
    db = await openDatabase(DBDetails.DBPATH+DBDetails.DBNAME, version: 1);
    if(db!.isOpen)
    {
      print("Database is Opended Now");

    }
  }



  Future<List<HomePageGrid>?> getGrid() async {
    // Get the records
    List<Map<String, dynamic>>? maps = await db?.rawQuery("SELECT * FROM ${DBDetails.DBTable_ORGANIZATIONSTYPE}");
    List<HomePageGrid> grid = [];
    if (maps!.length > 0) {
      maps.forEach((card) {
        grid.add(HomePageGrid.fromMap(card));
      });
      return grid;
    }
    return null;
  }


  Future close() async => db!.close();

}



class HomePageGrid{
  HomePageGrid({
    this.organizationTypeId,
    this.name,
    this.image,
  });

  String? organizationTypeId;
  String? name;
  List<int>? image;

  factory HomePageGrid.fromMap(Map<String, dynamic> json) => HomePageGrid(
    organizationTypeId: json["organizationTypeId"].toString(),
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "organizationTypeId": organizationTypeId,
    "name": name,
    "image": image,
  };
}