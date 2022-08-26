// import 'package:flutter_test/flutter_test.dart';
// import 'package:image_search_app/data/model/photo.dart';
// import 'package:image_search_app/data/repository/photo_repository.dart';
// import 'package:image_search_app/ui/image_search/image_search_view_model.dart';
// import 'package:image_search_app/ui/image_search/main_action.dart';
//
// void main() {
//   test('이미지를 가져오는 기능', () async {
//     final viewModel =
//         ImageSearchViewModel(photoRepository: MockPhotoRepository());
//     viewModel.onAction(const MainAction.getImages('query'));
//     await Future.delayed(const Duration(seconds: 2));
//
//     expect(viewModel.state.photos.length, 3);
//     expect(viewModel.state.photos.first.tags, 'google');
//   });
// }
//
// class MockPhotoRepository implements PhotoRepository  {
//   @override
//   Future<List<Photo>> getImages(String query) async {
//     return const [
//       Photo(
//         previewURL: "http://www.google.com",
//         tags: 'google',
//       ),
//       Photo(
//         previewURL: "http://www.facebook.com",
//         tags: 'facebook',
//       ),
//       Photo(
//         previewURL: "http://www.kakao.com",
//         tags: 'kakao',
//       ),
//     ];
//   }
// }
