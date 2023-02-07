import 'package:flutter/material.dart';
import 'package:videove/ui/single_video_screen.dart';
import 'package:videove/ui/videos_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VideosListScreen(),
    );
  }
}
