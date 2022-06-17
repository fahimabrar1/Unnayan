

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainPanel/view/complainpanel_view.dart';
import 'package:unnayan/HomePage/HomePanel/Institue/view/institueGridView.dart';
import 'package:unnayan/my_vars.dart';

import 'HomePage/HomePanel/view/homepanel_view.dart';


class WidContainer extends ChangeNotifier{
  Widget panel = HomePagePanel(HomePageEnum.org,null);
  HomePageEnum homeEnum = HomePageEnum.org;
  int? INSID;


  Widget getPanel()
  {
    resetHome();
    notifyListeners();
    return panel;
  }

  void resetHome()
  {
    panel = HomePagePanel(HomePageEnum.org,null);
    notifyListeners();

  }

  void setToInst(int ID)
  {
    INSID = ID;
    panel = InstituteGridPanel(ID);
    notifyListeners();
  }

  void setToComplainPage(int ID)
  {
    panel = ComplainPage(ID);
    notifyListeners();

  }
}