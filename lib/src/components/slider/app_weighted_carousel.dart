import 'package:flutter/material.dart';
import 'app_carousel_controller.dart';

class AppWeightedCarousel<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  final List<int> flexWeights;
  final double? height;
  final bool itemSnapping;
  final bool consumeMaxWeight;
  final EdgeInsetsGeometry? padding;

  // 🔥 AutoPlay
  final bool autoPlay;
  final Duration autoPlayDuration;
  final bool loop;

  final AppCarouselController? controller;

  const AppWeightedCarousel({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.flexWeights,
    this.height,
    this.itemSnapping = true,
    this.consumeMaxWeight = true,
    this.padding,
    this.autoPlay = false,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.loop = true,
    this.controller,
  });

  @override
  State<AppWeightedCarousel<T>> createState() => _AppWeightedCarouselState<T>();
}

class _AppWeightedCarouselState<T> extends State<AppWeightedCarousel<T>> {
  late final AppCarouselController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? AppCarouselController(initialIndex: 0);

    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.startAutoPlay(
          itemCount: widget.items.length,
          duration: widget.autoPlayDuration,
          loop: widget.loop,
        );
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) => _controller.stopAutoPlay(),
      onPanEnd: (_) {
        if (widget.autoPlay) {
          _controller.startAutoPlay(
            itemCount: widget.items.length,
            duration: widget.autoPlayDuration,
            loop: widget.loop,
          );
        }
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.height ?? 250),
        child: CarouselView.weighted(
          controller: _controller.controller,
          flexWeights: widget.flexWeights,
          itemSnapping: widget.itemSnapping,
          consumeMaxWeight: widget.consumeMaxWeight,
          onTap: (index) {
            _controller.updateIndex(index);
          },
          children: List.generate(
            widget.items.length,
            (index) => Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.itemBuilder(context, widget.items[index], index),
            ),
          ),
        ),
      ),
    );
  }
}

// AppWeightedCarousel<ImageInfo>(
// height: 300,
// flexWeights: const [2, 7, 2],
// items: ImageInfo.values,
// autoPlay: true,
// autoPlayDuration: const Duration(seconds: 2),
// loop: true,
// itemBuilder: (context, image, index) {
// return HeroLayoutCard(imageInfo: image);
// },
// )

// class HeroLayoutCard extends StatelessWidget {
//   const HeroLayoutCard({super.key, required this.imageInfo});
//
//   final ImageInfo imageInfo;
//
//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.sizeOf(context).width;
//     return Stack(
//       alignment: AlignmentDirectional.bottomStart,
//       children: <Widget>[
//         ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: OverflowBox(
//             maxWidth: width * 7 / 8,
//             minWidth: width * 7 / 8,
//             child: Image(
//               fit: BoxFit.cover,
//               image: NetworkImage(
//                 'https://flutter.github.io/assets-for-api-docs/assets/material/${imageInfo.url}',
//               ),
//             ),
//           ),
//         ),
//         // Padding(
//         //   padding: const EdgeInsets.all(18.0),
//         //   child: Column(
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     mainAxisSize: MainAxisSize.min,
//         //     spacing: 8,
//         //     children: <Widget>[
//         //       Text(
//         //         imageInfo.title,
//         //         overflow: TextOverflow.clip,
//         //         softWrap: false,
//         //         style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//         //           color: Colors.white,
//         //           fontWeight: FontWeight.bold,
//         //           shadows: <Shadow>[
//         //             Shadow(
//         //               offset: Offset(1.0, 1.0),
//         //               blurRadius: 5.0,
//         //               color: Color.fromARGB(180, 0, 0, 0),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //       Text(
//         //         imageInfo.subtitle,
//         //         overflow: TextOverflow.clip,
//         //         softWrap: false,
//         //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//         //           color: Colors.white,
//         //           fontWeight: FontWeight.bold,
//         //           shadows: <Shadow>[
//         //             Shadow(
//         //               offset: Offset(1.0, 1.0),
//         //               blurRadius: 5.0,
//         //               color: Color.fromARGB(180, 0, 0, 0),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

// const ImageInfo(this.title, this.subtitle, this.url);
//
// final String title;
// final String subtitle;
// final String url;
