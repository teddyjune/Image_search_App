import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:image_search_app/model/picture.dart';

class PictureApi {
  //생성되자마자 빈 데이터 호출
PictureApi() {
fetchImages('');
}
final _imagesStreamController = StreamController<List<Picture>>();

Stream<List<Picture>> get imageStream => _imagesStreamController.stream;

Future fetchImages(String query) async {
  List<Picture> images = await getImages(query);
  _imagesStreamController.add(images);
}
  Future<List<Picture>> getImages(String query) async {
    Uri url = Uri.parse(
        'https://pixabay.com/api/?key=10711147-dc41758b93b263957026bdadb&q=$query&image_type=photo');
    http.Response response = await http.get(url);

    String jsonString = response.body;

    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable hits = json['hits'];
    return hits.map((e) => Picture.fromJson(e)).toList();
  }
}
