import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/HomePage/ProfilePanel/model/profilepanel_model.dart';

class ProfileController extends ControllerMVC {
  factory ProfileController() => _this ??= ProfileController._();

  ProfileController._()
      : model = ProfileModel(),
        super();

  static ProfileController? _this;
  final ProfileModel model;

  Future<int> getTotalData(int ID) async {
    return await model.getTotalData(ID);
  }

  Future<int> getPendingData(int ID) async {
    return await model.getPendingData(ID);
  }

  Future<int> getHistoryData(int ID) async {
    return await model.getHistoryData(ID);
  }
}
