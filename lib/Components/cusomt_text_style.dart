import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unnayan/my_color.dart';

class CustomTextStyle {
  static TextStyle textStyle(Color color, double? fontSize) {
    return GoogleFonts.rubik(color: color, fontSize: fontSize);
  }
}
