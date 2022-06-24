// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromMap(jsonString);

import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/dbdetails.dart';

// HomeORGPageGrid HomePageORGGridFromMap(String str) => HomeORGPageGrid.fromMap(json.decode(str));
//
// String homePageORGModelToMap(HomeORGPageGrid data) => json.encode(data.toMap());
//
// HomeINSPageGrid HomePageINSGridFromMap(String str) => HomeINSPageGrid.fromMap(json.decode(str));
//
// String homePageINSModelToMap(HomeINSPageGrid data) => json.encode(data.toMap());

class HomeORGPageModel {
  Database? db;

  Future<void> open_Database() async {
    db = await DBDetails.InitDatabase();
  }

  Future<List<HomeORGPageGrid>?> getOrganizationGrid() async {
    if (db == null) {
      db = await DBDetails.InitDatabase();
    }
    // Get the records
    List<Map<String, dynamic>>? maps = await db
        ?.rawQuery("SELECT * FROM ${DBDetails.DBTable_ORGANIZATIONSTYPE}");
    List<HomeORGPageGrid> grid = [];
    if (maps!.length > 0) {
      maps.forEach((card) {
        grid.add(HomeORGPageGrid.fromMap(card));
      });
      return grid;
    }
    return null;
  }

  Future close() async => db!.close();
}

class HomeINSPageModel {
  Database? db;

  Future<void> open_Database() async {
    db = await DBDetails.InitDatabase();
  }

  Future<List<HomeINSPageGrid>?> getInstitueGrid(int ID) async {
    // Get the records
    if (db == null) {
      db = await DBDetails.InitDatabase();
    }

    List<Map<String, dynamic>>? maps = await db?.rawQuery(
        "SELECT * FROM ${DBDetails.DBTable_ORGANIZATIONS} WHERE ( ${DBDetails.DBTable_Where_ORGANIZATIONSTYPEID} = '${ID}' )");
    List<HomeINSPageGrid> grid = [];
    if (maps!.length > 0) {
      maps.forEach((card) {
        grid.add(HomeINSPageGrid.fromMap(card));
      });

      return grid;
    }
    return null;
  }

  Future close() async => db!.close();
}

class MyMainGrid {
  String? organizationTypeId;
  String? name;
  List<int>? image;
}

class HomeORGPageGrid extends MyMainGrid {
  HomeORGPageGrid({
    this.organizationTypeId,
    this.name,
    this.image,
  });

  @override
  String? organizationTypeId;
  @override
  String? name;
  @override
  List<int>? image;

  factory HomeORGPageGrid.fromMap(Map<String, dynamic> json) => HomeORGPageGrid(
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

class HomeINSPageGrid extends MyMainGrid {
  HomeINSPageGrid({
    this.organizationId,
    this.organizationTypeId,
    this.name,
    this.image,
  });

  @override
  String? organizationTypeId;
  @override
  String? name;
  @override
  List<int>? image;
  String? organizationId;

  factory HomeINSPageGrid.fromMap(Map<String, dynamic> json) {
    return HomeINSPageGrid(
      organizationId: json["organizationsId"].toString(),
      organizationTypeId: json["organizationTypeId"].toString(),
      image: json["image"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toMap() => {
        "organizationTypeId": organizationTypeId,
        "name": name,
        "image": image,
        "organizationId": organizationId,
      };
}
