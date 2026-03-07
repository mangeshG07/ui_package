import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilConfig {
  /// Initializes ScreenUtil using current device size
  static Widget init({
    required Widget child,
    required BuildContext context,
    bool minTextAdapt = true,
    bool splitScreenMode = true,
  }) {
    final size = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      minTextAdapt: minTextAdapt,
      splitScreenMode: splitScreenMode,
      useInheritedMediaQuery: true,
      builder: (_, __) => child,
    );
  }
}

class ScreenUtilWrapper extends StatelessWidget {
  final Widget child;
  final double? designSizeWidth;
  final double? designSizeHeight;
  final bool splitScreenMode;

  const ScreenUtilWrapper({
    super.key,
    required this.child,
    this.designSizeWidth,
    this.designSizeHeight,
    this.splitScreenMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        designSizeWidth ?? MediaQuery.of(context).size.width,
        designSizeHeight ?? MediaQuery.of(context).size.height,
      ),
      splitScreenMode: splitScreenMode,
      minTextAdapt: true,
      builder: (context, child) => this.child,
    );
  }
}

// // Extension methods for responsive sizing
// extension ResponsiveExtension on num {
//   double get w => ScreenUtil().setWidth(this);
//   double get h => ScreenUtil().setHeight(this);
//   double get r => ScreenUtil().radius(this);
//   double get sp => ScreenUtil().setSp(this);
//   double get sw => ScreenUtil().screenWidth * this;
//   double get sh => ScreenUtil().screenHeight * this;
// }

// Responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenUtil screenUtil) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, ScreenUtil());
  }
}

// Orientation builder
class OrientationBuilderWidget extends StatelessWidget {
  final Widget Function(BuildContext context, Orientation orientation) builder;

  const OrientationBuilderWidget({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, MediaQuery
        .of(context)
        .orientation);
  }
}
//
// @override
// Widget build(BuildContext context) {
//   return ScreenUtilConfig.init(
//     context: context,
//     child: MaterialApp(
//       home: HomePage(),
//     ),
//   );
// }
