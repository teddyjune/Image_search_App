import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/model/photo.dart';

class PhotoRepository {
  final _api = PixabayApi();

  Future<List<Photo>> getImages(String query) async {
    return await _api.getImages(query);
  }
}
