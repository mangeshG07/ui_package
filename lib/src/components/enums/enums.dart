enum AppButtonType { primary, secondary, outline, text }

enum AppButtonSize { small, medium, large }

enum AppFilePickType {
  cameraImage,
  galleryImage,
  cameraVideo,
  galleryVideo,
  multiImage,
}

final class AppFilePickerConfig {
  final bool allowVideo;
  final bool allowMultiImage;

  const AppFilePickerConfig({
    this.allowVideo = false,
    this.allowMultiImage = false,
  });
}

typedef LocationSearchCallback =
    Future<List<Map<String, dynamic>>> Function(String query);

typedef LocationSelectedCallback = void Function(Map<String, dynamic> location);


enum AppPermission { camera, storage, photos, location, notification }