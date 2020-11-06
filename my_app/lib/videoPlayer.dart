import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/mirai.mp4');
    _controller.initialize().then((_) {
      setState(() {});//AspectRatio反映のため
      _controller.play();
      _listener = () {
        if (!_controller.value.isPlaying) {
          Navigator.of(context).pop();
        }
      };
      _controller.addListener(_listener);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
