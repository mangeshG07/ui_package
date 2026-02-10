import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Utility functions (replace these with your own implementation)
Color getFileTypeColor(String extension) {
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

IconData getIconForFile(String name) {
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

/// Placeholder for image zoom widget (replace with actual)
class WidgetZoom extends StatelessWidget {
  final Widget zoomWidget;
  final String heroAnimationTag;
  const WidgetZoom({
    super.key,
    required this.zoomWidget,
    required this.heroAnimationTag,
  });

  @override
  Widget build(BuildContext context) {
    return zoomWidget;
  }
}

/// Multiple attachments preview
class AttachmentPreviewList extends StatelessWidget {
  final List<String> attachments;
  final void Function(String path) onDownload;
  final bool isDownload;

  const AttachmentPreviewList({
    super.key,
    required this.attachments,
    required this.onDownload,
    this.isDownload = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        itemBuilder: (context, index) {
          final file = attachments[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SingleAttachmentCard(
              file: file,
              onDownload: onDownload,
              isDownload: isDownload,
            ),
          );
        },
      ),
    );
  }
}

/// Single attachment card
class SingleAttachmentCard extends StatelessWidget {
  final String file;
  final void Function(String) onDownload;
  final bool isDownload;

  const SingleAttachmentCard({
    super.key,
    required this.file,
    required this.onDownload,
    this.isDownload = true,
  });

  @override
  Widget build(BuildContext context) {
    final name = file.split('/').last;
    final extension = name.split('.').last.toLowerCase();
    final isImage = ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension);

    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              if (isImage)
                WidgetZoom(
                  heroAnimationTag: 'tag $name',
                  zoomWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/default_image.png',
                      image: file,
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: getFileTypeColor(extension),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    getIconForFile(name),
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              if (isDownload)
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withValues(alpha: 0.6),
                    child: InkWell(
                      onTap: () => onDownload(file),
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.download,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name.length > 20 ? '${name.substring(0, 20)}...' : name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// AttachmentPreviewList(
// attachments: attachments,
// onDownload: (path) {
// print('Download clicked: $path');
// },
// ),
