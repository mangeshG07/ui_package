import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_package/ui_package.dart';
import 'picker_helpers.dart';

class PickerSheet extends StatelessWidget {
  final AppFilePickerConfig config;
  final Function(File) onPicked;
  final Function(List<File>)? onMultiPicked;

  const PickerSheet({
    super.key,
    required this.config,
    required this.onPicked,
    this.onMultiPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        children: [
          _item(Icons.camera_alt, 'Camera Image', () async {
            final file = await PickerHelpers.pickCameraImage();
            if (file != null) onPicked(file);
            Get.back();
          }),
          _divider(),
          _item(Icons.image, 'Gallery Image', () async {
            final file = await PickerHelpers.pickGalleryImage();
            if (file != null) onPicked(file);
            Get.back();
          }),
          if (config.allowVideo) _divider(),
          if (config.allowVideo)
            _item(Icons.videocam, 'Camera Video', () async {
              final file = await PickerHelpers.pickCameraVideo();
              if (file != null) onPicked(file);
              Get.back();
            }),
          if (config.allowVideo) _divider(),
          if (config.allowVideo)
            _item(Icons.video_library, 'Gallery Video', () async {
              final file = await PickerHelpers.pickGalleryVideo();
              if (file != null) onPicked(file);
              Get.back();
            }),
          if (config.allowMultiImage) _divider(),
          if (config.allowMultiImage)
            _item(Icons.collections, 'Multiple Images', () async {
              final files = await PickerHelpers.pickMultiImages();
              if (files != null && onMultiPicked != null) {
                onMultiPicked!(files);
              }
              Get.back();
            }),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _divider() => const Divider(height: 6);
}
