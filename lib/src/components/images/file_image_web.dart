import 'package:flutter/material.dart';

Widget buildFileImage({
  required String path,
  double? height,
  double? width,
  BoxFit fit = BoxFit.cover,
  Color? color,
  Widget? placeholder,
  Widget? errorWidget,
}) {
  // dart:io File is not available on Web.
  //
  // For Web, local file paths cannot be loaded using Image.file
  // or SvgPicture.file.
  //
  // If the value is not a network URL or asset, show error.

  return errorWidget ??
      const Icon(
        Icons.broken_image,
        size: 40,
        color: Colors.grey,
      );
}