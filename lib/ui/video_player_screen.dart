import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/videos.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Videos video;

  const VideoPlayerScreen({required this.video, Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // VideoPlayerController를 저장하기 위한 변수를 만듭니다. VideoPlayerController는
    // asset, 파일, 인터넷 등의 영상들을 제어하기 위해 다양한 생성자를 제공합니다.
    _controller = VideoPlayerController.network(widget.video.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
              // VideoPlayer의 종횡비를 제한하세요.
              return Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // 영상을 보여주기 위해 VideoPlayer 위젯을 사용합니다.
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // 영상이 재생 중이라면, 일시 중지 시킵니다.
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                              _controller.play();
                            }
                          });
                        },
                        child: VideoPlayer(_controller)),
                  ),
                  const Icon(
                    Icons.play_circle,
                    size: 80,
                  ),
                ],
              );
            } else {
              // 만약 VideoPlayerController가 여전히 초기화 중이라면,
              // 로딩 스피너를 보여줍니다.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
