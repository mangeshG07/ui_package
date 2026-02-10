import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppCarouselSlider extends StatefulWidget {
  final List<String> imageUrls;

  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  final bool autoPlay;
  final Duration autoPlayInterval;

  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;

  final Widget? placeholder;
  final Widget? errorWidget;

  const AppCarouselSlider({
    super.key,
    required this.imageUrls,
    required this.height,
    this.borderRadius = 12,
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.activeIndicatorColor = Colors.blue,
    this.inactiveIndicatorColor = Colors.grey,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<AppCarouselSlider> createState() => _AppCarouselSliderState();
}

class _AppCarouselSliderState extends State<AppCarouselSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1,
            autoPlay: widget.autoPlay,
            autoPlayInterval: widget.autoPlayInterval,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, _) => _currentIndex.value = index,
          ),
          items: widget.imageUrls.map(_buildImage).toList(),
        ),

        _buildIndicators(),
      ],
    );
  }

  Widget _buildImage(String url) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (_, __) =>
              widget.placeholder ??
              const Center(child: CircularProgressIndicator()),
          errorWidget: (_, __, ___) =>
              widget.errorWidget ?? const Icon(Icons.broken_image),
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (_, index, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (i) {
              final isActive = index == i;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 10 : 8,
                height: isActive ? 10 : 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? widget.activeIndicatorColor
                      : widget.inactiveIndicatorColor,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

// AppCarouselSlider(
// imageUrls: banners,
// height: 200,
// activeIndicatorColor: Colors.green,
// placeholder: Image.asset('assets/placeholder.png'),
// );
