import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_package/ui_package.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class PickerHelpers {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickCameraImage() async {
    final x = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    return x != null ? File(x.path) : null;
  }

  static Future<File?> pickGalleryImage() async {
    final x = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    return x != null ? File(x.path) : null;
  }

  static Future<File?> pickCameraVideo() async {
    final x = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: AppFilePickerConfig().maxVideoDuration),
    );
    return x != null ? File(x.path) : null;
  }

  static Future<File?> pickGalleryVideo() async {
    final x = await _picker.pickVideo(source: ImageSource.gallery);
    if (x == null) return null;
    return _validateVideo(File(x.path));
  }

  static Future<List<File>?> pickMultiImages() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    return result?.paths.whereType<String>().map((e) => File(e)).toList();
  }

  static Future<File?> _validateVideo(File file) async {
    final controller = VideoPlayerController.file(file);
    await controller.initialize();
    final maxDuration = AppFilePickerConfig().maxVideoDuration;

    if (controller.value.duration.inSeconds > maxDuration) {
      Get.snackbar('Invalid Video', 'Video must be 15 seconds or less');
      await controller.dispose();
      return null;
    }

    await controller.dispose();
    return file;
  }

  static Future<List<File>?> pickMultipleDocuments() async {
    final config = AppFilePickerConfig();

    final result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: config.allowedExtensions,
    );

    if (result == null) return null;

    List<File> validFiles = [];

    for (var file in result.files) {
      final path = file.path;
      if (path == null) continue;

      final f = File(path);

      // ✅ check file size (2MB)
      if (f.lengthSync() > config.maxFileSize) {
        Get.snackbar(
          'Error',
          '${file.name} must be less than ${_formatSize(config.maxFileSize)}',
        );
        continue; // skip this file
      }

      validFiles.add(f);
    }

    return validFiles.isEmpty ? null : validFiles;
  }

  static Future<File?> pickDocument(List<String>? allowedExtensions) async {
    final config = AppFilePickerConfig();
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions ?? config.allowedExtensions,
    );

    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);

    /// ✅ File size validation
    if (file.lengthSync() > config.maxFileSize) {
      Get.snackbar(
        'Error',
        'File must be less than ${_formatSize(config.maxFileSize)}',
      );
      return null;
    }

    return file;
  }

  /// 📦 Helper: Format file size
  static String _formatSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(0)}MB';
    } else if (bytes >= 1024) {
      return '${(bytes / 1024).toStringAsFixed(0)}KB';
    }
    return '$bytes B';
  }
}
