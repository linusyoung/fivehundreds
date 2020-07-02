import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ShadowText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;

  ShadowText({@required this.text, @required this.style, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 1.0,
          left: 1.0,
          child: Text(
            text,
            style: style.copyWith(color: color.withOpacity(0.9)),
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 1.0,
            sigmaY: 0.5,
          ),
          child: Text(
            text,
            style: style.copyWith(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
