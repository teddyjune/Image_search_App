import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search_app/videos.dart';

class VideoApi {
  Future<List<Videos>> getVideos(String query) async {
    Uri url = Uri.parse(
        'https://pixabay.com/api/videos/?key=10711147-dc41758b93b263957026bdadb&q=$query');
    http.Response response = await http.get(url);

    String jsonString = response.body;

    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable hits = json['hits'];
    return hits.map((e) => Videos.fromJson(e)).toList();
  }
}
