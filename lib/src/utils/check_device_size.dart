import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

bool checkDesktopSize(BuildContext context) {
  return context.widthPx > Dimens.largeDeviceBreakPoint;
}

bool checkMediumDeviceSize( BuildContext context) {
  return context.widthPx > Dimens.mediumDeviceBreakPoint;
}

bool checkSmallDeviceSize( BuildContext context) {
  return context.widthPx < Dimens.smallDeviceBreakPoint;
}

bool checkVerySmallDeviceSize( BuildContext context) {
  return context.widthPx < Dimens.verySmallDeviceBreakPoint;
}
