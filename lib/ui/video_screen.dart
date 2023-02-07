import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  double currentDuration = 0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
    _controllerObserver();
  }

  _controllerObserver() {
    _controller.addListener(() {
      currentDuration = _controller.value.position.inMilliseconds.toDouble();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Screen"),
      ),
      body: Column(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
          Slider(
            max: _controller.value.duration.inMilliseconds.toDouble(),
            value: currentDuration,
            onChanged: (v) {
              _controller.seekTo(Duration(milliseconds: v.toInt()));
              setState(() {});
            },
          ),
          TextButton(
            onPressed: () {
              currentDuration += 1000;
              _controller
                  .seekTo(Duration(milliseconds: currentDuration.toInt()));
            },
            child: const Text("+1 sekond"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
