import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainPanel/model/complainpanel_model.dart';
import 'package:unnayan/HomePage/dbdetails.dart';


class ComplainPanelContorller extends ControllerMVC{

  factory ComplainPanelContorller() => _this ??= ComplainPanelContorller._();

  ComplainPanelContorller._()
      : model = ComplainPanelModel(),
        super();


  static ComplainPanelContorller? _this;
  final ComplainPanelModel model;


  void submitComplain(ComplainPanelModel model,BuildContext context)
  {
    model.insert(model).whenComplete(()
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("File Attachment"),
      ),);
    });
  }


}