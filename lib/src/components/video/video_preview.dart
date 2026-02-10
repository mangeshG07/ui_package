import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A widget to preview a video file with play/pause functionality.
/// Auto-hides play button after 2 seconds of playing.
class VideoPreviewWidget extends StatefulWidget {
  /// The video file to preview
  final File file;

  /// Optional: radius of play/pause button
  final double playButtonRadius;

  /// Optional: loop video
  final bool loop;

  /// Optional: background color of the play/pause button
  final Color playButtonBackgroundColor;

  const VideoPreviewWidget({
    super.key,
    required this.file,
    this.playButtonRadius = 28,
    this.loop = true,
    this.playButtonBackgroundColor = const Color.fromRGBO(0, 0, 0, 0.5),
  });

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  late VideoPlayerController _controller;
  bool _showPlayPause = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (mounted) setState(() {});
      })
      ..setLooping(widget.loop);

    _controller.addListener(() {
      if (_controller.value.isPlaying && _showPlayPause) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _showPlayPause = false);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showPlayPause = true;
      } else {
        _controller.play();
        _showPlayPause = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          AnimatedOpacity(
            opacity: _showPlayPause ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: CircleAvatar(
              radius: widget.playButtonRadius,
              backgroundColor: widget.playButtonBackgroundColor,
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: widget.playButtonRadius * 1.4,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
