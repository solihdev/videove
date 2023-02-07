import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleVideoScreen extends StatefulWidget {
   SingleVideoScreen({Key? key,required this.videoUrl}) : super(key: key);

  String videoUrl;

  @override
  State<SingleVideoScreen> createState() => _SingleVideoScreenState();
}

class _SingleVideoScreenState extends State<SingleVideoScreen> {
  late VideoPlayerController _controller;
  double currentDuration = 0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.videoUrl)
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
        mainAxisAlignment: MainAxisAlignment.center,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed:(){
                currentDuration -= 1000;
                _controller
                    .seekTo(Duration(milliseconds: currentDuration.toInt()));
              },icon:const Icon(Icons.exposure_minus_1_sharp)),
              IconButton(onPressed:(){
                currentDuration += 1000;
                _controller
                    .seekTo(Duration(milliseconds: currentDuration.toInt()));
              },icon:const Icon(Icons.add)),
            ],
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
