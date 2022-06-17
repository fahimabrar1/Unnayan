import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/view/notificationPanel.dart';

class NotificationPageContoller extends ControllerMVC
{
  factory NotificationPageContoller() => _this ??= NotificationPageContoller._();

  NotificationPageContoller._()
    :model = NotificationPageModel(),super();



  static NotificationPageContoller? _this;
  final NotificationPageModel model;


  Future<List<NotificationPageModel>?> showList(int userID) async
  {
    List<NotificationPageModel> V =[];
    await model.showNotifications(userID).then((value){
      print("BAL");

      V = value!;
    });

    print(V);
    return V;
  }
}