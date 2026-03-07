enum AppButtonType { primary, secondary, outline, text }

enum AppButtonSize { small, medium, large }

enum AppFilePickType {
  cameraImage,
  galleryImage,
  cameraVideo,
  galleryVideo,
  multiImage,
}

enum ToastType { success, error, warning, info }

enum DialogType { alert, confirm, info, success, error, warning }

enum LoaderSize { small, medium, large }

enum ImageType { network, asset, file, memory }

enum InputType {
  text,
  email,
  password,
  number,
  phone,
  multiline,
  date,
  time,
  datetime,
}

enum ValidationType {
  required,
  email,
  phone,
  number,
  minLength,
  maxLength,
  pattern,
  custom,
}

enum NetworkStatus { connected, disconnected, connecting }

enum PermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited,
}

enum MediaType { image, video, audio, document, all }

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

enum CachePriority { low, normal, high }

enum AnimationType { fade, slide, scale, size, custom }

enum KeyboardType { text, multiline, number, phone, email, url, datetime }

enum TabStyle { primary, secondary, underline, filled }

enum CardStyle { elevated, outlined, flat }

enum BadgePosition { topLeft, topRight, bottomLeft, bottomRight }

enum DividerStyle { solid, dashed, dotted }

enum AvatarSize { extraSmall, small, medium, large, extraLarge }

enum ListTileStyle { oneLine, twoLine, threeLine }

enum SnackbarPosition { top, bottom }

enum ProgressStyle { linear, circular }

enum EmptyStateStyle { icon, image, illustration }

enum NetworkImageFit { cover, contain, fill, fitWidth, fitHeight, none }

enum DateFormat {
  ddMMyyyy,
  MMddyyyy,
  yyyyMMdd,
  ddMMMyyyy,
  MMMddyyyy,
  ddMMMMyyyy,
  MMMMddyyyy,
  EEEddMMMyyyy,
  yyyyMMddHHmmss,
  HHmm,
  HHmmss,
}
