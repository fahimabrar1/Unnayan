import 'dart:developer';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/HomePage/HomePanel/model/homepanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/my_vars.dart';

class NotificationPageController extends ControllerMVC {
  factory NotificationPageController() =>
      _this ??= NotificationPageController._();

  NotificationPageController._()
      : model = NotificationPageModel(),
        org = HomeORGPageModel(),
        super();

  static NotificationPageController? _this;
  final NotificationPageModel model;
  final HomeORGPageModel org;

  Future<List<NotificationPageModel>?> showList(int userID,
      NotificationEnum nEnum, String repliedToUser, String userType) async {
    List<NotificationPageModel> V = [];
    await model
        .showNotifications(userID, nEnum, repliedToUser, userType)
        .then((value) {
      log("BAL");
      if (value == null) {
        return null;
      }
      V = value;
    });

    log(V.toString());
    return V;
  }

  Future<List<int>?> getOrgLogo(int id) async {
    return model.showORgLogo(id);
  }

  Future<void> updateComplainNotificationToUserToFalse(
      int complainId, String showNotifToUserStr) async {
    model.updateComplainNotificationToUserToFalse(
        complainId, showNotifToUserStr);
  }
}
