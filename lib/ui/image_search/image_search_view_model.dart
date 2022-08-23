import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/photo.dart';
import 'package:image_search_app/data/repository/photo_repository.dart';

class ImageSearchViewModel extends ChangeNotifier {
  //데이터 저장소
  final _photoRepository = PhotoRepository();

  //데이터
  List<Photo> photos = [];

  //로딩
  bool isLoading = false;

  void fetchImages(String query) async {

    isLoading = true;
    notifyListeners();

    photos = await _photoRepository.getImages(query);
    isLoading = false;
    notifyListeners();
  }
}
