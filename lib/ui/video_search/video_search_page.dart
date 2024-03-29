import 'package:flutter/material.dart';

import '../../data/model/videos.dart';
import '../../data/repository/video_api.dart';
import '../video_player_screen.dart';
import 'components/video_thumbnail.dart';

class VideoSearchPage extends StatefulWidget {
  const VideoSearchPage({Key? key}) : super(key: key);

  @override
  State<VideoSearchPage> createState() => _VideoSearchPageState();
}

class _VideoSearchPageState extends State<VideoSearchPage> {
  final _videoApi = VideoApi();
  final _textController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '비디오 검색',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _query = _textController.text;
                        });
                      },
                      child: const Icon(Icons.search)),
                  hintText: '검색어를 입력하세요',
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Videos>>(
                future: _videoApi.getVideos(_query),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('에러가 발생했습니다'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text('검색결과 : 0'),
                    );
                  }
                  final videos = snapshot.data!;

                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 4,
                    ),
                    children: videos.where((e) => e.tags.contains(_query))
                        //검색창에 친 글자를 데이터의 tags에서 찾아주는 기능
                        .map((Videos video) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VideoPlayerScreen(video: video)),
                          );
                        },
                        child: VideoThumbnail(video),
                      );
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
