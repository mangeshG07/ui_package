import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildFileImage({
  required String path,
  double? height,
  double? width,
  BoxFit fit = BoxFit.cover,
  Color? color,
  Widget? placeholder,
  Widget? errorWidget,
}) {
  final file = File(path);

  // File doesn't exist
  if (!file.existsSync()) {
    return errorWidget ??
        const Icon(
          Icons.broken_image,
          size: 40,
          color: Colors.grey,
        );
  }

  final isSvg = path.toLowerCase().endsWith('.svg');

  // ============================================================
  // LOCAL SVG
  // ============================================================

  if (isSvg) {
    return SvgPicture.file(
      file,
      height: height,
      width: width,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(
        color,
        BlendMode.srcIn,
      )
          : null,
    );
  }

  // ============================================================
  // LOCAL IMAGE
  // ============================================================

  return Image.file(
    file,
    height: height,
    width: width,
    fit: fit,
    color: color,
    errorBuilder: (_, __, ___) {
      return errorWidget ??
          const Icon(
            Icons.broken_image,
            size: 40,
            color: Colors.grey,
          );
    },
  );
}