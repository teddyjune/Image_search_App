import 'package:flutter/material.dart';
import 'package:image_search_app/api/picture_api.dart';
import 'package:image_search_app/model/picture.dart';

class ImageSearchViewModel extends ChangeNotifier {
  final _pictureApi = PictureApi();
  List<Picture> images = [];

  void fetchImages(String query) async {
    images = await _pictureApi.fetchImages(query);
    notifyListeners();
  }
}
