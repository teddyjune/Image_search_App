import 'package:flutter/material.dart';

import '../api/picture_api.dart';
import '../model/picture.dart';

class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  State<ImageSearchApp> createState() => _ImageSearchAppState();
}

class _ImageSearchAppState extends State<ImageSearchApp> {
  final _pictureApi = PictureApi();
  final _controller = TextEditingController();
  String _query = '';

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
        title: const Text(
          '이미지 검색',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _pictureApi.fetchImages(_controller.text);
                      },
                      child: const Icon(Icons.search)),
                  hintText: '검색어를 입력하세요',
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Picture>>(
                stream: _pictureApi.imageStream,
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('에러가 발생했습니다'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final images = snapshot.data!;

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
                    children: images.map((Picture image) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image.previewURL,
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
