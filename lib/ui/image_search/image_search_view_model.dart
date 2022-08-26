import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/photo.dart';
import 'package:image_search_app/data/repository/photo_repository.dart';
import 'package:image_search_app/ui/image_search/main_action.dart';
import 'package:image_search_app/ui/main_state.dart';

class ImageSearchViewModel extends ChangeNotifier {
  //데이터 저장소
  late final PhotoRepository _photoRepository;
  final MainState _state = const MainState();

  MainState get state => _state; //데이터

  List<Photo> photos = [];

  //로딩
  bool isLoading = false;

  void onAction(MainAction action) {
    action.when(
      getImages: (query) {
        fetchImages(query);
      },
    );
  }

  void fetchImages(String query) async {
    isLoading = true;
    notifyListeners();

    photos = await _photoRepository.getImages(query);
    isLoading = false;
    notifyListeners();
  }
}
