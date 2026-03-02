import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            )
          : null,
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
