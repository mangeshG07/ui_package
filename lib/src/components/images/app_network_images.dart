import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../loader/app_loader.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onTap;
  final bool useCache;
  final int? cacheWidth;
  final int? cacheHeight;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.useCache = true,
    this.cacheWidth,
    this.cacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = useCache
        ? CachedNetworkImage(
      imageUrl: imageUrl,
      width: width?.w,
      height: height?.h,
      fit: fit,
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildError(),
    )
        : Image.network(
      imageUrl,
      width: width?.w,
      height: height?.h,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildPlaceholder();
      },
      errorBuilder: (context, error, stackTrace) => _buildError(),
    );

    if (borderRadius != null || onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: imageWidget,
        ),
      );
    }

    return imageWidget;
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width?.w,
      height: height?.h,
      color: backgroundColor ?? AppColors.grey100,
      child: Center(
        child: placeholder ??
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: AppLoader.circular(
                strokeWidth: 2,
                color: AppColors.grey400,
              ),
            ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      width: width?.w,
      height: height?.h,
      color: backgroundColor ?? AppColors.grey100,
      child: Center(
        child: errorWidget ??
            Icon(
              Icons.broken_image,
              size: 24.sp,
              color: AppColors.grey400,
            ),
      ),
    );
  }
}

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? AppNetworkImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        )
            : Container(
          width: size,
          height: size,
          color: backgroundColor ?? AppColors.primary,
          child: Center(
            child: Text(
              initials?.substring(0, 1).toUpperCase() ?? '?',
              style: TextStyle(
                fontSize: size * 0.4,
                color: textColor ?? AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}