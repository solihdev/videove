import 'package:flutter/material.dart';
import 'package:videove/data/models/video_player_model.dart';
import 'package:videove/ui/single_video_screen.dart';

class VideosListScreen extends StatelessWidget {
  const VideosListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<VideoPlayerModel> list = [
      VideoPlayerModel(
          thumbImages: "",
          videoName: "Qush",
          videoUrl:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
      VideoPlayerModel(thumbImages: "", videoName: "2", videoUrl: ""),
      VideoPlayerModel(thumbImages: "", videoName: "3", videoUrl: ""),
      VideoPlayerModel(thumbImages: "", videoName: "4", videoUrl: ""),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("All videos screen"),
      ),
      body: ListView(
        children: [
          ...List.generate(list.length, (index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleVideoScreen(
                              videoUrl: list[index].videoUrl,
                            )));
              },
              title: Text(list[index].videoName),
            );
          })
        ],
      ),
    );
  }
}
