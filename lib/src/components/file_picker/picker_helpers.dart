import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class PickerHelpers {
  static Future<File?> pickCameraImage() async {
    final x = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    return x != null ? File(x.path) : null;
  }

  static Future<File?> pickGalleryImage() async {
    final x = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    return x != null ? File(x.path) : null;
  }

  static Future<File?> pickCameraVideo() async {
    final x = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 15),
    );
    return x != null ? File(x.path) : null;
  }

  static Future<File?> pickGalleryVideo() async {
    final x = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (x == null) return null;
    return _validateVideo(File(x.path));
  }

  static Future<List<File>?> pickMultiImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    return result?.paths.whereType<String>().map((e) => File(e)).toList();
  }

  static Future<File?> _validateVideo(File file) async {
    final controller = VideoPlayerController.file(file);
    await controller.initialize();

    if (controller.value.duration.inSeconds > 15) {
      Get.snackbar('Invalid Video', 'Video must be 15 seconds or less');
      await controller.dispose();
      return null;
    }

    await controller.dispose();
    return file;
  }
}
