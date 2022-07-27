class Videos {
  final String tags;
  final String pictureId;
  final String thumbnailSize = '200x150';
  Map<String, dynamic> videos;

  Videos({
    required this.videos,
    required this.tags,
    required this.pictureId,
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
        videos: json['videos'] as Map<String, dynamic>,
        tags: json['tags'] as String,
        pictureId: json['pictureId'] as String
    );
  }
}
