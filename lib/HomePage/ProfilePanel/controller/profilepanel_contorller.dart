import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unnayan/HomePage/ProfilePanel/model/profilepanel_model.dart';

class ProfileController extends ControllerMVC {
  factory ProfileController() => _this ??= ProfileController._();

  ProfileController._()
      : model = ProfileModel(),
  super();

  static ProfileController? _this;
  final ProfileModel model;



  Future<dynamic> fetchUserDP() async
  {
    FirebaseStorage store = FirebaseStorage.instance;
    print(store);
    print(store.app);
    print(FirebaseStorage.instance.
    ref('users').
    child('fahim'));
    return await FirebaseStorage.instance.
    ref().
        child('users/fahim').
    getDownloadURL();
  }
}