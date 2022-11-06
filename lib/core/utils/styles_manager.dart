import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: AppFontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style
TextStyle getRegularStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.regular, color);
}

// medium style
TextStyle getMediumStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.medium, color);
}

// medium style
TextStyle getLightStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.light, color);
}

// bold style
TextStyle getBoldStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.bold, color);
}

// semi bold style
TextStyle getSemiBoldStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.semiBold, color);
}
