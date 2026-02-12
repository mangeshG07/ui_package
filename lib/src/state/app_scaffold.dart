import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.onDrawerChanged,
    this.drawer,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.safeAreaLeft = true,
    this.safeAreaTop = true,
    this.safeAreaRight = true,
    this.safeAreaBottom = true,
    this.safeAreaMinimum = EdgeInsets.zero,
    this.safeAreaMaintainBottomViewPadding = false,
    this.padding,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor,
    this.hasBottomSheetPadding = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final DrawerCallback? onDrawerChanged;
  final Widget? drawer;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final DragStartBehavior drawerDragStartBehavior;
  final bool safeAreaLeft;
  final bool safeAreaTop;
  final bool safeAreaRight;
  final bool safeAreaBottom;
  final EdgeInsets safeAreaMinimum;
  final bool safeAreaMaintainBottomViewPadding;
  final EdgeInsets? padding;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Key? scaffoldKey;
  final Color? backgroundColor;
  final bool hasBottomSheetPadding;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        padding ??
        EdgeInsets.symmetric(
          horizontal: checkVerySmallDeviceSize(context)
              ? Dimens.padding
              : Dimens.largePadding,
        );

    Widget content = body ?? const SizedBox.shrink();

    if (checkDesktopSize(context)) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Dimens.mediumDeviceBreakPoint),
          child: content,
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: SafeArea(
        left: safeAreaLeft,
        top: safeAreaTop,
        right: safeAreaRight,
        bottom: safeAreaBottom,
        minimum: safeAreaMinimum,
        maintainBottomViewPadding: safeAreaMaintainBottomViewPadding,
        child: Padding(padding: horizontalPadding, child: content),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
    );
  }
}
