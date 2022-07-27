import 'package:flutter/material.dart';
import 'package:image_search_app/image_search_app/video_api.dart';
import 'package:image_search_app/image_search_app/videos.dart';

class VideoSearchPage extends StatefulWidget {
  const VideoSearchPage({Key? key}) : super(key: key);

  @override
  State<VideoSearchPage> createState() => _VideoSearchPageState();
}

class _VideoSearchPageState extends State<VideoSearchPage> {
  final _videoApi = VideoApi();
  final _controller = TextEditingController();
  String _query = '';

  // VideoPlayerController _controller;
  // Future<void> _initializeVideoPlayerFuture;

  // @override
  // void initState() {
  //   _controller = VideoPlayerController.network(
  //     'https://pixabay.com/api/videos/',
  //   );
  //   _initializeVideoPlayerFuture = _controller.initialize();
  //   _controller.setLooping(true);
  //   super.initState();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          '비디오 검색',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: 56,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _query = _controller.text;
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
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('에러가 발생했습니다'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final videos = snapshot.data!;

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('데이터가 없습니다'),
                    );
                  }

                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: videos.where((e) => e.tags.contains(_query))
                        //검색창에 친 글자를 데이터의 tags에서 찾아주는 기능
                        .map((Videos video) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://i.vimeocdn.com/video/${video.pictureId}_${video.thumbnailSize}.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
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
