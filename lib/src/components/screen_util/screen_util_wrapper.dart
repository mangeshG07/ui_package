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
