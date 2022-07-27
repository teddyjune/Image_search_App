import 'package:flutter/material.dart';
import 'package:image_search_app/image_search_app/image_search-app.dart';

class ImageSearchPage extends StatefulWidget {
  const ImageSearchPage({Key? key}) : super(key: key);

  @override
  State<ImageSearchPage> createState() => _ImageSearchPageState();
}

class _ImageSearchPageState extends State<ImageSearchPage> {
  @override
  Widget build(BuildContext context) {
    return const ImageSearchApp();
  }
}
