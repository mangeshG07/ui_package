import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final Color color;
  final Color overlayColor;
  final double strokeWidth;

  const AppLoader({
    super.key,
    this.color = Colors.white,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.3),
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: overlayColor,
      alignment: Alignment.center,
      child: Platform.isIOS
          ? CupertinoActivityIndicator(color: color, radius: 12)
          : CircularProgressIndicator(strokeWidth: strokeWidth, color: color),
    );
  }
}
