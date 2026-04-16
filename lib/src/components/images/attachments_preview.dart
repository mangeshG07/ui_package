import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ui_package/src/components/images/file_utils.dart';
import 'package:ui_package/ui_package.dart';
import 'package:widget_zoom/widget_zoom.dart';

/// Multiple attachments preview
class AttachmentPreviewList extends StatelessWidget {
  final List<String> attachments;
  final void Function(String path) onDownload;
  final AttachmentPreviewConfig config;

  const AttachmentPreviewList({
    super.key,
    required this.attachments,
    required this.onDownload,
    this.config = const AttachmentPreviewConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: config.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        itemBuilder: (context, index) {
          final file = attachments[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: AttachmentCard(
              file: file,
              onDownload: onDownload,
              config: config,
            ),
          );
        },
      ),
    );
  }
}

/// Single attachment card
class AttachmentCard extends StatelessWidget {
  final String file;
  final void Function(String) onDownload;
  final AttachmentPreviewConfig config;

  const AttachmentCard({
    super.key,
    required this.file,
    required this.onDownload,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = file.split('/').last;
    final extension = name.split('.').last.toLowerCase();
    final isImage = FileUtils.isImage(extension);

    return Container(
      width: 160.h,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.dividerTheme.color!),
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
                    child: Image.network(
                      file,
                      height: 80,
                      width: double.infinity,
                      loadingBuilder: (_, __, ___) => AppLoader.circular(),
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.broken_image,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    // FadeInImage.assetNetwork(
                    //   placeholder: 'assets/default_image.png',
                    //   image: file,
                    //   height: 80,
                    //   width: double.infinity,
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                )
              else
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FileUtils.getFileTypeColor(extension),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    FileUtils.getIconForFile(name),
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              if (config.showDownload && onDownload != null)
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
