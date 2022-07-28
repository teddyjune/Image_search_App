import 'package:flutter/material.dart';
import 'package:image_search_app/model/videos.dart';

class VideoThumbnail extends StatelessWidget {
  final Videos video;

  const VideoThumbnail(
    this.video, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              video.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Icon(
          Icons.play_circle,
          size: 50,
        ),
      ],
    );
  }
}
