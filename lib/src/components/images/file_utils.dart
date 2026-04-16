import 'package:flutter/material.dart';

class FileUtils {
  static Color getFileTypeColor(String extension) {
    switch (extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static IconData getIconForFile(String name) {
    final ext = name.split('.').last.toLowerCase();

    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.grid_on;
      default:
        return Icons.insert_drive_file;
    }
  }

  static bool isImage(String extension) {
    return ['jpg', 'jpeg', 'png', 'gif', 'webp']
        .contains(extension.toLowerCase());
  }
}