import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double screenWidth = 500;
  static double screenHeight = 800;
  static double blockSizeHorizontal = 5;
  static double blockSizeVertical = 8;
  static double? pixelRatio;
  static double? _shortestSide;
  static const double _sizeThreshold = 750;
  static bool isPhone = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    pixelRatio = _mediaQueryData!.devicePixelRatio;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _shortestSide = _mediaQueryData!.size.shortestSide;
    isPhone = _shortestSide! < _sizeThreshold ? true : false;
  }
}
