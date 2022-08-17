class Videos {
  final String tags;
  final String videoUrl;
  final String thumbnail;

  Videos({
    required this.tags,
    required this.videoUrl,
    required this.thumbnail,
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    String pictureId = json['picture_id'] as String;
    return Videos(
      videoUrl: json['videos']['large']['url'] as String,
      thumbnail: 'https://i.vimeocdn.com/video/${pictureId}_295x166.jpg',
      tags: json['tags'] as String,
    );
  }
}
