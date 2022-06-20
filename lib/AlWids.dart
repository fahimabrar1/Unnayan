

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainFeedbackPanel/view/complain_feedback_panel.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainPanel/view/complainpanel_view.dart';
import 'package:unnayan/HomePage/HomePanel/Institue/view/institueGridView.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/view/notificationPanel_view.dart';
import 'package:unnayan/HomePage/ProfilePanel/view/profilepanel_view.dart';
import 'package:unnayan/my_vars.dart';

import 'HomePage/HomePanel/view/homepanel_view.dart';


class WidContainer extends ChangeNotifier{
  Widget homePanel = HomePagePanel(HomePageEnum.org,null);
  Widget profilePanel = ProfileSTL();
  HomePageEnum homeEnum = HomePageEnum.org;
  int? INSID;


  Widget getPanel()
  {
    resetHome();
    notifyListeners();
    return homePanel;
  }

  void resetHome()
  {
    homePanel = HomePagePanel(HomePageEnum.org,null);
    profilePanel = const ProfileSTL();

    notifyListeners();

  }

  void setToInst(int ID)
  {
    INSID = ID;
    homePanel = InstituteGridPanel(ID);
    notifyListeners();
  }

  void setToComplainPage(int ID)
  {
    homePanel = ComplainPage(ID);
    notifyListeners();
  }


  void setToProgileTONotificationPanel(String notificationTitle , NotificationEnum nEnum)
  {
    profilePanel =  NotificationPage(heading: notificationTitle,nEnum: nEnum,);
    notifyListeners();

  }


  void setToProgileTONFeedbackpanel(NotificationPageModel notificationPageModel)
  {
    profilePanel =  ComplainFeedbackSTL( notificationPageModel);
    notifyListeners();

  }


}