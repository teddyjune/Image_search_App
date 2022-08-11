import 'package:flutter/material.dart';
import 'package:image_search_app/api/picture_api.dart';
import 'package:image_search_app/model/picture.dart';

class ImageSearchViewModel extends ChangeNotifier {
  //데이터 저장소
  final _pictureApi = PictureApi();

  //데이터
  List<Picture> images = [];

  //로딩
  bool isLoading = false;

  void fetchImages(String query) async {
    isLoading = true;
    notifyListeners();

    images = await _pictureApi.getImages(query);
    isLoading = false;
    notifyListeners();
  }
}
