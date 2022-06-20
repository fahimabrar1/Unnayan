import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/HomePage/HomePanel/model/homepanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/view/notificationPanel_view.dart';
import 'package:unnayan/my_vars.dart';

class NotificationPageContoller extends ControllerMVC
{
  factory NotificationPageContoller() => _this ??= NotificationPageContoller._();

  NotificationPageContoller._()
    :model = NotificationPageModel(),org = HomeORGPageModel(),super();



  static NotificationPageContoller? _this;
  final NotificationPageModel model;
  final HomeORGPageModel org;

  Future<List<NotificationPageModel>?> showList(int userID, NotificationEnum nEnum) async
  {
    List<NotificationPageModel> V =[];
    await model.showNotifications(userID,nEnum).then((value){
      print("BAL");

      V = value!;
    });

    print(V);
    return V;
  }

  Future<List<int>?> getOrgLogo(int id) async {
    return model.showORgLogo(id);
  }
}