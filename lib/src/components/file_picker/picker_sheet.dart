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
    final isOnlyDocument =
        config.allowDocument && !config.allowVideo && !config.allowMultiImage;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔹 DRAG HANDLE (Professional UI)
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              if (isOnlyDocument) ...[
                _item(Icons.insert_drive_file, 'Pick Document', () async {
                  final file = await PickerHelpers.pickDocument(
                    config.allowedExtensions,
                  );
                  if (file != null) onPicked(file);
                  Get.back();
                }),

                if (config.allowMultiDocument) _divider(),

                if (config.allowMultiDocument)
                  _item(Icons.folder_copy, 'Multiple Documents', () async {
                    final files = await PickerHelpers.pickMultipleDocuments();
                    if (files != null && onMultiPicked != null) {
                      onMultiPicked!(files);
                    }
                    Get.back();
                  }),
              ]
              /// ✅ NORMAL MODE (images/videos + documents)
              else ...[
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

                /// 🎥 VIDEO
                if (config.allowVideo) ...[
                  _divider(),
                  _item(Icons.videocam, 'Camera Video', () async {
                    final file = await PickerHelpers.pickCameraVideo();
                    if (file != null) onPicked(file);
                    Get.back();
                  }),

                  _divider(),
                  _item(Icons.video_library, 'Gallery Video', () async {
                    final file = await PickerHelpers.pickGalleryVideo();
                    if (file != null) onPicked(file);
                    Get.back();
                  }),
                ],

                /// 🖼 MULTI IMAGE
                if (config.allowMultiImage) ...[
                  _divider(),
                  _item(Icons.collections, 'Multiple Images', () async {
                    final files = await PickerHelpers.pickMultiImages();
                    if (files != null && onMultiPicked != null) {
                      onMultiPicked!(files);
                    }
                    Get.back();
                  }),
                ],

                /// 📄 DOCUMENT (NOW INCLUDED ✅)
                if (config.allowDocument) ...[
                  _divider(),
                  _item(Icons.insert_drive_file, 'Pick Document', () async {
                    final file = await PickerHelpers.pickDocument(
                      config.allowedExtensions,
                    );
                    if (file != null) onPicked(file);
                    Get.back();
                  }),
                ],

                /// 📄 MULTI DOCUMENT
                if (config.allowMultiDocument) ...[
                  _divider(),
                  _item(Icons.folder_copy, 'Multiple Documents', () async {
                    final files = await PickerHelpers.pickMultipleDocuments();
                    if (files != null && onMultiPicked != null) {
                      onMultiPicked!(files);
                    }
                    Get.back();
                  }),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  Widget _divider() => const Divider(height: 6);
}
