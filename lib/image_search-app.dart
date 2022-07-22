import 'dart:convert';

import 'package:flutter/material.dart';

import 'mock_data/images.dart';
import 'picture.dart';

class ImageSearchApp extends StatelessWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          '이미지 검색 앱',
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
            child: const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: Icon(Icons.search),
                  hintText: '검색어를 입력하세요',
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Picture>>(
                future: getImages(),
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
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          image.previewURL,
                          fit: BoxFit.cover,
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

Future<List<Picture>> getImages() async {
  await Future.delayed(const Duration(seconds: 2));

  String jsonString = images;

  Map<String, dynamic> json = jsonDecode(jsonString);
  Iterable hits = json['hits'];
  return hits.map((e) => Picture.fromJson(e)).toList();
}
