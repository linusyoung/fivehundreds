import 'package:flutter/cupertino.dart';

class ThemeConfig {
  static Brightness theme;

  ThemeConfig.init(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness;
  }
}
