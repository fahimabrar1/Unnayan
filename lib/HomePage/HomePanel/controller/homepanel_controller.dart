import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/HomePage/HomePanel/model/homepanel_model.dart';

class HomePageController extends ControllerMVC {
  factory HomePageController() => _this ??= HomePageController._();

  HomePageController._()
      : model = HomeORGPageModel(),model2 = HomeINSPageModel(),
        super();

  static HomePageController? _this;
  final HomeORGPageModel model;
  final HomeINSPageModel model2;


  List<HomeORGPageGrid>? organization_grid;
  List<HomeINSPageGrid>? institues_grid;
  List<MyMainGrid>? grid;

  Future<void> getHomePageGrid() async{
     organization_grid = await model.getOrganizationGrid();
     print(organization_grid);
     grid = organization_grid;
     setState(() {
       grid = organization_grid;

     });
  }

  Future<void> getInstitueseGrid(int id) async{
    await model2.getInstitueGrid(id).then((value){
      institues_grid = value;
      grid = institues_grid;
      // print("Grids:");
      // print(grid);
    });

  }

  Future<void> initDatabase() async{
    await model.open_Database();
  }
}