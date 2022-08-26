import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/photo.dart';
import 'package:image_search_app/data/repository/photo_repository.dart';
import 'package:image_search_app/ui/image_search/main_action.dart';
import 'package:image_search_app/ui/main_state.dart';

class ImageSearchViewModel extends ChangeNotifier {
  //데이터 저장소
  late final PhotoRepository _photoRepository;
  MainState _state = const MainState();

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
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _photoRepository.getImages(query);
    result.when(success: (photos) {
      _state = state.copyWith(
        photos: photos,
        isLoading: false,
      );
      notifyListeners();
    }, error: (message) {
      _state = state.copyWith(
        photos: [], //에러가 났을 때 데이터를 날린다.
        isLoading: false,
      );
      notifyListeners();
      print('error!! : $message'); //에러 메시지를 그대로 띄운다.
    });
  }
}
