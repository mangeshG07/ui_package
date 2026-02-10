import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;

  const AppNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
      const Icon(Icons.broken_image),
      loadingBuilder: (_, child, progress) =>
      progress == null ? child : const CircularProgressIndicator(),
    );
  }
}
