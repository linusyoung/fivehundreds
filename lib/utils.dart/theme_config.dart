import 'package:flutter/cupertino.dart';

class ThemeConfig {
  static Brightness theme = Brightness.light;

  ThemeConfig.init(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness;
  }
}
