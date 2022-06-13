import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/HomePage/HomePanel/model/homepanel_model.dart';

class HomePageController extends ControllerMVC {
  factory HomePageController() => _this ??= HomePageController._();

  HomePageController._()
      : model = HomePageModel(),
        super();

  static HomePageController? _this;
  final HomePageModel model;


  List<HomePageGrid>? grid;

  Future<void> getHomePageGrid() async{
     grid = await model.getGrid();
     print(grid);
  }

  Future<void> initDatabase() async{
    await model.open_Database();
  }
}