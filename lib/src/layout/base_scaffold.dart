import 'package:flutter/material.dart';
import 'package:ui_package/src/components/loader/app_loader.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final bool loading;
  final AppBar? appBar;

  const BaseScaffold({
    super.key,
    required this.body,
    this.loading = false,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          body: SafeArea(child: body),
        ),
        if (loading) const AppLoader(),
      ],
    );
  }
}
