import 'package:flutter/material.dart';

class ThemeUtils {
  static Color? primaryColor;
  static Color? primaryColorDark;
  static Color? primaryColorLight;
  static Color? accentColor;
  static Color? errorColor;
  static Color? successColor;
  static Color? warningColor;
  static ThemeData? theme;

  static void init(BuildContext context) {
    theme = Theme.of(context);
    primaryColor = theme?.primaryColor;
    primaryColorDark = theme?.primaryColorDark;
    primaryColorLight = theme?.primaryColorLight;
    accentColor = theme?.accentColor;
    errorColor = theme?.errorColor;
    successColor = Color(0xFF4caf50);
    warningColor = Color(0xFFff9800);
  }
}
